Deck myDeck;
Hand myHand;
ArrayList<Card> deck;
String[] suits = {"spade", "club", "diamond", "heart"};
String[] numbers = {"ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"};

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
  myHand = new Hand(deck);
  for (int i = 0; i < myHand.getSize(); i++){
    myDeck.removeCard(myHand.getCard(i));
  }

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
  text("Settings", settingsButton.x + 50, settingsButton.y + 30);
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
  text("Easy", width/2 - 30, height/2 - 25);
  text("Hard", width/2 + 70, height/2 - 25);
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
      // start game logic
      // drawCards();
      // must implement drawCards() and ruleCheck() to determine best hand
    }
    if (settingsButton.isPressed(mouseX, mouseY)) {
      settingsWindow = true;
    }
  }
}
