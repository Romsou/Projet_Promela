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
#define RESET 5

// Structure nommée représentant un coup (coordonnées de la case d'arrivée +
// direction par laquelle le pion va arriver)
typedef Move {
  byte line_number = 3
  byte column_number = 3
  byte direction = RESET
};

typedef Hole {
  byte line
  byte column
  byte seen
}

// Canal par RDV, indique au joueur quand le buffer a fini
// d'être rempli.
chan ready = [0] of { bool }

// Buffer de production-consommation pour les cases libres
// Le nombre de cases vide peut-être égal à la taille du plateau -1
chan free_holes = [36] of { Hole }

// Canal par RDV, permettant au joueur d'envoyer au plateau le coup à jouer
chan move_to_play = [0] of { Move }

typedef Matrix {
  byte column[7] = 1
};

Matrix matrix[7];

// Plateau européen par défaut pour commencer le travail
// TODO: Générer la matrice ou le processus à la volée
byte first_hole_line = 2;
byte first_hole_column = 3;
byte number_pegs = 36;

Move to_send_move;
Move current_move;
Hole hole;

// Processus correspondant au Plateau
// Ce processus doit:
// - Attendre un triplet x, y, direction
// - Si le mouvement est valide on modifie le plateau et on transmet les
//   cases libres générées.
proctype board() {
    ready!1;
    wait_move : atomic {
      move_to_play?current_move ->
         if
         ::(current_move.direction == UP) ->
            printf("Playing [%d,%d,UP]",current_move.line_number,current_move.column_number);
            matrix[current_move.line_number-2].column[current_move.column_number] = 0;
            matrix[current_move.line_number-1].column[current_move.column_number] = 0;
            matrix[current_move.line_number].column[current_move.column_number] = 1;
            hole.column = current_move.column_number;
            hole.line = current_move.line_number-1;
            free_holes!hole;
            hole.line = current_move.line_number-2;
            free_holes!hole;
            number_pegs = number_pegs - 1;
            printf("Move played, moving to next one\n");
            to_send_move.direction = RESET;
            ready!1; goto wait_move;
         ::(current_move.direction == DOWN) ->
            printf("Playing [%d,%d,DOWN]",current_move.line_number,current_move.column_number);
            matrix[current_move.line_number+2].column[current_move.column_number] = 0;
            matrix[current_move.line_number+1].column[current_move.column_number] = 0;
            matrix[current_move.line_number].column[current_move.column_number] = 1;
            hole.column = current_move.column_number;
            hole.line = current_move.line_number+1;
            free_holes!hole;
            hole.line = current_move.line_number+2;
            free_holes!hole;
            number_pegs = number_pegs - 1;
            printf("Move played, moving to next one\n");
            to_send_move.direction = RESET;
            ready!1; goto wait_move;
         ::(current_move.direction == LEFT) ->
            printf("Playing [%d,%d,LEFT]",current_move.line_number,current_move.column_number);
            matrix[current_move.line_number].column[current_move.column_number-2] = 0;
            matrix[current_move.line_number].column[current_move.column_number-1] = 0;
            matrix[current_move.line_number].column[current_move.column_number] = 1;
            hole.line = current_move.line_number;
            hole.column = current_move.column_number-1;
            free_holes!hole;
            hole.column = current_move.column_number-2;
            free_holes!hole;
            number_pegs = number_pegs - 1;
            printf("Move played, moving to next one\n");
            to_send_move.direction = RESET;
            ready!1; goto wait_move;
         ::(current_move.direction == RIGHT) ->
            printf("Playing [%d,%d,RIGHT]",current_move.line_number,current_move.column_number);
            matrix[current_move.line_number].column[current_move.column_number+2] = 0;
            matrix[current_move.line_number].column[current_move.column_number+1] = 0;
            matrix[current_move.line_number].column[current_move.column_number] = 1;
            hole.line = current_move.line_number;
            hole.column = current_move.column_number+1;
            free_holes!hole;
            hole.column = current_move.column_number+2;
            free_holes!hole;
            number_pegs = number_pegs - 1;
            printf("Move played, moving to next one\n");
            to_send_move.direction = RESET;
            ready!1; goto wait_move;
         fi
   }
}

