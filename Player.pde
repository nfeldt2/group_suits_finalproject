class Player {
  
  Hand hand;
  int bank;
  int id;
  boolean fold = false;
  
  int currentBet = 0;
  
  Player(ArrayList<Card> deck, Map<Integer, Integer> myLookup, int id) {
    hand = new Hand(deck, myLookup);
    bank = buyInAmount;
    this.id = id;
    this.fold = fold;
  }
  
  void reset() {
    currentBet = 0;
  }
  
  void raise() {
    currentBet += 5;
  }
  
  void check(int checkAmount) {
  bank -= checkAmount;
}
  
  void fold() {
    fold = true;
  }

  void addPot (int pot) {}
  
}
