#Projet d'introduction à la vérification

##Exercice 1.1 (Le berger)

Nous poursuivons l’exercice portant sur le berger, le loup, le mouton et le chou. Nous sou-
haitons générer automatiquement à l’aide de SPIN la solution la plus courte permettant au
berger de traverser la rivière sans danger.

Le fichier berger.pml obtenu au précédent TP vous est fourni. Il propose une modélisation
du système faisant intervenir un processus par protagoniste (le berger, le loup, le mouton et le
chou), soit 4 processus. De plus, les communications entre les protagonistes se font au travers
d’un unique canal.

Vous devez modifier ce modèle afin de pouvoir exprimer le fait qu’il existe une exécution
correspondant à une solution pour le berger. Vous ne devez pas pour cela chercher à restreindre
les comportements du modèle, mais bien à exprimer sous la forme d’une propriété LTL les
comportements qui vous intéressent. Enfin, une fois la trace correspondante produite par
SPIN, vous l’afficherez sous forme de MSC pour que l’on voit facilement les communications
ayant eu lieu. Vous intégrerez cet affichage MSC à votre rapport.
Pensez à tester votre modèle au fur et à mesure à l’aide de simulations ! Les printf sont
affichés dans les MSC, vous pouvez en insérer pour ajouter des commentaires sur les actions
réalisées par le berger...

##Exercice 1.2 (Le jeu de solitaire)

Vous connaissez sûrement le jeu de solitaire (allez voir sur Wikipedia sinon), mais connaissez-
vous la stratégie permettant de gagner ?
Proposez une modélisation sous SPIN de ce jeu, dans sa version classique (voir Figure 1).
Utilisez SPIN pour résoudre le jeu et obtenir une solution la plus courte possible (en terme
de votre modélisation SPIN, puisque la longueur d’une solution du Solitaire est toujours la
même...).

Dans un second temps, vous proposerez une interface permettant de décrire le plateau de
jeu (vous pouvez voir sur la page Wikipedia qu’il existe différents plateaux en fonction des
pays) et la configuration initiale et qui génère automatiquement un programme SPIN. Faites
augmenter la taille du plateau de jeu et observez les temps de calcul.
Explorez alors les options de SPIN visant à accélérer les calculs, proposez éventuellement
une nouvelle modélisation...
L’objectif est de pouvoir traiter des plateaux les plus grands possibles.
