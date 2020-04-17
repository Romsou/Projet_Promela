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

// Canal par RDV, indique au joueur quand le buffer a fini
// d'être rempli.
chan ready = [0] of { short }

// Buffer de production-consommation pour les cases libres
// Le nombre de cases vide peut-être égal à la taille du plateau -1
chan free_holes = [] of { int }

// Processus correspondant au Plateau
// Ce processus doit:
// - Attendre un triplet x, y, direction
// - Si le mouvement est valide on modifie le plateau et on transmet les
//   cases libres générées.
proctype board() {
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


}

// Processus correspondant au joueur
// Ce processus doit:
// - Lire une case libre de free_holes
// - Envoyer une direction au board.
// - Si le board envoie un signal de fin, alors le jeu est fini
proctype player() {

}
