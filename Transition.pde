public class Transition {
  public final float x;
  public final float y;
  public final float diameter;
  public final float radius;
  public int red = 0;

  public Transition(float x, float y, float diameter) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.radius = diameter/2;
  }

  public void draw() {
    if (red > 0) {
      fill(138, 255, 138);
      rect(x, y, diameter, diameter);
      fill(255);
    } else {
      rect(x, y, diameter, diameter);
    }
  }


  public void highlightTransition() {
    red++;
  }

  public void blackTransition() {
    red--;
  }
}
