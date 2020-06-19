public class ActionController {

  private final HashMap<Integer, ArrayList<Action>> actions = new HashMap();
  private final ArrayList<Action> activeActions = new ArrayList();

  public void addAction(Place fromPlace, Place toPlace, Transition viaTransition, Token token, int startTime, int endTime) {
    Action ac = new Action(fromPlace, toPlace, viaTransition, token, startTime, endTime);
    ArrayList<Action> list = actions.get(startTime);
    if (list == null) {
      list = new ArrayList();
      actions.put(startTime, list);
    }
    list.add(ac);
  }
 

  public void moveActions(int currentTime) {
    ArrayList<Action> stoppedActions = new ArrayList();
    for (Action action : activeActions) {
      action.nextStep();
      if (action.running == false) {
        stoppedActions.add(action);
      }
    }
    activeActions.removeAll(stoppedActions);
    ArrayList<Action> currentActions = actions.get(currentTime);
    if (currentActions != null) {
      for (Action ac : currentActions) {
        ac.startAction();
      }
      activeActions.addAll(currentActions);
    }
  }

  public void stopAction(Action action) {
    activeActions.remove(action);
  }
}
