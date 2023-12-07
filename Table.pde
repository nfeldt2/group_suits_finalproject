class PokerTable{
  ArrayList<Player> players;
  ArrayList<Card> community_hand;
  boolean round_complete = false;
  boolean community = true;
  boolean play = false;
  boolean user = false;
  int currentPlayer = 0;
  int current_community = 0;
  int num_players = 5;
  int current_card = 0;
  ArrayList<Card> deck;
  ArrayList<Card> displayedCards;
  Map<Integer, Integer> myLookup;
  
  PokerTable(boolean deal_players, ArrayList<Card> deck, Map<Integer, Integer> myLookup) { 
    this.deck = deck;
    this.myLookup = myLookup;
    this.play = play;
    this.currentPlayer = currentPlayer;
    this.current_card = current_card;
    this.community = community;
    players = new ArrayList<Player>();
    this.displayedCards = new ArrayList<Card>();
  }
  
  void addPlayer() {
    players.add(new Player(deck, myLookup));
  }
  
  void removePlayer(int player) {
    // if the player folds
    players.remove(player);
  }
  
  int getWinner() {
    int player_num = 0;
    int winner = 0;
    int best = 10000;
    int temp;
    for (Player player : players) {
      temp = player.hand.findBestHand();
      println("player: " + player_num + " rank: " + temp);
      if (temp < best) {
        best = temp;
        winner = player_num;
      }
      player_num += 1;
    }
    return winner;
  }
  
  int getSize() {
    return players.size();
  }
  
  void addCard(int player, int index) {
    players.get(player).hand.addCard(index);
  }
  
  
  void dealCommunity() {
    if (current_community == 0) {
      for (int i = 0; i < 3; i++) {
         Card temp = deck.get(current_card);
         int player_num = 5 + i;
         int cardNumber = 0;
         temp.deal(player_num, cardNumber);
         for (Player player : players) {
           player.hand.addCard(current_card);
         }
         displayedCards.add(temp);
         current_card++;
      }
      current_community++;
      community = false;
    } else {
       Card temp = deck.get(current_card);
       int player_num = 8 + (current_card - 13);
       int cardNumber = 0;
       temp.deal(player_num, cardNumber);
       for (Player player : players) {
         player.hand.addCard(current_card);
       }
       displayedCards.add(temp);
       current_card++;
       current_community++;
       community = false;
    }
    this.play = true;
  }
  
  void dealCard(Card temp) {
    int player = current_card % 5;
    int cardNumber = current_card / 5;
    temp.deal(player, cardNumber);
    
    if (myTable.getSize() != 5) {
      this.addPlayer();
    }
    
    this.addCard(player, current_card);
    current_card++;
    displayedCards.add(temp);
  }
}
    
  
