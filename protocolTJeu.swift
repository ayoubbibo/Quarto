//------------------------------------------------------------------------//
//--------------------------- Type Abstrait ------------------------------//
//------------------------------------------------------------------------//
   
protocol TJeu {
  associatedtype Pion : TPion
  
  //  Création d'un plateau de jeu vide et initialisation des 16 pions
  //  Pre : Le nombre de pions restant est initialisé à 16. La taille du plateau est initalisée à 4*4
  //    : tous les pions sont disponibles
  init()

  //  liste des pions disponibles
  //  à l'initialisation, pionsDispo est vide
  var pionsDispo : [Pion?] {get set}

  //  Retourne le nombre de pion restant (=le nombre de pion pas encore joué)
  //  Pre: Nombre de pion restant est compris 0 et 16. Si nombre de pion restant = 0, la partie est terminée.
  var nbPionRestant: Int { get set }
   
  //  Place un pion à la position (x,y), le nombre de pion pas encore joué diminue
  //  Pre : 0≤x≤3 0≤y≤3
  //  Le pion choisi n'est plus disponible
  //  estOccupee(placerPion(x,y), x,y)==true
  //  NbPionRestant=NbPionRestant-1
  //  placerPion(J,x,y) => !(estOccupee(J,x,y))
  mutating func placerPion(pion : Pion, x : Int, y : Int)
  
  //  Retourne si la position (x,y) est occupée par un pion.
  //  Pre : 0≤x≤3 0≤y≤3
  //  estOccupee(J,x,y) => placerPion(J,x,y)
  func estOccupee(x : Int, y : Int) -> Bool 
  
  //  Retourne si la ligne ou se situe (x,y) est complète.
  //  Si on vérifie la ligne : x fixe, y varie
  //  Paramètre : x : ligne
  //  Pre : 0≤y≤3
  func ligneComplete(x : Int) -> Bool
  
  //  Retourne si la colonne ou se situe (x,y) est complète.
  //  Si on vérifie la colonne : x varie, y fixe
  //  Paramètre : y : colonne 
  //  Pre : 0≤x≤3 0≤y≤3
  func colonneComplete(y : Int) -> Bool
  
  
  //  Retourne si la diagonale ou se situe (x,y) est complète.
  //  Si on vérifie la diagonale : x==y en variant x et y
  //  Paramètres : x : ligne  y : colonne
  //  Pre : 0≤x≤3 0≤y≤3
  func diagonaleComplete(x : Int, y : Int) -> Bool
  
  //  fonction qui renvoie les 4 pions de la ligne complète 
  //  précond : la ligne est complète
  func quatrePionLigne(x : Int) -> [Pion]
  
  //  fonction qui renvoie les 4 pions de la ligne complète 
  //  précond : la colonne est complète
  func quatrePionColonne(y : Int) -> [Pion]
  
  //  fonction qui renvoie les 4 pions de la diagonale complète 
  //  précond : la diagonale est complète
  func quatrePionDiagonale(x :Int, y : Int) -> [Pion]
  
  //  Retourne si 4 pions alignés ont une caractéristique commune.
  //  Paramètres : Pion x Pion x Pion x Pion : les 4 pions alignés
  //  caracCommun(J,x,y) => diagonaleComplete(J,x,y) || colonneComplete(J,y) || ligneComplete(J,x)
  //  (caracCommun(J,x,y) => estGagnant(J,x,y)
  func caracCommun(p1:Pion,p2:Pion,p3:Pion,p4:Pion) -> Bool
  
  //  renvoie true si la position choisie appartient au plateau de jeu, false sinon
  func positionPlateau(x: Int, y : Int) -> Bool

  //  fonction qui renvoie la position choisie par le joueur
  //  précond : la position n'est pas occupée
  //          : la position rentrée par le joueur est une position du plateau 
  func choisirPosition() -> (Int,Int)

  //  fonction du choix du pion de l'utilisateur
  //  renvoie le pion choisi par l'utilisateur
  //  précond : Le pion choisi doit exister
  //        : le pion choisi doit encore etre en jeu (appartenir a pionsDispo)
  func lePionChoisi() -> Pion
    
  //  Renvoie true si le pion existe bien et s'il est encore en jeu, false sinon
  //  pionPossible(P) => lePionChoisi()
  func pionPossible(numero:Int) -> Bool
  
