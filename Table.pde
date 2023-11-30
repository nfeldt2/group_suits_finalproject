class Table{
  ArrayList<Hand> players;
  ArrayList<Card> community_hand;
  boolean round_complete = false;
  int current_community = 0;
  int num_players = 5;
  int current_card = 0;
  ArrayList<Card> deck;
  
  Table(boolean deal_players, ArrayList<Card> deck) { 
    this.deck = deck;
    players = new ArrayList<Hand>();
    if (current_community > 1 && current_community != 3) {
      //deal_community(current_community);
      current_community += 1;
    }
  }
  
  
  void addPlayer() {
    players.add(new Hand(deck));
  }
  
  int getSize() {
    return players.size();
  }
  
  void addCard(int player, int index) {
    players.get(player).addCard(index);
  }
}
    
    
  
