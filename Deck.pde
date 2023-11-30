import java.util.Collections;

class Deck{
  ArrayList<Card> deck;
  
  Deck(ArrayList<Card> deck){
    this.deck = deck;
  }
  
  ArrayList<Card> getDeck(){
    return deck;  
  }
  
  void shuffleCards(){
    Collections.shuffle(deck);
  }
  
  void readDeck(){
    for (int i = 0; i < deck.size(); i++){
      println(deck.get(i).readCard());
    }
  }
  
  void removeCard(Card currentCard){
    for (int i = 0; i < deck.size(); i++){
      if (currentCard == deck.get(i)){
        deck.remove(i);
      }
    }
  }
  
  int getSize(){
    return deck.size();
  }
  
}
