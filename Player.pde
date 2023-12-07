class Player {
  
  Hand hand;
  int bank;
  int id;
  
  int currentBet = 0;
  
  Player(ArrayList<Card> deck, Map<Integer, Integer> myLookup, int id) {
    hand = new Hand(deck, myLookup);
    bank = buyInAmount;
    this.id = id;
  }
  
  void reset() {
    currentBet = 0;
  }
  
  void raise() {
    currentBet += 5;
  }
  
  void check() {}
  
  void fold() {}
  
}