// Processus correspondant au joueur
// Ce processus doit:
// - Lire une case libre de free_holes
// - Envoyer une direction au board.
proctype player() {
    wait_signal : atomic{ready?1;
    choose_hole : free_holes?hole ->
      printf("Hole selected : [%d,%d]\n",hole.line,hole.column);
      to_send_move.line_number = hole.line;
      to_send_move.column_number = hole.column;
      if
       :: (0<=to_send_move.line_number-2) -> printf("UP selected"); to_send_move.direction = UP;
       :: (to_send_move.line_number+2<board_height) -> printf("DOWN selected"); to_send_move.direction = DOWN;
       :: (0<=to_send_move.column_number-2) -> printf("LEFT selected"); to_send_move.direction = LEFT;
       :: (to_send_move.column_number+2<board_height) -> printf("RIGHT selected"); to_send_move.direction = RIGHT;
       :: (number_pegs == 1) -> goto end;
       :: else -> free_holes!hole; goto choose_hole;
      fi
    }
    atomic{
        printf("Move sent");
        move_to_play!to_send_move;
        to_send_move.direction = RESET;
        goto wait_signal;
    }
    end : skip;
}

init
{
  atomic {
  to_send_move.line_number = 2;
  to_send_move.column_number = 2;
  matrix[0].column[0]=2;
  matrix[0].column[1]=2;
  matrix[0].column[2]=1;
  matrix[0].column[3]=1;
  matrix[0].column[4]=1;
  matrix[0].column[5]=2;
  matrix[0].column[6]=2;

  matrix[1].column[0]=2;
  matrix[1].column[1]=1;
  matrix[1].column[2]=1;
  matrix[1].column[3]=1;
  matrix[1].column[4]=1;
  matrix[1].column[5]=1;
  matrix[1].column[6]=2;

  matrix[2].column[0]=1;
  matrix[2].column[1]=1;
  matrix[2].column[2]=1;
  matrix[2].column[3]=0;
  matrix[2].column[4]=1;
  matrix[2].column[5]=1;
  matrix[2].column[6]=1;

  matrix[3].column[0]=1;
  matrix[3].column[1]=1;
  matrix[3].column[2]=1;
  matrix[3].column[3]=1;
  matrix[3].column[4]=1;
  matrix[3].column[5]=1;
  matrix[3].column[6]=1;

  matrix[4].column[0]=1;
  matrix[4].column[1]=1;
  matrix[4].column[2]=1;
  matrix[4].column[3]=1;
  matrix[4].column[4]=1;
  matrix[4].column[5]=1;
  matrix[4].column[6]=1;

  matrix[5].column[0]=2;
  matrix[5].column[1]=1;
  matrix[5].column[2]=1;
  matrix[5].column[3]=1;
  matrix[5].column[4]=1;
  matrix[5].column[5]=1;
  matrix[5].column[6]=2;

  matrix[6].column[0]=2;
  matrix[6].column[1]=2;
  matrix[6].column[2]=1;
  matrix[6].column[3]=1;
  matrix[6].column[4]=1;
  matrix[6].column[5]=2;
  matrix[6].column[6]=2;
  hole.line = first_hole_line; hole.column = first_hole_column;
  free_holes!hole;
  }
  atomic{run board(); run player();}
}

/* Formule LTL exploitant les possibilités de spin 6 */
ltl formulae { !(((to_send_move.direction == UP -> (matrix[to_send_move.line_number-2].column[to_send_move.column_number] == 1 && matrix[to_send_move.line_number-1].column[to_send_move.column_number] == 1)) &&
                  (to_send_move.direction == DOWN -> (matrix[to_send_move.line_number+2].column[to_send_move.column_number] == 1 && matrix[to_send_move.line_number+1].column[to_send_move.column_number] == 1)) &&
                  (to_send_move.direction == LEFT -> (matrix[to_send_move.line_number].column[to_send_move.column_number-2] == 1 && matrix[to_send_move.line_number].column[to_send_move.column_number-1] == 1)) &&
                  (to_send_move.direction == RIGHT -> (matrix[to_send_move.line_number].column[to_send_move.column_number+2] == 1 && matrix[to_send_move.line_number].column[to_send_move.column_number+1] == 1)))U(number_pegs == 1))}
