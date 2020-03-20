# Projet d'introduction à la vérification

## Description

Le projet consiste en la réalisation de deux exercices au travers de la mise en
œuvre des principes et outils vus en cours d'introduction à la vérification,
à savoir:
- **Promela**, langage de modélisation dérivé du C
- **Spin**, outil de vérification faisant usage de Promela

## Usage

Afin de simplifier la correction et l'utilisation du projet, deux fichiers
makefiles ont été rédigés. Il s'agit de scripts bash prenant en compte des
paramètres décrivant l'opération à effectuer.

**Pour produire un vérifieur et compiler pan:**
```
./makefile_[nom].sh -c
```

**Pour générer une trace à partir de pan:**
```
./makefile_[nom].sh -t
```

**Pour afficher le MSC:**
```
./makefile_[nom].sh -m
```

**Pour nettoyer les répertoires:**
```
./makefile_[nom].sh -d
```

Toutes les options peuvent être combinées. Cependant les paramètres
-t et -m dépendent de l'existence d'un fichier pan et d'un fichier trail
respectivement. Il est donc toujours mieux de les lancer avec l'option -c
comme ceci:

```
./makefile_[nom].sh -c -t -m -d
```

**Note:** Ne lancez jamais l'option -d avant -t et -m, auquel cas vous ne
pourrez pas générer de ficher pan ou de trace puisqu'ils seront automatiquement
effacés avant d'avoir été utilisés.

## Contributeurs

- Adrien Mollet
- Romain Soumard
