/* Modele Promela du berger et ses amis */
bool p[4];
mtype = {aller, retour};
chan canal = [0] of {mtype};

proctype B(){
left:  if
       :: atomic{canal!aller; p[0] = 1; goto right;}
       :: atomic{p[0] = 1; goto right;}
       fi;
right: if
       :: atomic{canal!retour; p[0] = 0; goto left;}
       :: atomic{p[0] = 0; goto left;}
       fi;
}

proctype L(){
left : atomic{canal?aller; p[1] = 1; goto right;}
right: atomic{canal?retour; p[1] = 0; goto left;}
}

proctype M(){
left : atomic{canal?aller; p[2] = 1; goto right;}
right: atomic{canal?retour; p[2] = 0; goto left;}
}

proctype C(){
left : atomic{canal?aller; p[3] = 1; goto right;}
right: atomic{canal?retour; p[3] = 0; goto left;}
}

never  {    /* !(((p[2]==p[3])->(p[2]!=p[0])) || ((p[1]==p[2])->(p[1]!=p[0]))) U <>((p[0]==1)&&(p[1]==1)&&(p[2]==1)&&(p[3]==1)) */
T0_init:
        do
        :: atomic { (((p[0]==1)&&(p[1]==1)&&(p[2]==1)&&(p[3]==1))) -> assert(!(((p[0]==1)&&(p[1]==1)&&(p[2]==1)&&(p[3]==1)))) }
        :: (1) -> goto T0_init
        od;
accept_all:
        skip
}

init{
atomic{run M(); run C(); run L(); run B()}
}
