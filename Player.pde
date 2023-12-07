class Player {
  
  Hand hand;
  int bank;
  
  Player(ArrayList<Card> deck, Map<Integer, Integer> myLookup) {
    hand = new Hand(deck, myLookup);
    bank = buyInAmount;
  }
  
  void raise() {}
  
  void check() {}
  
  void fold() {}
  
}
