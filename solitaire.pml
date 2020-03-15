/* Modèle Promela du jeu de solitaire européen */
typedef matrix {
  byte column[7] = 2
};

typedef move {
  byte source_line;
  byte source_column;
  byte destination_line;
  byte destination_column;
}

chan game_ready = [0] of {bool}
chan possible_move = [0] of {move}

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
    :: (line_cpt>=7) -> atomic{game_ready!1 ; goto preparation_completed;}
  od
  preparation_completed : atomic{line[2].column[3] = 0; printf("BOARD READY\n");}
}

proctype case(byte line_pos, byte column_pos){
  if
  :: (line_pos-2 >= 0 && line[line_pos].column[column_pos] == 1 && line[line_pos-1].column[column_pos] == 1 && line[line_pos-2].column[column_pos] == 0);
      atomic{move ok_move; ok_move.source_line = line_pos; ok_move.source_column = column_pos; ok_move.destination_line = line_pos-2; ok_move.destination_column = column_pos; possible_move!ok_move;}
  :: (line_pos+2 < 7 && line[line_pos].column[column_pos] == 1 && line[line_pos+1].column[column_pos] == 1 && line[line_pos+2].column[column_pos] == 0);
      atomic{move ok_move; ok_move.source_line = line_pos; ok_move.source_column = column_pos; ok_move.destination_line = line_pos+2; ok_move.destination_column = column_pos; possible_move!ok_move;}
  :: (column_pos-2 >= 0 && line[line_pos].column[column_pos] == 1 && line[line_pos].column[column_pos-1] == 1 && line[line_pos].column[column_pos-2] == 0);
      atomic{move ok_move; ok_move.source_line = line_pos; ok_move.source_column = column_pos; ok_move.destination_line = line_pos; ok_move.destination_column = column_pos-2; possible_move!ok_move;}
  :: (column_pos+2 < 7 && line[line_pos].column[column_pos] == 1 && line[line_pos].column[column_pos+1] == 1 && line[line_pos].column[column_pos+2] == 0);
      atomic{move ok_move; ok_move.source_line = line_pos; ok_move.source_column = column_pos; ok_move.destination_line = line_pos; ok_move.destination_column = column_pos+2; possible_move!ok_move;}
  fi
}

init
{
  run prepare_game();
  if
  :: game_ready?1 -> run player()
  fi
}
