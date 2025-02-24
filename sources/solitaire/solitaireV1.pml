/* Modèle Promela du jeu de solitaire européen */
typedef Matrix {
  byte column[7] = 2
};

typedef Position {
  byte line_number
  byte column_number
};

typedef Move {
  Position source
  Position jumped
  Position destination
};

chan board_ready = [0] of {bool}
chan game_ready = [0] of {bool}
chan possible_move = [0] of {Move}
byte number_pegs = 0
bool currently_playing = 0

Matrix line[7];

proctype prepare_game()
{
  byte line_cpt = 0;
  byte column_cpt = 0;
  do
    :: (line_cpt<7 && column_cpt<7);
        if
        :: (line_cpt == 0 && (column_cpt == 0 || column_cpt == 1 || column_cpt == 5 || column_cpt == 6)) -> line[line_cpt].column[column_cpt] = 2;
        :: (line_cpt == 1 && (column_cpt == 0 || column_cpt == 6)) -> line[line_cpt].column[column_cpt] = 2;
        :: (line_cpt == 5 && (column_cpt == 0 || column_cpt == 6)) -> line[line_cpt].column[column_cpt] = 2;
        :: (line_cpt == 6 && (column_cpt == 0 || column_cpt == 1 || column_cpt == 5 || column_cpt == 6)) -> line[line_cpt].column[column_cpt] = 2;
        :: else -> line[line_cpt].column[column_cpt] = 1; number_pegs = number_pegs + 1;
        fi;
        printf("Value = %d\n",line[line_cpt].column[column_cpt]);
        column_cpt = column_cpt+1;
    :: (column_cpt>=7 && line_cpt<7) -> column_cpt = 0; line_cpt = line_cpt+1; printf("RESET COLUMN\n")
    :: (line_cpt>=7) -> atomic{board_ready!1 ; goto preparation_completed;}
  od
  preparation_completed : atomic{line[2].column[3] = 0; printf("BOARD READY\n");}
  end : skip;
};

proctype playable_case(byte line_pos; byte column_pos){
  do
  ::if
    :: atomic{(line_pos-2 >= 0 && line[line_pos].column[column_pos] == 1 && line[line_pos-1].column[column_pos] == 1 && line[line_pos-2].column[column_pos] == 0);
          Move ok_move;
          ok_move.source.line_number = line_pos;
          ok_move.source.column_number = column_pos;
          ok_move.jumped.line_number = line_pos-1;
          ok_move.jumped.column_number = column_pos;
          ok_move.destination.line_number = line_pos-2;
          ok_move.destination.column_number = column_pos;
          possible_move!ok_move;}
    :: atomic{(line_pos+2 < 7 && line[line_pos].column[column_pos] == 1 && line[line_pos+1].column[column_pos] == 1 && line[line_pos+2].column[column_pos] == 0);
          Move ok_move;
          ok_move.source.line_number = line_pos;
          ok_move.source.column_number = column_pos;
          ok_move.jumped.line_number = line_pos+1;
          ok_move.jumped.column_number = column_pos;
          ok_move.destination.line_number = line_pos+2;
          ok_move.destination.column_number = column_pos;
          possible_move!ok_move;}
    :: atomic{(column_pos-2 >= 0 && line[line_pos].column[column_pos] == 1 && line[line_pos].column[column_pos-1] == 1 && line[line_pos].column[column_pos-2] == 0);
          Move ok_move;
          ok_move.source.line_number = line_pos;
          ok_move.source.column_number = column_pos;
          ok_move.jumped.line_number = line_pos;
          ok_move.jumped.column_number = column_pos-1;
          ok_move.destination.line_number = line_pos;
          ok_move.destination.column_number = column_pos-2;
          possible_move!ok_move;}
    :: atomic{(column_pos+2 < 7 && line[line_pos].column[column_pos] == 1 && line[line_pos].column[column_pos+1] == 1 && line[line_pos].column[column_pos+2] == 0);
          Move ok_move;
          ok_move.source.line_number = line_pos;
          ok_move.source.column_number = column_pos;
          ok_move.jumped.line_number = line_pos;
          ok_move.jumped.column_number = column_pos+1;
          ok_move.destination.line_number = line_pos;
          ok_move.destination.column_number = column_pos+2;
          possible_move!ok_move;}
    fi
  od
};

proctype setup_cases()
{
  byte line_cpt = 0;
  byte column_cpt = 0;
  if
  :: board_ready?1 -> printf("SETUP CASES\n");
    do
      :: (line_cpt<7 && column_cpt<7 && line[line_cpt].column[column_cpt] != 2) -> atomic{run playable_case(line_cpt,column_cpt); column_cpt = column_cpt+1;}
      :: (column_cpt>=7 && line_cpt<7) -> column_cpt = 0; line_cpt = line_cpt+1;
      :: (line_cpt>=7) -> goto setup_completed;
      :: else -> column_cpt = column_cpt+1;
    od
  fi
  setup_completed : atomic{game_ready!1; printf("Setup Completed : The game can start !\n");}
}

proctype player()
{
  printf("Player process is running !\n");
  currently_playing = 1;
  play_move : do
              :: Move to_do_move; atomic{possible_move?to_do_move;
                if
                ::(line[to_do_move.source.line_number].column[to_do_move.source.column_number] == 1 &&
                  line[to_do_move.jumped.line_number].column[to_do_move.jumped.column_number] == 1 &&
                  line[to_do_move.destination.line_number].column[to_do_move.destination.column_number] == 0) ->
                  atomic{
                  printf("Move [%d,%d] -> [%d,%d] done\n",to_do_move.source.line_number,to_do_move.source.column_number,to_do_move.destination.line_number,to_do_move.destination.column_number);
                  line[to_do_move.source.line_number].column[to_do_move.source.column_number] = 0;
                  line[to_do_move.jumped.line_number].column[to_do_move.jumped.column_number] = 0;
                  line[to_do_move.destination.line_number].column[to_do_move.destination.column_number] = 1;
                  number_pegs = number_pegs - 1;
                  }
                ::else -> printf("Move is discarded\n"); goto play_move;
                fi}
              od
};

init
{
  run prepare_game();
  run setup_cases();
  if
  :: game_ready?1 -> run player();
  fi
};

/* Formule LTL exploitant les possibilités de spin 6 */
ltl formulae { !<>(currently_playing == 1 && number_pegs == 1)}
