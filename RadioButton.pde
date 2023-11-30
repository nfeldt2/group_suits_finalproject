class RadioButton extends Button {
  int id;
  RadioButton[] group;
  boolean isChecked;

  RadioButton(float x, float y, float r1, float r2, color buttonColor, int id, RadioButton[] group) {
    super(x, y, r1, r2, buttonColor);
    this.id = id;
    this.group = group;
  }

  void display() {
    fill(buttonColor);
    ellipse(x, y, r2, r2); // draws the outer circle of the radio button

    if (isChecked) {
      fill(0);
      ellipse(x, y, r1, r1); // draws the inner circle to show it's selected
    }
  }

  boolean isPressed(int mx, int my) {
    if (dist(mx, my, x, y) < r2) {
      for (int i = 0; i < group.length; i++) {
        group[i].isChecked = (i == id);
      }
      return true;
    }
    return false;
  }
}
