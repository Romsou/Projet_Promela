/* Modele Promela du berger et ses amis */
mtype = {aller, retour};
chan canal = [0] of {mtype}; 
proctype B(){ 
left:  if
       :: canal!aller; goto right
       :: goto right
       fi;
right: if
       :: canal!retour; goto left
       :: goto left
       fi;
}

proctype M(){ 
left : canal?aller; goto right;
right: canal?retour; goto left;
}

proctype C(){ 
left : canal?aller; goto right;
right: canal?retour; goto left;
}

proctype L(){ 
left : canal?aller; goto right;
right: canal?retour; goto left;
}

init{  
atomic{run M(); run C(); run L(); run B()}
}


