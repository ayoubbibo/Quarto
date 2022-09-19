import Foundation


// crée le plateau de jeu 
var jeu = Jeu()

//on designe le premier joueur 1 de manière aléatoire
// On a changé cette partie aussi car le choisit n'été pas fait aléatoirement.
var tour = Int.random(in : 0...1)
var joueur1 : Int = tour //joueur1
var joueur2 : Int
if (tour == 0) 
{ 
  joueur2  = 1 //joueur2
}
else 
{
  joueur2 = tour - 1
}


var tmp : Int = 0 //permet d’échanger le numéro des joueurs


var gagnant : Bool = false

//Fonction qui affiche le plateau de jeu
//A préciser que l'on a mofifié pour un meilleur affichage
/*
func printPlateau(){
  print("Voici le plateau de jeu : ")
    for i in 0...3 { 
        print("| ",jeu.getNumero(x : i, y : 0) ?? "-"," | ",jeu.getNumero(x:i,y:1) ?? "-"," | ",jeu.getNumero(x:i,y:2) ?? "-"," | ",jeu.getNumero(x:i,y:3) ?? "-"," |")    }
}

*/
/* 
    Le main fonctionne bien mais on a constaté que l'affichage n'était pas compréhensible
    pour jouer. On avait présenté les pions par des numéros donc cela veut dire qu'on ne peut pas voir
    les caractéristiques de ces pions donc on a décidé d'implémenter deux nouvelles fonctions qui 
    permettent d'afficher le plateau ainsi que les pions restant à jouer.
*/

func printPlateau(){
  var chaine : String = ""
  for i in 0...3{
    for j in 0...3{
      let pionActuel = jeu.plateau[i][j]
      if (pionActuel != nil){
        if (pionActuel!.estBlanc && pionActuel!.estCarre && pionActuel!.estGrand && pionActuel!.estCreux){
          //grand carre blanc et creux
          chaine += "| □ B |"
        }
        else if (pionActuel!.estBlanc && pionActuel!.estCarre && pionActuel!.estGrand && !pionActuel!.estCreux){
          //grand carre blanc et plein
          chaine += "| ■ B |"
        }
        else if (pionActuel!.estBlanc && pionActuel!.estCarre && !pionActuel!.estGrand && pionActuel!.estCreux){
          //petit carre blanc et creux
          chaine += "| ▫ B |"
        }
        else if (pionActuel!.estBlanc && pionActuel!.estCarre && !pionActuel!.estGrand && !pionActuel!.estCreux){
          //petit carre blanc et plein
          chaine += "| ▪ B |"
        }
        else if (pionActuel!.estBlanc && !pionActuel!.estCarre && pionActuel!.estGrand && pionActuel!.estCreux){
          //grand rond blanc et creux
          chaine += "| O B |"
        }
        else if (pionActuel!.estBlanc && !pionActuel!.estCarre && pionActuel!.estGrand && !pionActuel!.estCreux){
          //grand rond blanc et plein
          chaine += "| ⬤ B |"
        }
        else if (pionActuel!.estBlanc && !pionActuel!.estCarre && !pionActuel!.estGrand && pionActuel!.estCreux){
          //petit rond blanc et creux
          chaine += "| o B |"
        }
        else if (pionActuel!.estBlanc && !pionActuel!.estCarre && !pionActuel!.estGrand && !pionActuel!.estCreux){
          //petit rond blanc et plein
          chaine += "| ● B |"
        }
        else if (!pionActuel!.estBlanc && pionActuel!.estCarre && pionActuel!.estGrand && pionActuel!.estCreux){
          //grand carre noir et creux
          chaine += "| □ N |"
        }
        else if (!pionActuel!.estBlanc && pionActuel!.estCarre && pionActuel!.estGrand && !pionActuel!.estCreux){
          //grand carre noir et plein
          chaine += "| ■ N |"
        }
        else if (!pionActuel!.estBlanc && pionActuel!.estCarre && !pionActuel!.estGrand && pionActuel!.estCreux){
          //petit carre noir et creux
          chaine += "| ▫ N |"
        }
        else if (!pionActuel!.estBlanc && pionActuel!.estCarre && !pionActuel!.estGrand && !pionActuel!.estCreux){
          //petit carre noir et plein
          chaine += "| ▪ N |"
        }
        else if (!pionActuel!.estBlanc && !pionActuel!.estCarre && pionActuel!.estGrand && pionActuel!.estCreux){
          //grand rond noir et creux
          chaine += "| O N |"
        }
        else if (!pionActuel!.estBlanc && !pionActuel!.estCarre && pionActuel!.estGrand && !pionActuel!.estCreux){
          //grand rond noir et plein
          chaine += "| ⬤ N |"
        }
        else if (!pionActuel!.estBlanc && !pionActuel!.estCarre && !pionActuel!.estGrand && pionActuel!.estCreux){
          //petit rond noir et creux
          chaine += "| o N |"
        }
        else if (!pionActuel!.estBlanc && !pionActuel!.estCarre && !pionActuel!.estGrand && !pionActuel!.estCreux){
          //petit rond noir plein
          chaine += "| ● B |"
        }
      }
      else {
        chaine += "| -- |"
      }
    }
    chaine += "\n"
  }
  print(chaine)
}

