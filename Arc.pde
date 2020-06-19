public class Arc {
  private Place place;
  public float fromX, fromY;
  public float toX, toY;

  public Arc(Place fromPlace, Transition toTransition) {
    this.place =  fromPlace;
    if (fromPlace.x < toTransition.x) {
      this.fromX = fromPlace.x + fromPlace.radius;
      this.toX = toTransition.x;
    } else {
      this.fromX = fromPlace.x - fromPlace.radius;
      this.toX = toTransition.x + toTransition.diameter;
    }
    this.fromY = fromPlace.y;
    this.toY = toTransition.y + toTransition.radius;
  }

  public Arc(Transition fromTransition, Place toPlace) {
    this.place = toPlace; 
    if (fromTransition.x < toPlace.x) {
      this.fromX = fromTransition.x + fromTransition.diameter;
      this.toX = toPlace.x - toPlace.radius;
    } else {
      this.fromX = fromTransition.x;
      this.toX = toPlace.x + toPlace.radius;
    }
    this.fromY = fromTransition.y + fromTransition.radius;
    this.toY = toPlace.y;
  }

  public void draw() {
    line(fromX, fromY, toX, toY);
  }

  public Place getPlace() {
    return place;
  }
}
