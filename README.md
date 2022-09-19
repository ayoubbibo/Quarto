# Changement dans les spécifs

## Type Pion : 

Pour nous, le pion n'a pas besoin de coordonnée étant donné qu'on a choisi une matrice pour représenter le plateau où l'on place les pions.
Donc via les coordonnées de notre matrice, nous pouvons retrouver les pions. Cela signifie que garder les coordonnées pour les pions reviendrait à doubler les coordonnées dans le code. De plus, des coordonnées sur un pion n'ont pas trop de sens de notre point de vue, car le pion, une fois placé, ne bouge plus.

## Type Jeu : 


Nous avons eu le choix pour le retour des Pions avec une collection de Pions. Nous avons donc opté pour des tableaux de Pions, 

Dans la fonction "pionPossible", nous avons changé le paramètre qui était un Pion en Int. Le Int représente le numéro du Pion, l'intêret d'avoir çoncu un numéro pour les pions était de pouvoir les choisir par leur numéro. Et en développant le jeu, nous nous somme rendu compte qu'il était nécessaire et plus logique de mettre le numéro en paramètre pour ensuite pouvoir accéder à la case conçue pour ce pion dans le tableau PionsDispo pour vérifier s'il est possible de jouer ce pion.

On a aussi changer dans les fonctions (quatrePionColonne, quatrePionDiagonale, quatrePionLigne)
le type du retour en tableau plutot qu'une collection pour faciliter la vérification si le pion choisit est gagnant ou pas .

## Main : 

Enfin, pour le main, tout fonctionne bien mais l'affichage n'était pas compréhensible pour jouer. Nous avons donc implémenter deux nouvelles fonctions qui permettent d'afficher le plateau ainsi que les pions restant à jouer.
Nous avons aussi choisi d'afficher le plateau une dernière fois dans le main une fois la partie terminée, car sinon, on ne voyait pas le coups gagnant.
en début du jeu le joueur qui commence à jouer n'été pas choisit aléatoirement et il y avait une variable tour qui ne servez à rien donc a modifier afin que le premier joueur sera choisit aléatoirement.