  //  Fonction qui pour une coordonnée (x,y) renvoie le pion qui est positionné dessus ou vide s’il y en a aucun
  //  Paramètres : x : ligne | y : colonne
  //  Pre : Les coordonnées sont comprises entre (0,0) et (3,3)
  //  getPion(x,y) => estOccupee(J,x,y)
  func getPion(x:Int,y:Int) -> Pion?

  //  Fonction qui pour une coordonnée (x,y) renvoie le numéro du pion qui est positionné dessus ou vide s’il y en a aucun
  //  Paramètres : x : ligne | y : colonne
  //  Pre : Les coordonnées sont comprises entre (0,0) et (3,3)
  func getNumero(x:Int,y:Int) -> Int?

  //  Fonction qui retourne true si le coup est gagnant, false sinon
  //  Paramètres : x : ligne | y : colonne
  //  Pre : Les coordonnées sont comprises entre (0,0) et (3,3)
  //  caracCommun(J,x,y) => estGagnant(J,x,y) 
  func estGagnant(x : Int, y : Int) -> Bool 
}

//------------------------------------------------------------------------//
//--------------------------- Type Concret -------------------------------//
//------------------------------------------------------------------------//

struct Jeu : TJeu {

  // On décidé de representer le plateau en tableau(ligne , colonne) qui a comme element associé à ses cases un Pion ou nil  
  var plateau : [[Pion?]]

  //  Stocker les pions disponibles
  //  à l'initialisation le tableau contient 16 pions  
  var pionsDispo : [Pion?]

  // renvoie le nombre de pions Restant 
  var nbPionRestant: Int

  //  Création d'un plateau de jeu vide et initialisation des 16 pions
  //  Pre : Le nombre de pions restant est initialisé à 16. La taille du plateau est initalisée à 4*4
  //    : tous les pions sont disponibles
  init(){

    // Creation des pions nécessaires pour pouvoir jouer
    let piece1 = Pion(numero : 1, estBlanc : true, estGrand : true, estCarre : true, estCreux : true)
    let piece2 = Pion(numero : 2, estBlanc : true, estGrand : true, estCarre : true, estCreux : false)
    let piece3 = Pion(numero : 3, estBlanc : true, estGrand : true, estCarre : false, estCreux : true)
    let piece4 = Pion(numero : 4, estBlanc : true, estGrand : true, estCarre : false, estCreux : false)
    let piece5 = Pion(numero : 5, estBlanc : true, estGrand : false, estCarre : true, estCreux : true)
    let piece6 = Pion(numero : 6, estBlanc : true, estGrand : false, estCarre : true, estCreux : false)
    let piece7 = Pion(numero : 7, estBlanc : true, estGrand : false, estCarre : false, estCreux : true)
    let piece8 = Pion(numero : 8, estBlanc : true, estGrand : false, estCarre : false, estCreux : false)
    let piece9 = Pion(numero : 9, estBlanc : false, estGrand : true, estCarre : true, estCreux : true)
    let piece10 = Pion(numero : 10, estBlanc : false, estGrand : true, estCarre : true, estCreux : false)
    let piece11 = Pion(numero : 11, estBlanc : false, estGrand : true, estCarre : false, estCreux : true)
    let piece12 = Pion(numero : 12, estBlanc : false, estGrand : true, estCarre : false, estCreux : false)
    let piece13 = Pion(numero : 13, estBlanc : false, estGrand : false, estCarre : true, estCreux : true)
    let piece14 = Pion(numero : 14, estBlanc : false, estGrand : false, estCarre : true, estCreux : false)
    let piece15 = Pion(numero : 15, estBlanc : false, estGrand : false, estCarre : false, estCreux : true)
    let piece16 = Pion(numero : 16, estBlanc : false, estGrand : false, estCarre : false, estCreux : false)

    //  le tableau contien 4 lignes et 4 colonnes toutes les cases sont initialisé à nil 
    self.plateau = [[Pion?]](repeating : [Pion?](repeating : nil, count: 4), count : 4)

    //  mettre les 16 pions sur le tableau des pions disponible    
    self.pionsDispo = [piece1,piece2,piece3,piece4,piece5,piece6,piece7,piece8,piece9,piece10,piece11,piece12,piece13,piece14,piece15,piece16]

    self.nbPionRestant = 16
  }

