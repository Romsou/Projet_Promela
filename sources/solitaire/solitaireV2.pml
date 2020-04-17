/*********************************************
*    Programme Promela du solitaireV2        *
*                                            *
*    Auteurs: Adrien Mollet                  *
*             Romain Soumard                 *
*                                            *
*********************************************/

// Taille par défaut du plateau
int board_height = 7;
int board_width = 7;

// Constante de directions pour les coups a joueur
#define UP 0
#define DOWN 1
#define LEFT 2
#define RIGHT 3

// Structure nommée représentant un coup (coordonnées de la case d'arrivée +
// direction par laquelle le pion va arriver)
typedef Move {
  byte line_number
  byte column_number
  byte direction
};

// Canal par RDV, indique au joueur quand le buffer a fini
// d'être rempli.
chan ready = [0] of { bool }

// Buffer de production-consommation pour les cases libres
// Le nombre de cases vide peut-être égal à la taille du plateau -1
chan free_holes = [36] of { byte, byte }

// Canal par RDV, permettant au joueur d'envoyer au plateau le coup à jouer
chan move_to_play = [0] of { Move }

typedef Matrix {
  byte column[7] = 2
};

// Plateau européen par défaut pour commencer le travail
// TODO: Générer la matrice ou le processus à la volée
short matrix[board_width][board_height] = {
  2, 2, 1, 1, 1, 2, 2,
  2, 1, 1, 1, 1, 1, 2,
  1, 1, 1, 0, 1, 1, 1,
  1, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 1, 1, 1, 1,
  2, 1, 1, 1, 1, 1, 2,
  2, 2, 1, 1, 1, 2, 2,
}
byte first_hole_line = 2;
byte first_hole_column = 3;
byte number_pegs = 36;

// Processus correspondant au Plateau
// Ce processus doit:
// - Attendre un triplet x, y, direction
// - Si le mouvement est valide on modifie le plateau et on transmet les
//   cases libres générées.
proctype board() {
    Move current_move;
    free_holes!(first_hole_line,first_hole_column);
    wait_move : atomic{move_to_play?current_move ->
     if
     ::(current_move.direction == UP &&
        matrix[current_move.line_number-2][current_move.column_number] == 1 &&
        matrix[current_move.line_number-1][current_move.column_number] == 1) ->
        matrix[current_move.line_number-2][current_move.column_number] = 0;
        matrix[current_move.line_number-1][current_move.column_number] = 0;
        matrix[current_move.line_number][current_move.column_number] = 1;
        free_holes!(current_move.line_number-2,current_move.column_number);
        free_holes!(current_move.line_number-1,current_move.column_number);
        number_pegs = number_pegs - 2;
        ready!1; goto wait_move;
     ::(current_move.direction == DOWN &&
        matrix[current_move.line_number+2][current_move.column_number] == 1 &&
        matrix[current_move.line_number+1][current_move.column_number] == 1) ->
        matrix[current_move.line_number+2][current_move.column_number] = 0;
        matrix[current_move.line_number+1][current_move.column_number] = 0;
        matrix[current_move.line_number][current_move.column_number] = 1;
        free_holes!(current_move.line_number+2,current_move.column_number);
        free_holes!(current_move.line_number+1,current_move.column_number);
        number_pegs = number_pegs - 2;
        ready!1; goto wait_move;
     ::(current_move.direction == LEFT &&
        matrix[current_move.line_number][current_move.column_number-2] == 1 &&
        matrix[current_move.line_number][current_move.column_number-1] == 1) ->
        matrix[current_move.line_number][current_move.column_number-2] = 0;
        matrix[current_move.line_number][current_move.column_number-1] = 0;
        matrix[current_move.line_number][current_move.column_number] = 1;
        free_holes!(current_move.line_number,current_move.column_number-2);
        free_holes!(current_move.line_number,current_move.column_number-1);
        number_pegs = number_pegs - 2;
        ready!1; goto wait_move;
     ::(current_move.direction == RIGHT &&
        matrix[current_move.line_number][current_move.column_number+2] == 1 &&
        matrix[current_move.line_number][current_move.column_number+1] == 1) ->
        matrix[current_move.line_number][current_move.column_number+2] = 0;
        matrix[current_move.line_number][current_move.column_number+1] = 0;
        matrix[current_move.line_number][current_move.column_number] = 1;
        free_holes!(current_move.line_number,current_move.column_number+2);
        free_holes!(current_move.line_number,current_move.column_number+1);
        number_pegs = number_pegs - 2;
        ready!1; goto wait_move;
     ::else -> ready!1; goto wait_move;
     fi
       }
}

// Processus correspondant au joueur
// Ce processus doit:
// - Lire une case libre de free_holes
// - Envoyer une direction au board.
proctype player() {
    Move to_send_move;
    byte line; byte column;
    wait_signal : ready?1
    atomic{ free_holes?(line,column) ->
      to_send_move.line_number = line;
      to_send_move.column_number = column;
      if
      :: to_send_move.direction = UP;
      :: to_send_move.direction = DOWN;
      :: to_send_move.direction = LEFT;
      :: to_send_move.direction = RIGHT;
      fi
      move_to_play!to_send_move;
      goto wait_signal;
    }
}

init
{
  atomic{run board(); run player();}
}
