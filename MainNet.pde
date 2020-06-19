public class MainNet {
  private final ArrayList<Place> places = new ArrayList();
  private final ArrayList<Transition> transitions = new ArrayList();
  private final ArrayList<Token> tokens = new ArrayList();
  private final ArrayList<ReferenceToken> referenceTokens = new ArrayList();
  private float left = Integer.MAX_VALUE;
  private float right;
  private float down;
  private float up = Integer.MAX_VALUE;
  private float middleX = 0;
  private float middleY = 0;

  public void draw() {
    for (Place place : places) {
      place.draw();
    }
    for (Transition transition : transitions) {
      transition.draw();
    }
    for (int i = 0; i < referenceTokens.size(); i++) {
      referenceTokens.get(i).drawElementNet(up, down, middleY, referenceTokens, i);
    }
    for (ReferenceToken t : referenceTokens) {
      t.elementNet.shiftY = 0;
    }
    for (Token t : tokens) {
      t.draw();
    }
  }

  public void addPlace(Place place) {
    places.add(place);
    if ((place.x + place.radius) > right) {
      right = place.x + place.radius;
    }
    if ((place.x - place.radius) < left) {
      left = place.x - place.radius;
    }
    if ((place.y + place.radius) > down) {
      down = place.y + place.radius;
    }
    if ((place.y - place.radius) < up) {
      up = place.y - place.radius;
    }
    middleX = (right - left) / 2;
    middleY = up + (down - up) / 2;
  }

  public void addTransition(Transition transition) {
    transitions.add(transition);
    if ((transition.x + transition.diameter) > right) {
      right = transition.x + transition.diameter;
    }
    if ((transition.x) < left ) {
      left = transition.x;
    }
    if ((transition.y + transition.diameter) > down) {
      down = transition.y + transition.diameter;
    }
    if ((transition.y) < up) {
      up = transition.y;
    }
    middleY =  up + (down - up) / 2;
    middleX = left + (right - left) / 2;
  }

  public void addReferenceToken(ReferenceToken token) {
    referenceTokens.add(token);
    tokens.add(token);
  }

  public void addToken(Token token) {
    tokens.add(token);
  }
}