  //  Place un pion à la position (x,y), le nombre de pion pas encore joué diminue
  //  Pre : 0 ≤ x ≤ 3 0 ≤ y ≤3
  //  Le pion choisi n'est plus disponible
  //  estOccupee(placerPion(x,y), x,y) == true
  //  placerPion(J,x,y) => !(estOccupee(J,x,y))
  mutating func placerPion(pion : Pion, x : Int, y : Int){
    self.pionsDispo[pion.numero - 1] = nil
    self.plateau[x][y] = pion
    self.nbPionRestant -= 1
  }

  //  Retourne si la position (x,y) est occupée par un pion.
  //  Pre : 0≤x≤3 0≤y≤3
  //  estOccupee(J,x,y) => placerPion(J,x,y)
  func estOccupee(x : Int, y : Int) -> Bool {
    return self.plateau[x][y] != nil
  }

  //  Retourne si la ligne ou se situe (x,y) est complète.
  //  Si on vérifie la ligne : x fixe, y varie
  //  Paramètre : x : ligne
  //  Pre : 0≤y≤3
  func ligneComplete(x : Int) -> Bool {
    var y = 0
    //n'est pas au bout de la ligne et n'a pas encore rencontré un nil
    while (y < 4 && self.plateau[x][y] != nil){
        y += 1
      }
    return y == 4
  }

  //  Retourne si la colonne ou se situe (x,y) est complète.
  //  Si on vérifie la colonne : x varie, y fixe
  //  Paramètre : y : colonne 
  //  Pre : 0≤x≤3 0≤y≤3
  func colonneComplete(y : Int) -> Bool{
    var x = 0
        //n'est pas au bout de la colonne et n'a pas encore rencontré un nil
    while (x < 4 && self.plateau[x][y] != nil){
        x += 1
      }
    return x == 4
  }

  //Retourne si la diagonale ou se situe (x,y) est complète.
  //Si on vérifie la diagonale : x==y en variant x et y
  //Paramètres : x : ligne  y : colonne
  //Pre : 0≤x≤3 0≤y≤3
  func diagonaleComplete(x : Int, y : Int) -> Bool
  {
    var positionX : Int
    var positionY : Int
    var i : Int = 0
    //diagonale de droite
    if (x + y == 3) {
      positionX = 0
      positionY = 3
        //n'est pas au bout de la diagonale et n'a pas encore rencontré un nil
      while (i < 4 && self.plateau[positionX][positionY] != nil){
        positionX += 1
        positionY -= 1
        i += 1
      }
    }
    //diagonale de gauche
    else if(x == y){
      positionX = 0
      positionY = 0
      //n'est pas au bout de la diagonale et n'a pas encore rencontré un nil
      while(i < 4 && self.plateau[positionX][positionY] != nil){
        positionX += 1
        positionY += 1
        i += 1
      } 
    }
    //diagonale pas possible
    else {
      return false
    }
    return i == 4
  }

  //on a changé le type du retour en tableau plutot qu'une colection 
  func quatrePionLigne(x : Int) -> [Pion]{
    assert(ligneComplete(x :x),"Ligne non complète")
    var tabPionLigne = [Pion](repeating : Pion(numero: 90 ,estBlanc : true, estGrand : true, estCarre : false, estCreux : false) , count : 4)
    for i in 0..<4{
      tabPionLigne[i] = self.plateau[x][i]!
    }
    return tabPionLigne
  }

  //on a changé le type du retour en tableau plutot qu'une colection
  func quatrePionColonne(y : Int) -> [Pion]{
    assert(colonneComplete(y :y),"Colonne non complète")
    var tabPionColonne = [Pion](repeating : Pion(numero: 90 ,estBlanc : true, estGrand : true, estCarre : false, estCreux : false) , count : 4)
    for i in 0..<4{
      tabPionColonne[i] = self.plateau[i][y]!
    }
    return tabPionColonne
  }

