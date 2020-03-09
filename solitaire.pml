/* Modèle Promela du jeu de solitaire européen */
typedef matrix {
  byte column[7]
};

chan game_ready = [0] of {bool}

matrix line[7];

proctype prepare_game()
{
  byte line_cpt = 0
  byte column_cpt = 0
  do
    :: (line_cpt<7 && column_cpt<7);
        if
        :: (line_cpt == 0 && (column_cpt == 0 || column_cpt == 1 || column_cpt == 5 || column_cpt == 6)) -> line[line_cpt].column[column_cpt] = 2;
        :: (line_cpt == 1 && (column_cpt == 0 || column_cpt == 6)) -> line[line_cpt].column[column_cpt] = 2;
        :: (line_cpt == 5 && (column_cpt == 0 || column_cpt == 6)) -> line[line_cpt].column[column_cpt] = 2;
        :: (line_cpt == 6 && (column_cpt == 0 || column_cpt == 1 || column_cpt == 5 || column_cpt == 6)) -> line[line_cpt].column[column_cpt] = 2;
        :: else -> line[line_cpt].column[column_cpt] = 1;
        fi;
        printf("Value = %d\n",line[line_cpt].column[column_cpt]);
        column_cpt = column_cpt+1;
    :: (column_cpt>=7 && line_cpt<7) -> column_cpt = 0; line_cpt = line_cpt+1; printf("RESET COLUMN\n")
    :: (column_cpt>=7 && line_cpt==6) -> atomic{game_ready!1 ; goto preparation_completed;}
  od
  preparation_completed : skip;
}

init
{
  run prepare_game();
}
