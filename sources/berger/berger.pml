/* Modele Promela du berger et ses amis */
bool p[4];
mtype = {aller, retour};
chan canal = [0] of {mtype};


proctype B(){
left:  if
       :: atomic{p[0] = 1; canal!aller; goto right;}
       :: atomic{p[0] = 1; goto right;}
       fi;

right: if
       :: atomic{p[0] = 0; canal!retour; goto left;}
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

/* Formule LTL exploitant les possibilités de spin 6. Equivalent à la génération d'un processus never mais plus propre.
 * La seule différence étant la négation supplémentaire apportée à la formule. Au cas où un test avec un processus never est
 * nécessaire, il suffit de prendre la formule contenue dans formulae sans la négation est de générer directement le processus never
 * voulu avec la commande spin -f
 */ 
ltl formulae { !((((p[1] == p[2]) -> (p[0] == p[1])) && ((p[2] == p[3]) -> (p[0] == p[2]))) U (p[0] && p[1] && p[2] && p[3])) }


init{
atomic{run M(); run C(); run L(); run B()}
}