  //  on a changé le type du retour en tableau plutot qu'une colection
  //  fonction qui renvoie les 4 pions de la diagonale complète 
  //  précond : la diagonale est complète
  func quatrePionDiagonale(x :Int, y : Int) -> [Pion]
  {
    assert(diagonaleComplete(x : x, y : y),"Diagonale non complète")
    var positionX : Int
    var positionY : Int
    var i : Int = 0
    var tabPionDiagonale = [Pion](repeating : Pion(numero: 90 ,estBlanc : true, estGrand : true, estCarre : false, estCreux : false) , count : 4)
    //diagonale de droite
    if (x + y == 3) {
      positionX = 0
      positionY = 3
      while (i < 4){
        tabPionDiagonale[i] = self.plateau[positionX][positionY]!
        positionX += 1
        positionY -= 1
        i += 1
      }
    }
    //diagonale de gauche
    else if(x == y){
      positionX = 0
      positionY = 0
      while(i < 4){
        tabPionDiagonale[i] = self.plateau[positionX][positionY]!
        positionX += 1
        positionY += 1
        i += 1
      } 
    }
    //diagonale pas possible
    return tabPionDiagonale
  }


  //Retourne si 4 pions alignés ont une caractéristique commune.
  //Paramètres : Pion x Pion x Pion x Pion : les 4 pions alignés
  //caracCommun(J,x,y) => diagonaleComplete(J,x,y) || colonneComplete(J,y) || ligneComplete(J,x)
  //(caracCommun(J,x,y) => estGagnant(J,x,y)
  func caracCommun(p1:Pion,p2:Pion,p3:Pion,p4:Pion) -> Bool {


    if ( (p1.estCarre == p2.estCarre) && (p2.estCarre == p3.estCarre) && (p3.estCarre == p4.estCarre) ){
      return true
    }
    else if ( (p1.estBlanc == p2.estBlanc) && (p2.estBlanc == p3.estBlanc) && (p3.estBlanc == p4.estBlanc)){
      return true
    }
    else if ( (p1.estGrand == p2.estGrand) && (p2.estGrand == p3.estGrand) && (p3.estGrand == p4.estGrand)){
      return true
    }
    else if ( (p1.estCreux == p2.estCreux) && (p2.estCreux == p3.estCreux) && (p3.estCreux == p4.estCreux)){
      return true
    }
    else 
    {
      return false
    }
  }


  //renvoie true si la position choisie appartient au plateau de jeu, false sinon
  func positionPlateau(x: Int, y : Int) -> Bool
  {
   if ((x < 0 || x > 3 || y < 0 || y > 3) || (self.plateau[x][y] != nil)){
      return false
   }
   else {
      return true
   }
  }

  //fonction qui renvoie la position choisie par le joueur
  //précond : la position n'est pas occupée
  //        : la position rentrée par le joueur est une position du plateau   
  func choisirPosition() -> (Int,Int)
  {
    var cpt = true
    var positionX : Int = 0
    var positionY : Int = 0
    // tant que l'utilisateur n'as pas choisit une position valide 
    // on redemande une nouvelle saisie 
    while cpt
    {
      print("X ==> ", terminator : " ")
      if let X_scaner = readLine() 
      {
        if let verifX = Int(X_scaner)
        {
          //print("X : \(verifX)")
          print("Y ==> ", terminator : " ")
          if let Y_scaner = readLine()
          {
            if let verifY = Int(Y_scaner)  
            {
              //print("Y : \(verifY)")
              // Vérifions si la position est bien dans le plateau et pas un out of range
              if( positionPlateau(x: verifX, y : verifY))
              {
                // La position est bonne on peut retourner la position
                positionX = verifX
                positionY = verifY
                print("La position choisit est ( X : \(verifX), Y : \(verifY) )")
                cpt = false
              }
              else 
              {
                print("La valeur X -> \(verifX) \nLa valeur de Y -> \(verifY) \n !out of range 😢")      
              }
            }  
            else
            {
              print("La valeur \(Y_scaner) est de type:\(type(of: Y_scaner)) n'est pas conforme pour une position ⛔")    
            }  
          }
        }
        else
        {
          // le joueur c'est trompé à la place de mettre un entier il a mis un autre type par exemple string  
          print("La valeur \(X_scaner) est de type: \(type(of: X_scaner)) n'est pas conforme pour une position 😢")
        }  
      }
    }
    return (positionX, positionY)
  }


