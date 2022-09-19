//------------------------------------------------------------------------//
//--------------------------- Type Abstrait ------------------------------//
//------------------------------------------------------------------------//

protocol TPion {
  //  Initialise un pion avec un numéro et ses caractéristiques 
  //  Chaque pion doit avoir une unique combinaison des caractéristiques
  //  Les 4 caractéristiques sont : couleur (noir ou blanc), taille (petit ou      grand), forme (rectangle ou arrondi) et remplissage (plein ou creux)
  
  init(numero:Int,estBlanc : Bool, estGrand : Bool, estCarre : Bool, estCreux : Bool)
  
  //  renvoie le numéro du pion
  var numero : Int {get}

  //  renvoie true si le pion est blanc, false sinon
  var estBlanc : Bool { get }
  
  //  renvoie  true si grand, false sinon
  var estGrand : Bool { get }
  
  //  renvoie true si le pion est carré, false sinon
  var estCarre : Bool { get }
  
  //  renvoie true si c’est creux, false sinon
  var estCreux : Bool { get }
  
  //--------- Modification ------------
  //  Retourne la position d’un pion s’il en a une ou vide
  //  func getCoord()-> (Int, Int)?   

  /// - le pion n'as pas besoin d'avoir une position car une fois on le place sur le plateau on ne pourra pas modifier son emplacement.Donc la fonction getCoord n'est pas utilise pour ce type et ne l'a pas utilisé sur aucune des structures
}

//------------------------------------------------------------------------//
//--------------------------- Type Concret -------------------------------//
//------------------------------------------------------------------------//

struct Pion : TPion 
{
  //  Initialise un pion avec un numéro et ses caractéristiques 
  //  Chaque pion doit avoir une unique combinaison des caractéristiques
  //  Les 4 caractéristiques sont : couleur (noir ou blanc), taille (petit ou      grand), forme (rectangle ou arrondi) et remplissage (plein ou creux)

  init(numero : Int, estBlanc : Bool, estGrand : Bool, estCarre : Bool, estCreux : Bool){
    self.numero = numero 
    self.estBlanc = estBlanc
    self.estGrand = estGrand
    self.estCarre = estCarre
    self.estCreux = estCreux
  }

  
  //  renvoie true si le pion est blanc, false (Noir) sinon
  var estBlanc : Bool
  
  //  renvoie  true si grand, false (petit) sinon
  var estGrand : Bool
  
  //  renvoie true si le pion est carré, false (rond) sinon
  var estCarre : Bool
  
  //  renvoie true si c’est creux, false (complet) sinon
  var estCreux : Bool

  //  revoie le numero du Pion
  var numero : Int
}


