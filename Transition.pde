public class Transition extends BaseShape {
  public final float diameter, radius;
  private int colorCount = 0;
  private color transitionCol;
  private float centerX = 0;
  private float centerY = 0;

  public Transition(String id, String name, float x, float y, float diameter) {
    super(id, name, x - diameter/2, y - diameter/2);
    this.diameter = diameter;
    this.radius = diameter/2;
    this.centerX = x;
    this.centerY = y;
  }

  public void draw() {
    if (colorCount > 0) {
      fill(transitionCol);
      rect(x, y, diameter, diameter);
      fill(255);
    } else {
      rect(x, y, diameter, diameter);
    }
  }

  public void setColor(color c) {
    transitionCol = c;
    colorCount++;
  }

  public void removeColor() {
    colorCount--;
  }
}
