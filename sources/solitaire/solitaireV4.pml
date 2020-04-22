#define UP 0
#define RIGHT 1
#define DOWN 2
#define LEFT 3


chan ready = [0] of { bool };
chan free_slot = [36] of { short, short };
chan move = [1] of { short, short, byte };

<<<<<<< HEAD
int pegs = 24;

typedef Matrix {
    byte col[5] = 1;
};

Matrix row[5];
=======
int pegs = 36;

typedef Matrix {
    byte col[7] = 1;
};

Matrix row[7];
>>>>>>> master

proctype board() {
    short x;
    short y;
    byte direction;
<<<<<<< HEAD

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
=======
    printf("Board start\n");
start: move?x,y,direction;
      atomic {
        if
        ::  ((y - 2 >= 0) && (direction == UP)) && (((row[y].col[x] == 0)     && (row[y - 2].col[x] == 1)     && (row[y - 1].col[x] == 1)))
            -> printf("Playing [%d,%d] UP\n",x,y); row[y - 2].col[x] = 0; row[y - 1].col[x] = 0; free_slot!x,(y - 2); free_slot!x,(y - 1);
            pegs--;

        ::  ((y - 2 >= 0) && (direction == UP)) && (((row[y].col[x] == 0)     && (row[y - 2].col[x] == 1)     && (row[y - 1].col[x] == 1)))
            -> printf("Playing [%d,%d] UP\n",x,y); row[y - 2].col[x] = 0; row[y - 1].col[x] = 0; free_slot!x,(y - 1); free_slot!x,(y - 2);
            pegs--;


        ::  ((x + 2 < 7) && (direction == RIGHT)) && (((row[y].col[x] == 0)     && (row[y].col[x + 2] == 1)     && (row[y].col[x + 1] == 1)))
            -> printf("Playing [%d,%d] RIGHT\n",x,y); row[y].col[x + 2] = 0; row[y].col[x + 1] = 0; free_slot!(x + 2),y; free_slot!(x + 1),y;
            pegs--;

        ::  ((x + 2 < 7) && (direction == RIGHT)) && (((row[y].col[x] == 0)     && (row[y].col[x + 2] == 1)     && (row[y].col[x + 1] == 1)))
            -> printf("Playing [%d,%d] RIGHT\n",x,y); row[y].col[x + 2] = 0; row[y].col[x + 1] = 0; free_slot!(x + 1),y; free_slot!(x + 2),y;
            pegs--;


        ::  ((y + 2 < 7) && (direction == DOWN)) && ((row[y].col[x] == 0)    && (row[y + 2].col[x] == 1)     && (row[y + 1].col[x] == 1))
            -> printf("Playing [%d,%d] DOWN\n",x,y); row[y + 2].col[x] = 0; row[y + 1].col[x] = 0; free_slot!x,(y + 2); free_slot!x,(y + 1);
            pegs--;

        ::  ((y + 2 < 7) && (direction == DOWN)) && ((row[y].col[x] == 0)    && (row[y + 2].col[x] == 1)     && (row[y + 1].col[x] == 1))
            -> printf("Playing [%d,%d] DOWN\n",x,y); row[y + 2].col[x] = 0; row[y + 1].col[x] = 0; free_slot!x,(y + 1); free_slot!x,(y + 2);
            pegs--;


        ::  ((x - 2 >= 0) && (direction == LEFT)) && ((row[y].col[x] == 0)    && (row[y].col[x - 2] == 1)     && (row[y].col[x - 1] == 1))
            -> printf("Playing [%d,%d] LEFT\n",x,y); row[y].col[x - 2] = 0; row[y].col[x - 1] = 0; free_slot!(x - 2),y; free_slot!(x - 1),y;
            pegs--;

        ::  ((x - 2 >= 0) && (direction == LEFT)) && ((row[y].col[x] == 0)    && (row[y].col[x - 2] == 1)     && (row[y].col[x - 1] == 1))
            -> printf("Playing [%d,%d] LEFT\n",x,y); row[y].col[x - 2] = 0; row[y].col[x - 1] = 0; free_slot!(x - 1),y; free_slot!(x - 2),y;
            pegs--;
>>>>>>> master

        :: else -> free_slot!x,y; ready!1; goto start;
        fi

        row[y].col[x] = 1;
<<<<<<< HEAD
        pegs--;
=======
>>>>>>> master
        ready!1;

        goto start;
    };

};

proctype player() {
<<<<<<< HEAD

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
=======
    short x;
    short y;
      printf("Player start\n");
        do
        :: atomic {free_slot?x,y; move!x,y,UP; /*printf("Move send [%d,%d] UP",y,x);*/ ready?1;}
        :: atomic {free_slot?x,y; move!x,y,LEFT; /*printf("Move send [%d,%d] LEFT",y,x);*/ ready?1;}
        :: atomic {free_slot?x,y; move!x,y,DOWN; /*printf("Move send [%d,%d] DOWN",y,x);*/ ready?1;}
        :: atomic {free_slot?x,y; move!x,y,RIGHT; /*printf("Move send [%d,%d] RIGHT",y,x);*/ ready?1;}
        od
>>>>>>> master
};


init {
<<<<<<< HEAD
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
=======
    row[0].col[0]=2;
    row[0].col[1]=2;
    row[0].col[2]=1;
    row[0].col[3]=1;
    row[0].col[4]=1;
    row[0].col[5]=2;
    row[0].col[6]=2;

    row[1].col[0]=2;
    row[1].col[1]=1;
    row[1].col[2]=1;
    row[1].col[3]=1;
    row[1].col[4]=1;
    row[1].col[5]=1;
    row[1].col[6]=2;

    row[2].col[0]=1;
    row[2].col[1]=1;
    row[2].col[2]=1;
    row[2].col[3]=0;
    row[2].col[4]=1;
    row[2].col[5]=1;
    row[2].col[6]=1;

    row[3].col[0]=1;
    row[3].col[1]=1;
    row[3].col[2]=1;
    row[3].col[3]=1;
    row[3].col[4]=1;
    row[3].col[5]=1;
    row[3].col[6]=1;

    row[4].col[0]=1;
    row[4].col[1]=1;
    row[4].col[2]=1;
    row[4].col[3]=1;
    row[4].col[4]=1;
    row[4].col[5]=1;
    row[4].col[6]=1;

    row[5].col[0]=2;
    row[5].col[1]=1;
    row[5].col[2]=1;
    row[5].col[3]=1;
    row[5].col[4]=1;
    row[5].col[5]=1;
    row[5].col[6]=2;

    row[6].col[0]=2;
    row[6].col[1]=2;
    row[6].col[2]=1;
    row[6].col[3]=1;
    row[6].col[4]=1;
    row[6].col[5]=2;
    row[6].col[6]=2;

    atomic{
      free_slot!3,2;
      run player(); run board();
    }
>>>>>>> master
};

ltl formule { !(<> (pegs == 1)) }
