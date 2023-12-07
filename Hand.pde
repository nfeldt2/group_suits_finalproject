class Hand{
  ArrayList<Card> deck;
  ArrayList<Card> hand;
  Map<Integer, Integer> myLookup;
  
  
  Hand(ArrayList<Card> deck, Map<Integer, Integer> myLookup){
    this.deck = deck;
    this.hand = new ArrayList<Card>();
    this.myLookup = myLookup;
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
  
  void resetHand() {
    hand = new ArrayList<Card>();
  }
  
  int getSize(){
    return hand.size();
  }

  Card getCard(int cardIndex){
    return hand.get(cardIndex);
  }
  
  boolean isFlush() {
    // check if every card in the hand has the same suit
    String suit = hand.get(0).suit;
    for (Card card : hand) {
      String encoding = card.suit;
      if ((encoding) != suit) {
        return false;
      }
      
    }
    return true;
  }
  
  int findBestHand() {
    int product;
    int rank;
    int min = 10000;
    // first two cards must be in the hand
    int card1 = hand.get(0).encoding;
    hand.get(0).flip();
    int card2 = hand.get(1).encoding;
    hand.get(1).flip();
    for (int i = 2; i < hand.size() - 2; i++) {
            for (int j = i + 1; j < hand.size() - 1; j++) {
                for (int k = j + 1; k < hand.size(); k++) {
                            
                            product = card1 * card2 * hand.get(i).encoding * hand.get(j).encoding * hand.get(k).encoding; 
                            if (isFlush()) {
                              product *= 2;
                            }
 
                            rank = myLookup.get(product);
                            if (rank < min) {
                              min = rank;
                            }
                        }
                    }
                }
    return min;
  }
  
  
  int getValue() {
    int product = 1;
    for (Card card : hand) {
      product *= card.encoding;
    }
    if (isFlush()) {
      product *= 2;
    }
    return product;
  }

}
