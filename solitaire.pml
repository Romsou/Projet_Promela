/* Modèle Promela du jeu de solitaire européen */
typedef matrix {
  byte column[7] = 2
};

typedef position{
  byte line_number;
  byte column_number;
}

typedef move {
  position source;
  position jumped;
  position destination;
}

chan board_ready = [0] of {bool}
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
    :: (line_cpt>=7) -> atomic{board_ready!1 ; goto preparation_completed;}
  od
  preparation_completed : atomic{line[2].column[3] = 0; printf("BOARD READY\n");}
}

proctype case(byte line_pos, byte column_pos){
  if
  :: (line_pos-2 >= 0 && line[line_pos].column[column_pos] == 1 && line[line_pos-1].column[column_pos] == 1 && line[line_pos-2].column[column_pos] == 0);
      atomic{
        move ok_move;
        ok_move.source.line_number = line_pos;
        ok_move.source.column_number = column_pos;
        ok_move.jumped.line_number = line_pos-1;
        ok_move.jumped.column_number = column_pos;
        ok_move.destination.line_number = line_pos-2;
        ok_move.destination.column_number = column_pos;
        possible_move!ok_move;}
  :: (line_pos+2 < 7 && line[line_pos].column[column_pos] == 1 && line[line_pos+1].column[column_pos] == 1 && line[line_pos+2].column[column_pos] == 0);
      atomic{
        move ok_move;
        ok_move.source.line_number = line_pos;
        ok_move.source.column_number = column_pos;
        ok_move.jumped.line_number = line_pos+1;
        ok_move.jumped.column_number = column_pos;
        ok_move.destination.line_number = line_pos+2;
        ok_move.destination.column_number = column_pos;
        possible_move!ok_move;}
  :: (column_pos-2 >= 0 && line[line_pos].column[column_pos] == 1 && line[line_pos].column[column_pos-1] == 1 && line[line_pos].column[column_pos-2] == 0);
      atomic{
        move ok_move;
        ok_move.source.line_number = line_pos;
        ok_move.source.column_number = column_pos;
        ok_move.jumped.line_number = line_pos;
        ok_move.jumped.column_number = column_pos-1;
        ok_move.destination.line_number = line_pos;
        ok_move.destination.column_number = column_pos-2;
        possible_move!ok_move;}
  :: (column_pos+2 < 7 && line[line_pos].column[column_pos] == 1 && line[line_pos].column[column_pos+1] == 1 && line[line_pos].column[column_pos+2] == 0);
      atomic{
        move ok_move;
        ok_move.source.line_number = line_pos;
        ok_move.source.column_number = column_pos;
        ok_move.jumped.line_number = line_pos;
        ok_move.jumped.column_number = column_pos+1;
        ok_move.destination.line_number = line_pos;
        ok_move.destination.column_number = column_pos+2;
        possible_move!ok_move;}
  fi
}

proctype setup_cases()
{
  byte line_cpt = 0
  byte column_cpt = 0
  if
  :: board_ready?1 ->
    atomic {
    do
      :: (line_cpt<7 && column_cpt<7 && line[line_cpt].column[column_cpt] != 2) -> atomic{run case(line_cpt,column_cpt); column_cpt = column_cpt+1;}
      :: (column_cpt>=7 && line_cpt<7) -> column_cpt = 0; line_cpt = line_cpt+1;
      :: (line_cpt>=7) -> goto setup_completed;
    od
    }
  fi
  setup_completed : atomic{ game_ready!1; printf("Setup Completed : The game can start !");}
}

proctype player()
{
  do
  :: move to_do_move; possible_move?to_do_move -> atomic{
    line[to_do_move.source.line_number].column[to_do_move.source.column_number] = 0;
    line[to_do_move.jumped.line_number].column[to_do_move.jumped.column_number] = 0;
    line[to_do_move.destination.line_number].column[to_do_move.destination.column_number] = 1;
    printf("Move [%d,%d] -> [%d,%d] done",to_do_move.source.line_number,to_do_move.source.column_number,to_do_move.destination.line_number,to_do_move.destination.column_number);
  }
  od
}

init
{
  run prepare_game();
  run setup_cases();
  if
  :: game_ready?1 -> run player()
  fi
}
