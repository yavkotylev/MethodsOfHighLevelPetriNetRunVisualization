public class Token {
  private float x;
  private float y;
  private float diameter;
  private boolean isMoving = false;

  public Token(float diameter) {
    this.diameter = diameter;
  }

  public void draw() {
    circle(x, y, diameter);
  }
  
  public float getX(){
     return x; 
  }
  public float getY(){
     return y; 
  }
  
  public void updateHalf(){
    
  }
}
