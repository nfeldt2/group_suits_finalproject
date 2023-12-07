Deck myDeck;
Hand myHand;
PrimeLookup myLookup = new PrimeLookup();
PokerTable myTable;
Table table;
ArrayList<Card> deck;
String[] suits = {"Spades", "Clubs", "Diamonds", "Hearts"};
String[] numbers = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"};
PImage tableSprite;
boolean play = false;
ArrayList<Card> displayedCards;
int lastDealtTime; // Tracks the last time a card was dealt
int cardCount; // Counts the number of cards dealt
int nextCard = 0;
int lastPlayTime;
final int dealInterval = 500;
final int maxCards = 10; // Maximum number of cards to deal
final int playInterval = 1000;
public boolean raise = false;
public boolean fold = false;
public boolean check = false;
int lastPressed = 0;

int bankBalance = 1000;
public int buyInAmount = 100;
int playerCostume = 0;
boolean settingsWindow = false;

Button buyInPlusButton, buyInMinusButton, startButton, settingsButton, exitButton, musicToggleButton, raiseButton, checkButton, foldButton;
RadioButton[] difficultyButtons;
int aiDifficulty = 0; // 0 for easy, 1 for hard

//Audio variables
AudioManager audio;

void setup() {
  // create hashmap
  table = loadTable("poker_output.csv", "header");
  
  for (TableRow row : table.rows()) {
    int rank = row.getInt(0);
    int product = row.getInt(8);
    myLookup.addValue(product, rank);
  }
  Map<Integer, Integer> lookup = myLookup.lookupTable;
  size(800, 600);
  color red = color(255, 0, 0);
  color green = color(0, 255, 0);
  color blue = color(0, 0, 255);
  color gray = color(200);
  
  tableSprite = loadImage("table/poker_table.png");
  
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
  myTable = new PokerTable(true, myDeck.deck, lookup);

  buyInPlusButton = new Button(width/2 + 60, 135, 20, 20, gray);
  buyInMinusButton = new Button(width/2 - 80, 135, 20, 20, gray);
  startButton = new Button(width/2 - 50, 200, 100, 50, green);
  settingsButton = new Button(width/2 - 50, 260, 100, 50, blue);
  exitButton = new Button(width/2 - 50, height/2 + 100, 100, 50, red);
  musicToggleButton = new Button(width/2 - 50, height/2 + 25, 100, 50, gray);
  
  raiseButton = new Button(width/2 + 100, 340, 100, 30, green);
  checkButton = new Button(width/2 + 100, 380, 100, 30, gray);
  foldButton = new Button(width/2 + 100, 420, 100, 30, red);

  difficultyButtons = new RadioButton[2];
  difficultyButtons[0] = new RadioButton(width/2 - 50, height/2 - 30, 10, 20, gray, 0, difficultyButtons);
  difficultyButtons[1] = new RadioButton(width/2 + 50, height/2 - 30, 10, 20, gray, 1, difficultyButtons);
  
  audio = new AudioManager(this);
  audio.startMusic();
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
    
    // gameplay buttons
    raiseButton.display();
    checkButton.display();
    foldButton.display();
    
    
    fill(0);
    text("Raise", raiseButton.x + 40, raiseButton.y + 20);
    text("Check", checkButton.x + 40, checkButton.y + 20);
    text("Fold", foldButton.x + 40, foldButton.y + 20);
    
    text("Bet:" + myTable.checkValue, 350, 400);
  
    if (myTable.play && millis() - lastPlayTime > playInterval) {
      
      if (myTable.play) {
        print(myTable.currentPlayer);
        if (myTable.currentPlayer == 2) {
          // implement user player functionality
          // if player has made his move make sure to set myTable.user = false; lastPlayTime = millis();
          if (raise) {
            print(raise);
            //implement button to determine raise amount
            myTable.players.get(myTable.currentPlayer).raise();
            //assign check value to amount raised
            myTable.checkValue += 5;
            myTable.incrementPot();
            myTable.lastPlayer = myTable.currentPlayer;
            myTable.currentPlayer++;
            raise = false;
          }
          if (fold) {
            myTable.players.get(myTable.currentPlayer).fold();
            myTable.currentPlayer++;
            fold = false;
          }
          if (check) {
            myTable.players.get(myTable.currentPlayer).check(myTable.checkValue);
            myTable.incrementPot();
            myTable.currentPlayer++;
            check = false;
          }
        } else {
          // do AI player play
          // set lastPlayTime = millis();
          print(myTable.currentPlayer);
          myTable.currentPlayer++;
        }
        lastPlayTime = millis();
        if (myTable.currentPlayer == myTable.lastPlayer) {
          myTable.currentPlayer = 0;
          myTable.lastPlayer = 5;
          if (myTable.current_community == 3) {
            int winner = myTable.getWinner();
            print("winner: " + winner);
            myTable.players.get(winner).addPot(myTable.pot);
            myTable.newRound();
            cardCount = 0;
            myTable.play = false;
            myDeck.shuffleCards();
            myTable.deck = myDeck.deck;
            lastDealtTime = millis() + 1000;
          } else {
            myTable.community = true;
          }
        } else if (myTable.currentPlayer == 5) {
          myTable.currentPlayer = 0;
        }
      }
    }
    if (millis() - lastDealtTime > dealInterval && cardCount < maxCards) {
          Card tempCard = deck.get(myTable.current_card);
          myTable.dealCard(tempCard);
          lastDealtTime = millis();
          cardCount++;
      } else if (myTable.community && millis() - lastDealtTime > dealInterval) {
        myTable.dealCommunity();
        lastDealtTime = millis();
        lastPlayTime = millis();
      }
      
      for (int i = myTable.displayedCards.size() - 1; i >= 0; i--) {
        Card card = myTable.displayedCards.get(i);
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
  
  musicToggleButton.display();
  exitButton.display();
  fill(255);
  textSize(20);
  text("Exit", exitButton.x + 50, exitButton.y + 25);
  text("Toggle\nMusic", musicToggleButton.x + 50, musicToggleButton.y + 20);
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
    if (musicToggleButton.isPressed(mouseX, mouseY)) {
      if (audio.music.isPlaying()) {
        audio.stopMusic();
      } else {
        audio.startMusic(); 
      }
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
  if (play && 1000 < millis() - lastPressed) {
    if (checkButton.isPressed(mouseX, mouseY)) {
      check = true;
      lastPressed = millis();
    }
    if (raiseButton.isPressed(mouseX, mouseY)) {
      raise = true;
      lastPressed = millis();
    }
    if (foldButton.isPressed(mouseX, mouseY)) {
      fold = true;
      lastPressed = millis();
    }
  }
}
