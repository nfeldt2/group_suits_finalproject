class Card {
  String suit;
  String number;
  PImage image;
  float startX, startY;
  float endX, endY;
  float x, y;
  float rotation;
  float t;
  int player;
  String filename;
  int encoding;
  final int[] PRIMES = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41};
  int[] positionsX = {260, 165, 386, 625, 515, 330, 364, 398, 432, 470};
  int[] positionsY = {90, 175, 267, 180, 90, 180, 180, 180, 180, 180};
  ParticleSystem p;
  
  boolean doneMoving = false;

  Card(String suit, String number) {
    this.suit = suit;
    this.number = number;
    this.encoding = encodeCard();
    makeParticles();
  }
  
  int encodeCard() {
    int rank = stringRankToInt(number);;
    
    int prime = PRIMES[rank - 2];
    
    return prime;
  }
        
  
  int stringRankToInt(String rankStr) {
    switch (rankStr) {
            case "A":
                return 14;
            case "K":
                return 13;
            case "Q":
                return 12;
            case "J":
                return 11;
            default:
                return Integer.parseInt(rankStr);
        }
  }

  void deal(int player, int cardNumber) {
    this.player = player;
    if (player == 2 || player > 4) {
      filename = "cards/card" + suit + number + ".png";
    } else {
      filename = "cards/cardBack_red4.png";
    }

    this.image = loadImage(filename);
    image.resize(0, 40);
    this.startX = 400;
    this.startY = 20;
    this.endX = positionsX[player];
    this.endY = positionsY[player];
    if (cardNumber > 0) {
      if (player == 1 || player == 3) {
        this.endY += 10;
      } else {
        this.endX += 10;
      }
    }

    this.x = startX;
    this.y = startY;
    this.rotation = 0;
    this.t = 0;
  }

  void makeParticles() {
    p = new ParticleSystem(x, y, 5);
    p.startSystem();
  }

  String getType() {
    return suit;
  }

  String getValue() {
    return number;
  }

  String readCard() {
    String text = "your card is " + number + " of " + suit + "s";
    return text;
  }

  boolean update() {
    if (t >= 1) {
      doneMoving = true;
      return true;
    }
    x = lerp(startX, endX, t);
    y = lerp(startY, endY, t);
    if (player == 1 || player == 3) {
      rotation = ((PI + PI/2) * t);
    } else {
      rotation = PI * t;
    }
    t += 0.01;
    return t <= 1;
  }
  
  void flip() {
    String filename = "cards/card" + suit + number + ".png";
    image = loadImage(filename);
    image.resize(0, 40);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    imageMode(CENTER);
    image(image, 0, 0);
    popMatrix();
    if (!doneMoving) {
      p.updateOrigin(x, y);
      p.show();
    }
  }
}
