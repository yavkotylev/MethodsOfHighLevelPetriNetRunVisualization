public class Action {
  private final ArrayList<SubAction> before = new ArrayList();
  private final ArrayList<SubAction> after = new ArrayList();
  private final Transition viaTransition;
  private final int startTime, endTime;
  private final color transitionCol;
  private final int weight;
  private final Net net;

  private boolean running;

  public Action(int startTime, int endTime, int weight, Transition viaTransition, Net net, HashMap<Token, Place> removeMap, HashMap<Token, Place> addMap, color transitionCol) {
    this.startTime = startTime; //<>//
    this.endTime = endTime;
    this.weight = weight;
    this.viaTransition = viaTransition;
    this.net = net;
    this.transitionCol = transitionCol;
    int diff = endTime - startTime; //<>//

    for (Token t : removeMap.keySet()) {
      Place p = removeMap.get(t);
      before.add(new SubAction(p, p.getArc(viaTransition, true), t, true, diff/2)); //<>//
    }
    for (Token t : addMap.keySet()) {
      Place p = addMap.get(t);
      after.add(new SubAction(p, p.getArc(viaTransition, false), t, false, diff - diff/2)); //<>//
    } //<>//
  }
  public void startAction() {
    running = true;
    viaTransition.setColor(transitionCol);
    for (SubAction sa : before) {
      sa.prepareAction();
    }
  }

  public void tick() {
    if (running) {
      if (before.get(0).isActive()) {
        for (SubAction sa : before) {
          sa.makeStep();
        }
        if (!before.get(0).isActive()) {
          for (SubAction sa : before) {
            sa.place.removeToken(sa.getToken());
            net.removeActiveToken(sa.getToken());
          }
          for (SubAction sa : after) {
            net.addActiveToken(sa.getToken());
            sa.prepareAction();
          }
          viaTransition.removeColor();
        }
      } else {
        if (!after.get(0).isActive()) {
          running = false;
          for (SubAction sa : after) {
            sa.place.addToken(sa.getToken());
          }
          return;
        }
        for (SubAction sa : after) {
          sa.makeStep();
        }
      }
    }
  }
}
