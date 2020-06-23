public class SubAction { //<>//
  private final float stepSizeX, stepSizeY;
  private int steps = 0;
  private int initialSteps = 0;
  private final Token token;
  private final Place place;
  private final boolean remove;
  private final Arc arc;

  SubAction(Place place, Arc arc, Token token, boolean placeToTr, int steps) {
    this.place = place; //<>//
    this.arc = arc; //<>//
    this.token = token; //<>//
    this.remove = placeToTr;
    this.steps = steps;
    this.initialSteps = steps;
    this.stepSizeX = (arc.toX - arc.fromX) / steps;
    this.stepSizeY = (arc.toY - arc.fromY) / steps; //<>//
  }

  public void makeStep() {
    token.x = token.x + stepSizeX;
    token.y = token.y + stepSizeY;
    steps--;
  }

  public void prepareAction() {
    if (remove) {
      place.removeToken(token);
    }
    token.setX(arc.getFromX());
    token.setY(arc.getFromY());
  }

  public boolean isActive() {
    return steps > 0;
  }

  public Token getToken() {
    return token;
  }
}
