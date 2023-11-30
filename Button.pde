class Button {
  float x, y;
  float r1, r2;
  color buttonColor;
  boolean isOver = false;
  boolean isPressed = false;

  Button(float x, float y, float r1, float r2, color buttonColor) {
    this.x = x;
    this.y = y;
    this.r1 = r1;
    this.r2 = r2;
    this.buttonColor = buttonColor;
  }

  void display() {
    fill(buttonColor);
    rect(x, y, r1, r2);
  }

  boolean isPressed(int mx, int my) {
    isOver = (mx >= x && mx <= x + r1 && my >= y && my <= y + r2);
    isPressed = isOver && mousePressed;
    return isPressed;
  }
}
