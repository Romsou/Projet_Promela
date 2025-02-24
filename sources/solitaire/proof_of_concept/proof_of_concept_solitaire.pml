#define UP 0
#define RIGHT 1
#define DOWN 2
#define LEFT 3


chan ready = [0] of { bool };
chan move = [1] of { short, short, byte };

#define BOARD_SIZE 7
chan free_slot = [36] of { short, short };
int pegs = 36;

typedef Matrix {
	byte col[9] = 1
};

Matrix row[9];

init {
 	row[0].col[0] = 2;
	row[0].col[1] = 2;
	row[0].col[2] = 2;
	row[0].col[3] = 2;
	row[0].col[4] = 2;
	row[0].col[5] = 2;
	row[0].col[6] = 2;
	row[0].col[7] = 2;
	row[0].col[8] = 2;

	row[1].col[0] = 2;
	row[1].col[1] = 2;
	row[1].col[2] = 2;
	row[1].col[3] = 1;
	row[1].col[4] = 1;
	row[1].col[5] = 1;
	row[1].col[6] = 2;
	row[1].col[7] = 2;
	row[1].col[8] = 2;

	row[2].col[0] = 2;
	row[2].col[1] = 2;
	row[2].col[2] = 1;
	row[2].col[3] = 1;
	row[2].col[4] = 1;
	row[2].col[5] = 1;
	row[2].col[6] = 1;
	row[2].col[7] = 2;
	row[2].col[8] = 2;

	row[3].col[0] = 2;
	row[3].col[1] = 1;
	row[3].col[2] = 1;
	row[3].col[3] = 1;
	row[3].col[4] = 0;
	row[3].col[5] = 1;
	row[3].col[6] = 1;
	row[3].col[7] = 1;
	row[3].col[8] = 2;

	row[4].col[0] = 2;
	row[4].col[1] = 1;
	row[4].col[2] = 1;
	row[4].col[3] = 1;
	row[4].col[4] = 1;
	row[4].col[5] = 1;
	row[4].col[6] = 1;
	row[4].col[7] = 1;
	row[4].col[8] = 2;

	row[5].col[0] = 2;
	row[5].col[1] = 1;
	row[5].col[2] = 1;
	row[5].col[3] = 1;
	row[5].col[4] = 1;
	row[5].col[5] = 1;
	row[5].col[6] = 1;
	row[5].col[7] = 1;
	row[5].col[8] = 2;

	row[6].col[0] = 2;
	row[6].col[1] = 2;
	row[6].col[2] = 1;
	row[6].col[3] = 1;
	row[6].col[4] = 1;
	row[6].col[5] = 1;
	row[6].col[6] = 1;
	row[6].col[7] = 2;
	row[6].col[8] = 2;

	row[7].col[0] = 2;
	row[7].col[1] = 2;
	row[7].col[2] = 2;
	row[7].col[3] = 1;
	row[7].col[4] = 1;
	row[7].col[5] = 1;
	row[7].col[6] = 2;
	row[7].col[7] = 2;
	row[7].col[8] = 2;

	row[8].col[0] = 2;
	row[8].col[1] = 2;
	row[8].col[2] = 2;
	row[8].col[3] = 2;
	row[8].col[4] = 2;
	row[8].col[5] = 2;
	row[8].col[6] = 2;
	row[8].col[7] = 2;
	row[8].col[8] = 2;

	free_slot!4,3;

    atomic{
      run player(); run board();
    }
};