// la fonction qui renvoie les pions disponibles  
// chaque pion à une forme et une lettre qui définit sa couleur par exemple 
// ■ B =  grand carre blanc et plein
// ■ N =  grand carre Noir et plein
func afficherPionsDispo(){
  print("Pions restants disponibles : ")
  var nbColonne : Int = 0
  var chaine : String = ""
  for i in jeu.pionsDispo {
    if (i == nil){
      chaine += " -- "
    }
    else {
      let pionActuel = i
      chaine += String(pionActuel!.numero)
      chaine += ":"
      if (pionActuel!.estBlanc && pionActuel!.estCarre && pionActuel!.estGrand && pionActuel!.estCreux){
          //grand carre blanc et creux
          chaine += " □ B  "
        }
        else if (pionActuel!.estBlanc && pionActuel!.estCarre && pionActuel!.estGrand && !pionActuel!.estCreux){
          //grand carre blanc et plein
          chaine += " ■ B  "
        }
        else if (pionActuel!.estBlanc && pionActuel!.estCarre && !pionActuel!.estGrand && pionActuel!.estCreux){
          //petit carre blanc et creux
          chaine += " ▫ B  "
        }
        else if (pionActuel!.estBlanc && pionActuel!.estCarre && !pionActuel!.estGrand && !pionActuel!.estCreux){
          //petit carre blanc et plein
          chaine += " ▪ B  "
        }
        else if (pionActuel!.estBlanc && !pionActuel!.estCarre && pionActuel!.estGrand && pionActuel!.estCreux){
          //grand rond blanc et creux
          chaine += " O B  "
        }
        else if (pionActuel!.estBlanc && !pionActuel!.estCarre && pionActuel!.estGrand && !pionActuel!.estCreux){
          //grand rond blanc et plein
          chaine += " ⬤ B  "
        }
        else if (pionActuel!.estBlanc && !pionActuel!.estCarre && !pionActuel!.estGrand && pionActuel!.estCreux){
          //petit rond blanc et creux
          chaine += " o B  "
        }
        else if (pionActuel!.estBlanc && !pionActuel!.estCarre && !pionActuel!.estGrand && !pionActuel!.estCreux){
          //petit rond blanc et plein
          chaine += " ● B  "
        }
        else if (!pionActuel!.estBlanc && pionActuel!.estCarre && pionActuel!.estGrand && pionActuel!.estCreux){
          //grand carre noir et creux
          chaine += " □ N  "
        }
        else if (!pionActuel!.estBlanc && pionActuel!.estCarre && pionActuel!.estGrand && !pionActuel!.estCreux){
          //grand carre noir et plein
          chaine += " ■ N  "
        }
        else if (!pionActuel!.estBlanc && pionActuel!.estCarre && !pionActuel!.estGrand && pionActuel!.estCreux){
          //petit carre noir et creux
          chaine += " ▫ N  "
        }
        else if (!pionActuel!.estBlanc && pionActuel!.estCarre && !pionActuel!.estGrand && !pionActuel!.estCreux){
          //petit carre noir et plein
          chaine += " ▪ N  "
        }
        else if (!pionActuel!.estBlanc && !pionActuel!.estCarre && pionActuel!.estGrand && pionActuel!.estCreux){
          //grand rond noir et creux
          chaine += " O N  "
        }
        else if (!pionActuel!.estBlanc && !pionActuel!.estCarre && pionActuel!.estGrand && !pionActuel!.estCreux){
          //grand rond noir et plein
          chaine += " ⬤ N  "
        }
        else if (!pionActuel!.estBlanc && !pionActuel!.estCarre && !pionActuel!.estGrand && pionActuel!.estCreux){
          //petit rond noir et creux
          chaine += " o N  "
        }
        else if (!pionActuel!.estBlanc && !pionActuel!.estCarre && !pionActuel!.estGrand && !pionActuel!.estCreux){
          //petit rond noir plein
          chaine += " ● N  "
        }
    }
    nbColonne += 1
    if (nbColonne % 4 == 0){
      chaine += "\n"
    }
  }
  print(chaine)
}