  /// On a changer le parametre car dans la specif on avait décidé de reperer les pion en fontion de leur numero 
  
  //Renvoie true si le pion existe bien et s'il est encore en jeu, false sinon
  //pionPossible(P) => lePionChoisi()
  // pre : choisir un numéro entre 1 et 16 
  func pionPossible(numero : Int) -> Bool
  {
    var possible = false
    if  (0 < numero && numero <= 16){
      if (self.pionsDispo[numero - 1] != nil) 
      {
        possible = true
      }
    }
    return possible
  }

  //fonction du choix du pion de l'utilisateur
  //renvoie le pion choisi par l'utilisateur
  //précond : Le pion choisi doit exister
  //        : le pion choisi doit encore etre en jeu (appartenir a pionsDispo)
  func lePionChoisi() -> Pion
  {
    print("Le numéro du pion que vous souhaiter prendre ==> ", terminator : " ")
    var num : Int = 0
    var cpt = true 
    // tant que le joueur n'as pas choisit un pion disponible
    while cpt 
    {
      if let choix = readLine()
      {
        if let verif = Int(choix)
        {
          if( pionPossible(numero : verif))
          {
            // Le pion est disponible
            num = verif
            cpt = false
          } 
          else 
          {
            // Le pion n'est pas disponible ou le numéro choisit et out of range
            print(" Pion non Disponible OU Out of range 😢")
          }
        }
        else 
        {
          print("La valeur \(choix) est de type:\(type(of: choix)) n'est pas conforme pour un pion ⛔")   
        }
      }
    }  
    return self.pionsDispo[num - 1]!
  }
    
  
  //Fonction qui pour une coordonnée (x,y) renvoie le pion qui est positionné dessus ou vide s’il y en a aucun
  //Paramètres : x : ligne | y : colonne
  //Pre : Les coordonnées sont comprises entre (0,0) et (3,3)
  //getPion(x,y) => estOccupee(J,x,y)
  func getPion(x:Int,y:Int) -> Pion? {
    return self.plateau[x][y]
  }

  //Fonction qui pour une coordonnée (x,y) renvoie le numéro du pion qui est positionné dessus ou vide s’il y en a aucun
  //Paramètres : x : ligne | y : colonne
  //Pre : Les coordonnées sont comprises entre (0,0) et (3,3)
  func getNumero(x:Int,y:Int) -> Int? {
    let pion = self.getPion(x : x,y : y)
    var numero : Int? = nil
    if (pion != nil){
      numero = pion!.numero
    }
    return numero
  }

  //Fonction qui retourne true si le coup est gagnant, false sinon
  //Paramètres : x : ligne | y : colonne
  //Pre : Les coordonnées sont comprises entre (0,0) et (3,3)
  //caracCommun(J,x,y) => estGagnant(J,x,y) 
  func estGagnant(x : Int, y : Int) -> Bool 
  {
    var gagnant : Bool = false
    // On teste si on a sur la diagonale 4 pion de meme caractéristique alors le pion choisit estgagnant 
    if (self.diagonaleComplete(x : x, y : y)){
      
      var pionsDiagonale = self.quatrePionDiagonale(x : x, y : y)
      if (caracCommun(p1 : pionsDiagonale[0], p2 : pionsDiagonale[1], p3 : pionsDiagonale[2], p4 : pionsDiagonale[3])){
        gagnant = true
      }
    }
    // On teste si on a sur la colonne 4 pion de meme caractéristique alors le pion choisit estgagnant
    else if (self.colonneComplete(y: y)){
      
      var pionsColonne = self.quatrePionColonne(y : y)
      if (caracCommun(p1 : pionsColonne[0], p2 : pionsColonne[1], p3 : pionsColonne[2], p4 : pionsColonne[3])){
        gagnant = true
      }
    }
    // On teste si on a sur la Ligne 4 pion de meme caractéristique alors le pion choisit estgagnant
    else if (self.ligneComplete(x :x)){
      
      var pionsLigne = self.quatrePionLigne(x : x)
      if (caracCommun(p1 : pionsLigne[0], p2 : pionsLigne[1], p3 : pionsLigne[2], p4 : pionsLigne[3])){
        gagnant = true
      }
    }
    return gagnant
  }
}