public class ActionController {

  private final HashMap<Integer, ArrayList<Action>> actions = new HashMap();
  private final HashMap<ElementNet, ArrayList<Action>> actionsByElementNet = new HashMap();
  private final ArrayList<Action> activeActions = new ArrayList();
  private final MainNet mainNet;
  public int endTime = 0;

  public ActionController(MainNet mainNet) {
    this.mainNet = mainNet;
  }

  public void addAction(Action a) {
    //addAction
    Action ac = a;
    ArrayList<Action> list = actions.get(a.startTime);
    if (list == null) {
      list = new ArrayList();
      actions.put(a.startTime, list);
    }
    list.add(ac);

    //addActionTo elementNet
    if (a.net instanceof ElementNet) {
      ElementNet en = (ElementNet) a.net;
      ArrayList<Action> actionsForNet = actionsByElementNet.get(en);
      if (actionsForNet == null) {
        actionsForNet = new ArrayList();
        actionsByElementNet.put(en, actionsForNet);
      }
      actionsByElementNet.get(en).add(a);
    }
  }

  public void addElementNetTimeIntervals() {
    for (ArrayList<Action> aa : actions.values()) {
      for  (Action a : aa) {
        if (a.endTime > endTime) {
          endTime = a.endTime;
        }
      }
    }
    for (ElementNet en : mainNet.getElementNets()) {
      ArrayList<Action> actionsPerNet = actionsByElementNet.get(en);
      if (actionsPerNet == null) {
        return;
      }
      for (int t = 0; t < endTime; t += en.distanceBetweenTimeIntervals) {
        int summWeight = 0;
        int endTimeInterval = t + en.timeInterval;
        for (Action a : actionsPerNet) {
          if (!(a.endTime < t || a.startTime > endTimeInterval) ) {
            summWeight += a.weight;
          }
        }
        if (summWeight >= en.treshold) {
          en.addDisplayedTimeInterval(t, endTimeInterval);
        }
      }
    }
  }


  public void moveActions(int currentTime) {
    mainNet.updateElementNetIsDisplayed(currentTime);
    ArrayList<Action> actionToStart = actions.get(currentTime);
    if (actionToStart != null) {
      for (Action ac : actionToStart) {
        ac.startAction();
      }
      activeActions.addAll(actionToStart);
    }

    ArrayList<Action> stoppedActions = new ArrayList();
    for (Action action : activeActions) {
      if (action.running == true) {
        action.tick();
      } else {
        stoppedActions.add(action);
      }
    }
    activeActions.removeAll(stoppedActions);
  }
}
