public class Token extends BaseShape {
  private float diameter;
  private boolean isMoving = false;
  private final color tokenColor;

  public Token(String id, String name, float diameter, color c) {
    super(id, name, 0, 0);
    this.diameter = diameter;
    this.tokenColor = c;
  }

  public void draw() {
    fill(tokenColor);
    circle(this.x, this.y, diameter);
    fill(255);
  }
}
