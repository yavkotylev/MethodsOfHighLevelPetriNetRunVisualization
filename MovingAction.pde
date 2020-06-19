public class Action {
  private final Place fromPlace;
  private final Place toPlace;
  private final Transition viaTransition;
  private final int startTime;
  private final Token token;
  private final Arc firstArc;
  private final Arc secondArc;

  private int steps1;
  private int steps2;
  private final float stepSizeX1;
  private final float stepSizeY1;
  private final float stepSizeX2;
  private final float stepSizeY2;
  private boolean running;

  public Action(Place fromPlace, Place toPlace, Transition viaTransition, Token token, int startTime, int endTime) {
    this.fromPlace = fromPlace;
    this.toPlace = toPlace;
    this.viaTransition = viaTransition;
    this.startTime = startTime;
    this.token = token;
    this.firstArc = fromPlace.getArc(viaTransition);
    this.secondArc = toPlace.getArc(viaTransition);
    int defaultSteps = (endTime - startTime) / 2;
    stepSizeX1 = (firstArc.toX - firstArc.fromX) / defaultSteps;
    stepSizeY1 = (firstArc.toY - firstArc.fromY) / defaultSteps;
    stepSizeX2 = (secondArc.toX - secondArc.fromX) / defaultSteps;
    stepSizeY2 = (secondArc.toY - secondArc.fromY) / defaultSteps;
    steps1 = defaultSteps;
    steps2 = defaultSteps;
  }

  public void startAction() {
    token.isMoving = true;
    running = true;
    token.x = firstArc.fromX;
    token.y = firstArc.fromY;
    fromPlace.removeToken(token);
    viaTransition.highlightTransition();
  }

  public void addActionToMap(HashMap<Integer, ArrayList<Action>> map) {
    ArrayList<Action> list = map.get(startTime);
    if (list == null) {
      list = new ArrayList();
      map.put(startTime, list);
    } 
    list.add(this);
  }

  public void nextStep() {
    if (token.isMoving) {
      if (steps1 != 0) {
        steps1--;
        makeNextStep(stepSizeX1, stepSizeY1);
        if (steps1 == 0) {
          token.x = token.x + viaTransition.radius;
          token.x = secondArc.fromX;
          token.y = secondArc.fromY;
          viaTransition.blackTransition();
        }
      } else if (steps2 != 0) {
        steps2--;
        makeNextStep(stepSizeX2, stepSizeY2);
      } else {
        token.isMoving = false;
        toPlace.addToken(token);
        running = false;
      }
    }
  }

  private void makeNextStep(float moveX, float moveY) {
    token.x = token.x + moveX;
    token.y = token.y + moveY;
    token.updateHalf();
  }
}
