public class Arc {
  private final boolean fromPlaceToTransition;
  private final Place place;
  private final Transition transition;
  private final float fromX, fromY;
  private final float toX, toY;

  public Arc(Place fromPlace, Transition toTransition) {
    this.place =  fromPlace;
    this.transition = toTransition;
    if (fromPlace.x < toTransition.x) {
      this.fromX = fromPlace.x + fromPlace.radius;
      this.toX = toTransition.x;
    } else {
      this.fromX = fromPlace.x - fromPlace.radius;
      this.toX = toTransition.x + toTransition.diameter;
    }
    this.fromY = fromPlace.y;
    this.toY = toTransition.y + toTransition.radius;
    this.fromPlaceToTransition = true;

    fromPlace.addArc(toTransition, this);
  }

  public Arc(Transition fromTransition, Place toPlace) {
    this.place = toPlace; 
    this.transition = fromTransition;
    if (fromTransition.x < toPlace.x) {
      this.fromX = fromTransition.x + fromTransition.diameter;
      this.toX = toPlace.x - toPlace.radius;
    } else {
      this.fromX = fromTransition.x;
      this.toX = toPlace.x + toPlace.radius;
    }
    this.fromY = fromTransition.y + fromTransition.radius;
    this.toY = toPlace.y;
    this.fromPlaceToTransition = false;
    toPlace.addArc(fromTransition, this);
  }

  public boolean equals(Place place, Transition transition, boolean fromPlaceToTransition) {
    if (this.fromPlaceToTransition == fromPlaceToTransition) {
      if (this.place == place && this.transition == transition) {
        return true;
      }
    }
    return false;
  }

  public Transition getTransition() {
    return this.transition;
  }

  public void draw() {
    line(fromX, fromY, toX, toY);
  }
  public float getFromX() {
    return fromX;
  }

  public float getFromY() {
    return fromY;
  }
}
