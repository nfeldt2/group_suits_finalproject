Deck myDeck;
Hand myHand;
Table myTable;
ArrayList<Card> deck;
String[] suits = {"Spades", "Clubs", "Diamonds", "Hearts"};
String[] numbers = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"};
PImage tableSprite;
PImage raise;
PImage fold;
PImage check;
boolean play = false;
ArrayList<Card> displayedCards;
int lastDealtTime; // Tracks the last time a card was dealt
int cardCount; // Counts the number of cards dealt
int nextCard = 0;
final int dealInterval = 500; // Time interval in milliseconds (500ms = 0.5 seconds)
final int maxCards = 10; // Maximum number of cards to deal

int bankBalance = 1000;
int buyInAmount = 100;
int playerCostume = 0;
boolean settingsWindow = false;

Button buyInPlusButton, buyInMinusButton, startButton, settingsButton, exitButton;
RadioButton[] difficultyButtons;
int aiDifficulty = 0; // 0 for easy, 1 for hard

void setup() {
  size(800, 600);
  color red = color(255, 0, 0);
  color green = color(0, 255, 0);
  color blue = color(0, 0, 255);
  color gray = color(200);
  
  tableSprite = loadImage("table/poker_table.png");
  raise = loadImage("table/raise_button.png");
  fold = loadImage("table/fold_button.png");
  check = loadImage("table/check_button.png");
  check.resize(0, 50);
  fold.resize(0, 55);
  raise.resize(0, 48);
  
  // creates and shuffles the deck
  deck = new ArrayList<Card>();
  for (int i = 0; i < suits.length; i++){
    for (int j = 0; j < numbers.length; j++){
      Card tempCard = new Card(suits[i], numbers[j]);
      deck.add(tempCard);
    }
  }
  myDeck = new Deck(deck);
  myDeck.shuffleCards();
  
  // creates a hand for player and updates the deck
  displayedCards = new ArrayList<Card>();
  myTable = new Table(true, myDeck.deck);

  buyInPlusButton = new Button(width/2 + 60, 135, 20, 20, gray);
  buyInMinusButton = new Button(width/2 - 80, 135, 20, 20, gray);
  startButton = new Button(width/2 - 50, 200, 100, 50, green);
  settingsButton = new Button(width/2 - 50, 260, 100, 50, blue);
  exitButton = new Button(width/2 - 50, height/2 + 100, 100, 50, red);

  difficultyButtons = new RadioButton[2];
  difficultyButtons[0] = new RadioButton(width/2 - 50, height/2 - 30, 10, 20, gray, 0, difficultyButtons);
  difficultyButtons[1] = new RadioButton(width/2 + 50, height/2 - 30, 10, 20, gray, 1, difficultyButtons);
}

void draw() {
  if (settingsWindow) {
    drawSettingsWindow();
  } else {
    Menu();
  }
}

void Menu() {
  background(255);
  drawTitle();
  drawBankDisplay();
  drawBuyInAdjustment();
  drawPlayerCostume();

  buyInPlusButton.display();
  buyInMinusButton.display();
  startButton.display();
  settingsButton.display();

  fill(0);
  text("+", buyInPlusButton.x + 10, buyInPlusButton.y + 15);
  text("-", buyInMinusButton.x + 10, buyInMinusButton.y + 15);
  text("Start", startButton.x + 50, startButton.y + 30);
  fill(255);
  text("Settings", settingsButton.x + 50, settingsButton.y + 30);
  
  if (play) {
    background(255);
    imageMode(CORNER);
    image(tableSprite, 75, 0);
    image(check, 600, 325);
    image(fold, 510, 323);
    image(raise, 670, 325);
    fill(0);
    text(mouseX + ", " + mouseY, 10, 20);
    
    if (millis() - lastDealtTime > dealInterval && cardCount < maxCards) {
          Card tempCard = deck.get(nextCard);
          dealCard(tempCard);
          nextCard += 1;
          lastDealtTime = millis();
          cardCount++;
      }
      
      for (int i = displayedCards.size() - 1; i >= 0; i--) {
        Card card = displayedCards.get(i);
        if (card.update()) {
            card.display();
        }
      }
  }
}

void drawTitle() {
  textSize(32);
  textAlign(CENTER);
  fill(0);
  text("Texas Hold 'Em", width/2, 50);
}

void drawBankDisplay() {
  textSize(20);
  textAlign(CENTER);
  fill(0);
  text("Bank: $" + bankBalance, width/2, 100);
}

void drawBuyInAdjustment() {
  textSize(20);
  textAlign(CENTER);
  fill(0);
  text("Buy-in: $" + buyInAmount, width/2, 150);
}

void drawPlayerCostume() {
  // placeholder for player costume display
  rect(width/2 - 50, 320, 100, 100);

  // add left and right arrows for costume change
  textSize(20);
  text("<", width/2 - 70, 370);
  text(">", width/2 + 70, 370);
}

void drawSettingsWindow() {
  fill(0, 0, 0, 150);
  rect(0, 0, width, height);
  fill(255);
  rect(width/4, height/4, width/2, height/2);

  for (RadioButton button : difficultyButtons) {
    button.display();
  }

  exitButton.display();
  fill(255);
  textSize(20);
  text("Exit", exitButton.x + 50, exitButton.y + 25);
  fill(0);
  text("Easy", width/2 - 15, height/2 - 23);
  text("Hard", width/2 + 85, height/2 - 23);
}

void mousePressed() {
  if (settingsWindow) {
    for (RadioButton button : difficultyButtons) {
      if (button.isPressed(mouseX, mouseY)) {
        aiDifficulty = button.id;
      }
    }
    if (exitButton.isPressed(mouseX, mouseY)) {
      settingsWindow = false;
    }
  } else {
    if (buyInPlusButton.isPressed(mouseX, mouseY)) {
      buyInAmount = min(buyInAmount + 100, bankBalance);
    }
    if (buyInMinusButton.isPressed(mouseX, mouseY)) {
      buyInAmount = max(buyInAmount - 100, 100);
    }
    if (startButton.isPressed(mouseX, mouseY)) {
      play = true;
    }
    if (settingsButton.isPressed(mouseX, mouseY)) {
      settingsWindow = true;
    }
  }
}

void dealCard(Card temp) {
    int player = nextCard % 5;
    int cardNumber = nextCard / 5;
    temp.deal(player, cardNumber);
    
    if (myTable.getSize() != 5) {
      myTable.addPlayer();
    }
    myTable.addCard(player, nextCard);
    
    displayedCards.add(temp);
}
