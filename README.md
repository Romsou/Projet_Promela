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

Toutes les options peuvent être combinées dans l'ordre. Cependant les paramètres
-t et -m dépendent de l'existence d'un fichier pan et d'un fichier trail
respectivement. Il est donc toujours mieux de les lancer avec l'option -c
et l'option -comme ceci:

```
./makefile_[nom].sh -c -t -m -d
```

## Contributeurs

- Adrien Mollet
- Romain Soumard
