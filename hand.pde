class Hand{
  ArrayList<Card> deck;
  ArrayList<Card> hand;
  
  Hand(ArrayList<Card> deck){
    this.deck = deck;
    hand = setHand();
  }
  
  ArrayList<Card> setHand(){
    int numCards = 5;
    ArrayList tempHand = new ArrayList();
    for (int i = 0; i < numCards; i++){
      tempHand.add(deck.get(i));
    }
    return tempHand;
  }
  
  ArrayList<Card> getHand(){
    return hand;  
  }
  
  void readHand(){
    for (int i = 0; i < hand.size(); i++){
      println(hand.get(i).readCard());
    }
  }
  
  int getSize(){
    return hand.size();
  }

  Card getCard(int cardIndex){
    return hand.get(cardIndex);
  }

}