//tant que nbPionRestant>0 ET pas de gagnant
while jeu.nbPionRestant > 0 && !gagnant{
    //On affiche le plateau de jeux
    printPlateau()

    //Le joueur qui commence le tour(choisi la pièce) possède le numéro 1, celui qui dépose la pièce est le numéro 0
    //On désigne qui va jouer
    if joueur1 == 1{
      print("C'est au joueur1 de choisir un pion")
    }else{
      print("C'est au joueur2 de choisir un pion")
    }
    
    afficherPionsDispo()
    //joueur == 1 choisit une pièce parmi les nbPionRestant : print les pions qui restent
    let pion_choisi = jeu.lePionChoisi()
    
    //ETIENNE : Il y a un print pour les pions ?
    //Anais corrigé
    if joueur1 == 0{
      print("C'est au joueur1 de placer le pion : ", pion_choisi)
    }
    else{
      print("C'est au joueur2 de placer le pion : ", pion_choisi)
    }

    //joueur == 0 doit placer la pièce choisi par joueur 1
    let (x_choisi, y_choisi) = jeu.choisirPosition()
    
    //joueur == 0 place la pièce
    jeu.placerPion(pion : pion_choisi, x:x_choisi,y:y_choisi)
    
    gagnant = jeu.estGagnant(x : x_choisi, y : y_choisi)
    
    //Si pas de gagnant on change qui joue en premier.
    if !(gagnant){
      tmp = joueur1
      joueur1 = joueur2
      joueur2 = tmp
    }else{
      printPlateau()
      //Si gagnant, on dit qui a gagné : c'est le joueur qui a donné le dernier coup qui a gagné 
      if joueur1 == 0{
        print("Joueur 1 vous avez gagné!")
      }else{
        print("Joueur 2 vous avez gagné!")
      }
    }
}

if (jeu.nbPionRestant == 0 && !(gagnant)){
  print("Tous les pions ont été joué sans quarto, il y a donc aucun gagnant.")
}

//----------------------------------------code des fonctions lePionChoisi() et PositionChoisie()-----------------
/*

//fonction du choix du pion de l'utilisateur
func lePionChoisi() -> Pion{
    print("Voici les pions disponibles :")
    var numero = 1 // 1 car 0 veut dire plus de pion
    for pion in jeu.pionsDispo{
      print("Pion : ", numero, " : ", pion)
      numero+=1
    }

    var choixPion : Int
    var asChoose : Bool = false
    while (!asChoose){
        print("Choisissez un numero de pion que l’autre joueur va jouer")
        let choix = readLine()
        //Etienne si je prends + de 16 ou - de 16 ou un pion qui n'est plus disponible + convertir le choix de readline en Int
        if(choix != nil){
            choixPion = choix
            asChoose = true
        }else{
            print("le format du pion choisi est invalide, veuillez en saisir une nouvelle fois")
        }
    }
    print("Le joueur a choisi : ", choixPion)
    return jeu.pionsDispo[choixPion]
}

//fonction du choix de la position de l'utilisateur
func PositionChoisie() -> (Int, Int){
    var x_choisi : Int
    var y_choisi : Int
    var asChoose = false
    
    while(!asChoose){
        print("Choisissez la ligne du pion entre 0 et 3")
        let choix = readLine()
        print("Choisissez la colonne du pion entre 0 et 3")
        if(choix! != nil && Int(choix!) != nil && jeu.isOccupied(x : x_choisi, y : y_choisi) && jeu.positionPlateau(x:x_choisi,y:y_choisi){ //si la position n’est pas prise && position dans le plateau
            x_choisi = Int(choix!)!
            asChoose = true
        }else {
            print("le format de la position est invalide ou elle est déjà occupée, veuillez en saisir une nouvelle")
        }
    }
    return (x_choisi, y_choisi)
}
*/