proctype board() {
    short x;
    short y;
    byte direction;
    printf("Board start\n");

start:
    move?x,y,direction;
    atomic {
        if
        ::  ((y - 2 >= 0) && (direction == UP))
            -> (((row[y].col[x] == 0)     && (row[y - 2].col[x] == 1)     && (row[y - 1].col[x] == 1)))
            -> printf("Playing [%d,%d] UP\n",x,y); row[y - 2].col[x] = 0; row[y - 1].col[x] = 0; free_slot!x,(y - 2); free_slot!x,(y - 1);
            pegs--;

        ::  ((y - 2 >= 0) && (direction == UP))
            -> (((row[y].col[x] == 0)     && (row[y - 2].col[x] == 1)     && (row[y - 1].col[x] == 1)))
            -> printf("Playing [%d,%d] UP\n",x,y); row[y - 2].col[x] = 0; row[y - 1].col[x] = 0; free_slot!x,(y - 1); free_slot!x,(y - 2);
            pegs--;


        ::  ((x + 2 < BOARD_SIZE) && (direction == RIGHT))
            -> (((row[y].col[x] == 0)     && (row[y].col[x + 2] == 1)     && (row[y].col[x + 1] == 1)))
            -> printf("Playing [%d,%d] RIGHT\n",x,y); row[y].col[x + 2] = 0; row[y].col[x + 1] = 0; free_slot!(x + 2),y; free_slot!(x + 1),y;
            pegs--;

        ::  ((x + 2 < BOARD_SIZE) && (direction == RIGHT))
            -> (((row[y].col[x] == 0)     && (row[y].col[x + 2] == 1)     && (row[y].col[x + 1] == 1)))
            -> printf("Playing [%d,%d] RIGHT\n",x,y); row[y].col[x + 2] = 0; row[y].col[x + 1] = 0; free_slot!(x + 1),y; free_slot!(x + 2),y;
            pegs--;


        ::  ((y + 2 < BOARD_SIZE) && (direction == DOWN))
            -> ((row[y].col[x] == 0)    && (row[y + 2].col[x] == 1)     && (row[y + 1].col[x] == 1))
            -> printf("Playing [%d,%d] DOWN\n",x,y); row[y + 2].col[x] = 0; row[y + 1].col[x] = 0; free_slot!x,(y + 2); free_slot!x,(y + 1);
            pegs--;

        ::  ((y + 2 < BOARD_SIZE) && (direction == DOWN))
            -> ((row[y].col[x] == 0)    && (row[y + 2].col[x] == 1)     && (row[y + 1].col[x] == 1))
            -> printf("Playing [%d,%d] DOWN\n",x,y); row[y + 2].col[x] = 0; row[y + 1].col[x] = 0; free_slot!x,(y + 1); free_slot!x,(y + 2);
            pegs--;


        ::  ((x - 2 >= 0) && (direction == LEFT))
            -> ((row[y].col[x] == 0)    && (row[y].col[x - 2] == 1)     && (row[y].col[x - 1] == 1))
            -> printf("Playing [%d,%d] LEFT\n",x,y); row[y].col[x - 2] = 0; row[y].col[x - 1] = 0; free_slot!(x - 2),y; free_slot!(x - 1),y;
            pegs--;

        ::  ((x - 2 >= 0) && (direction == LEFT))
            -> ((row[y].col[x] == 0)    && (row[y].col[x - 2] == 1)     && (row[y].col[x - 1] == 1))
            -> printf("Playing [%d,%d] LEFT\n",x,y); row[y].col[x - 2] = 0; row[y].col[x - 1] = 0; free_slot!(x - 1),y; free_slot!(x - 2),y;
            pegs--;

        :: else -> free_slot!x,y; ready!1; goto start;
        fi

        row[y].col[x] = 1;
        ready!1;

        goto start;
    };

};

proctype player() {
    short x;
    short y;

    printf("Player start\n");

    do
    :: atomic {free_slot?x,y; move!x,y,UP; ready?1;}
    :: atomic {free_slot?x,y; move!x,y,LEFT; ready?1;}
    :: atomic {free_slot?x,y; move!x,y,DOWN; ready?1;}
    :: atomic {free_slot?x,y; move!x,y,RIGHT; ready?1;}
    od
};

ltl formulae { !(<> (pegs == 32)) }
