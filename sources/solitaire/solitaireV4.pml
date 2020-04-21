#define UP 0
#define RIGHT 1
#define DOWN 2
#define LEFT 3


chan ready = [0] of { bool };
chan free_slot = [36] of { short, short };
chan move = [1] of { short, short, byte };

int pegs = 24;

typedef Matrix {
    byte col[5] = 1;
};

Matrix row[5];

proctype board() {
    short x;
    short y;
    byte direction;

start:
    atomic {
        move?x,y,direction;

        if
        ::  ((y - 2 >= 0) && (direction == UP))
            -> (((row[y].col[x] == 0)     && (row[y - 2].col[x] != 2)     && (row[y - 1].col[x] != 2)))
            -> printf("go up\n"); row[y - 2].col[x] = 0; row[y - 1].col[x] = 0; free_slot!x,(y - 2); free_slot!x,(y - 1);

        ::  ((y - 2 >= 0) && (direction == UP))
            -> (((row[y].col[x] == 0)     && (row[y - 2].col[x] != 2)     && (row[y - 1].col[x] != 2)))
            -> printf("go up\n"); row[y - 2].col[x] = 0; row[y - 1].col[x] = 0; free_slot!x,(y - 1); free_slot!x,(y - 2);


        ::  ((x + 2 < 5) && (direction == RIGHT))
            -> (((row[y].col[x] == 0)     && (row[y].col[x + 2] != 2)     && (row[y].col[x + 1] != 2)))
            -> printf("go right\n"); row[y].col[x + 2] = 0; row[y].col[x + 1] = 0; free_slot!(x + 2),y; free_slot!(x + 1),y;

        ::  ((x + 2 < 5) && (direction == RIGHT))
            -> (((row[y].col[x] == 0)     && (row[y].col[x + 2] != 2)     && (row[y].col[x + 1] != 2)))
            -> printf("go right\n"); row[y].col[x + 2] = 0; row[y].col[x + 1] = 0; free_slot!(x + 1),y; free_slot!(x + 2),y;


        ::  ((y + 2 < 5) && (direction == DOWN))
            -> ((row[y].col[x] == 0)    && (row[y + 2].col[x] != 2)     && (row[y + 1].col[x] != 2))
            -> printf("go down\n"); row[y + 2].col[x] = 0; row[y + 1].col[x] = 0; free_slot!x,(y + 2); free_slot!x,(y + 1);

        ::  ((y + 2 < 5) && (direction == DOWN))
            -> ((row[y].col[x] == 0)    && (row[y + 2].col[x] != 2)     && (row[y + 1].col[x] != 2))
            -> printf("go down\n"); row[y + 2].col[x] = 0; row[y + 1].col[x] = 0; free_slot!x,(y + 1); free_slot!x,(y + 2);


        ::  ((x - 2 >= 0) && (direction == LEFT))
            -> ((row[y].col[x] == 0)    && (row[y].col[x - 2] != 2)     && (row[y].col[x - 1] != 2))
            -> printf("go left\n"); row[y].col[x - 2] = 0; row[y].col[x - 1] = 0; free_slot!(x - 2),y; free_slot!(x - 1),y;

        ::  ((x - 2 >= 0) && (direction == LEFT))
            -> ((row[y].col[x] == 0)    && (row[y].col[x - 2] != 2)     && (row[y].col[x - 1] != 2))
            -> printf("go left\n"); row[y].col[x - 2] = 0; row[y].col[x - 1] = 0; free_slot!(x - 1),y; free_slot!(x - 2),y;

        :: else -> free_slot!x,y; ready!1; goto start;
        fi

        row[y].col[x] = 1;
        pegs--;
        ready!1;

        goto start;
    };

};

proctype player() {

    short x;
    short y;
    atomic {
        do
        :: free_slot?x,y; move!x,y,UP; ready?1;
        :: free_slot?x,y; move!x,y,RIGHT; ready?1;
        :: free_slot?x,y; move!x,y,DOWN; ready?1;
        :: free_slot?x,y; move!x,y,RIGHT; ready?1;
        od
    };
};


init {
    /*
    row[0].col[0] = 2;
    row[0].col[1] = 2;
    row[0].col[2] = 1;
    row[0].col[3] = 2;
    row[0].col[4] = 2;

    row[1].col[0] = 2;
    row[1].col[1] = 2;
    row[1].col[2] = 1;
    row[1].col[3] = 2;
    row[1].col[4] = 2;

    row[2].col[0] = 1;
    row[2].col[1] = 1;
    row[2].col[2] = 0;
    row[2].col[3] = 1;
    row[2].col[4] = 1;

    row[3].col[0] = 2;
    row[3].col[1] = 2;
    row[3].col[2] = 1;
    row[3].col[3] = 2;
    row[3].col[4] = 2;

    row[4].col[0] = 2;
    row[4].col[1] = 2;
    row[4].col[2] = 1;
    row[4].col[3] = 2;
    row[4].col[4] = 2;
    */

    row[0].col[0] = 1;
    row[0].col[1] = 1;
    row[0].col[2] = 1;
    row[0].col[3] = 1;
    row[0].col[4] = 1;

    row[1].col[0] = 1;
    row[1].col[1] = 1;
    row[1].col[2] = 1;
    row[1].col[3] = 1;
    row[1].col[4] = 1;

    row[2].col[0] = 1;
    row[2].col[1] = 1;
    row[2].col[2] = 0;
    row[2].col[3] = 1;
    row[2].col[4] = 1;

    row[3].col[0] = 1;
    row[3].col[1] = 1;
    row[3].col[2] = 1;
    row[3].col[3] = 1;
    row[3].col[4] = 1;

    row[4].col[0] = 1;
    row[4].col[1] = 1;
    row[4].col[2] = 1;
    row[4].col[3] = 1;
    row[4].col[4] = 1;


    free_slot!2,2;

    atomic{ run player(); run board(); };
};

ltl formule { !(<> (pegs == 1)) }
