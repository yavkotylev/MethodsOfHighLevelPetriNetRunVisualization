public class BaseShape {
  protected float x, y;
  protected final String id, name;

  public BaseShape(String id, String name, float x, float y) {
    this.id = id;
    this.name = name;
    this.x = x;
    this.y = y;
  }

  public void setX(float x) {
    this.x = x;
  }

  public void setY(float y) {
    this.y = y;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
}
