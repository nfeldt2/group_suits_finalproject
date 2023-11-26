Deck myDeck;
Hand myHand;
ArrayList<Card> deck;
String[] suits = {"spade", "club", "diamond", "heart"};
String[] numbers = {"ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"};

void setup(){
  size(800, 400);
  
  //creates and shuffles the deck
  deck = new ArrayList<Card>();
  for (int i = 0; i < suits.length; i++){
    for (int j = 0; j < numbers.length; j++){
      Card tempCard = new Card(suits[i], numbers[j]);
      deck.add(tempCard);
    }
  }
  myDeck = new Deck(deck);
  myDeck.shuffleCards();
  
  //creates a hand for player and updates the deck
  myHand = new Hand(deck);
  for (int i = 0; i < myHand.getSize(); i++){
    myDeck.removeCard(myHand.getCard(i));
  }
  
  myDeck.readDeck();
  println();
  myHand.readHand();
  
}

void draw(){
//drawCards();
}

//draws the players current cards
void drawCards(){  
  //rect()
}

//checks all players hands to determine who has the best hand
void ruleCheck(){

}
