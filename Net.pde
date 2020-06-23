public class Net {
  protected final ArrayList<Place> places = new ArrayList();
  protected final ArrayList<Transition> transitions = new ArrayList();
  protected final ArrayList<Token> allTokens = new ArrayList();
  protected final ArrayList<Token> activeTokens = new ArrayList();
  protected final ArrayList<Arc> arcs = new ArrayList();

  protected float left = Integer.MAX_VALUE;
  protected float up = Integer.MAX_VALUE;
  protected float down  = Integer.MIN_VALUE;
  protected float right  = Integer.MIN_VALUE;
  protected float middleX, middleY;  
  protected float indent = 5;
  protected String id;

  public void draw() {
    for (Arc arc : arcs) {
      arc.draw();
    }
    for (Place place : places) {
      place.draw();
    }
    for (Transition transition : transitions) {
      transition.draw();
    }
    for (Token at : activeTokens) {
      at.draw();
    }
  }

  public void addPlace(Place place) {
    places.add(place);
    if ((place.x + place.radius) > (right - indent)) {
      right = place.x + place.radius + indent;
    }
    if ((place.x - place.radius) < (left + indent)) {
      left = place.x - place.radius - indent;
    }
    if ((place.y + place.radius) > (down - indent)) {
      down = place.y + place.radius + indent;
    }
    if ((place.y - place.radius) < (up + indent)) {
      up = place.y - place.radius - indent;
    }
    middleX = left + (right - left) / 2;
    middleY = up + (down - up) / 2;
  }

  public void addTransition(Transition transition) {
    transitions.add(transition);
    if ((transition.x + transition.diameter) > (right - indent)) {
      right = transition.x + transition.diameter + indent;
    }
    if ((transition.x) < (left + indent)) {
      left = transition.x - indent;
    }
    if ((transition.y + transition.diameter) > (down - indent)) {
      down = transition.y + transition.diameter + indent;
    }
    if ((transition.y) < (up + indent)) {
      up = transition.y - indent;
    }
    middleX = left + (right - left) / 2;
    middleY = up + (down - up) / 2;
  }

  public boolean  hasActiveToken(Token token) {
    return activeTokens.contains(token);
  }

  public void addAllToken(Token token) {
    allTokens.add(token);
  }

  public void addActiveToken(Token token) {
    activeTokens.add(token);
  }

  public void removeActiveToken(Token token) {
    activeTokens.remove(token);
  }

  public void addArc(Arc arc) {
    arcs.add(arc);
  }

  public Token getTokenById(String tokenId) {
    for (Token t : allTokens) {
      if (t.id.equals(tokenId)) {
        return t;
      }
    }
    return null;
  }


  public Place getPlaceById(String placeId) {
    for (Place p : places) {
      if (p.id.equals(placeId)) {
        return p;
      }
    }
    return null;
  }

  public Transition getTransitionById(String transitionId) {
    for (Transition t : transitions) {
      if (t.id.equals(transitionId)) {
        return t;
      }
    }
    return null;
  }
}
