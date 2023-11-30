class Card{
  String suit;
  String number;
  
  Card(String suit, String number){
    this.suit = suit;
    this.number = number;
  }
  
  String getType(){
    return suit;
  }

  String getValue(){
    return number;
  }

  String readCard(){
    String text = "your card is " + number + " of " + suit + "s";
    return text;
  }

}
