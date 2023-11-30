class Hand{
  ArrayList<Card> deck;
  ArrayList<Card> hand;
  
  Hand(ArrayList<Card> deck){
    this.deck = deck;
    this.hand = new ArrayList<Card>();
  }
  
  void addCard(int current){
    Card temp = deck.get(current);
    hand.add(temp);
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
