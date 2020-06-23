public class Place extends BaseShape { //<>// //<>//
  public final float diameter, radius;
  private final ArrayList<Token> tokens = new ArrayList();
  private final HashMap<Transition, Arc > arcToTransition = new HashMap();
  private final HashMap<Transition, Arc> arcFromTransition = new HashMap();

  public Place(String id, String name, float x, float y, float placeDiameter) {
    super(id, name, x, y);
    this.diameter = placeDiameter;
    this.radius = placeDiameter/2;
  }


  public void draw() {
    circle(this.x, this.y, diameter);
  }

  public void addArc(Transition tr, Arc arc) {
    if (arc.fromPlaceToTransition) {
      arcToTransition.put(tr, arc);
    } else {
      arcFromTransition.put(tr, arc);
    }
  }

  public void addToken(Token token) {
    tokens.add(token);
    updateTokenPositions();
  }

  public void removeToken(Token token) {
    tokens.remove(token);
    updateTokenPositions();
  }

  public Arc getArc(Transition tr, boolean fromPlaceToTransition) {
    if (fromPlaceToTransition) {
      return arcToTransition.get(tr);
    } else {
      return arcFromTransition.get(tr);
    }
  }

  private void updateTokenPositions() {
    if (tokens.size() == 1) {
      tokens.get(0).x = x;
      tokens.get(0).y = y;
    } else if (tokens.size() == 2) {
      tokens.get(0).x = x - radius/4;
      tokens.get(0).y = y;
      tokens.get(1).x = x + radius/4;
      tokens.get(1).y = y;
    } else if (tokens.size() == 3) {
      tokens.get(0).x = x - radius/4;
      tokens.get(0).y = y + radius/4;
      tokens.get(1).x = x + radius/4;
      tokens.get(1).y = y + radius/4;
      tokens.get(2).x = x;
      tokens.get(2).y = y - radius/4;
    } else if (tokens.size() == 4) {
      tokens.get(0).x = x - radius/4;
      tokens.get(0).y = y + radius/4;
      tokens.get(1).x = x + radius/4;
      tokens.get(1).y = y + radius/4;
      tokens.get(2).x = x + radius/4;
      tokens.get(2).y = y - radius/4;
      tokens.get(3).x = x - radius/4;
      tokens.get(3).y = y - radius/4;
    } else if (tokens.size() == 5) {
      tokens.get(0).x = x - radius/3;
      tokens.get(0).y = y + radius/3;
      tokens.get(1).x = x + radius/3;
      tokens.get(1).y = y + radius/3;
      tokens.get(2).x = x + radius/3;
      tokens.get(2).y = y - radius/3;
      tokens.get(3).x = x - radius/3;
      tokens.get(3).y = y - radius/3;
      tokens.get(4).x = x;
      tokens.get(4).y = y;
    } else if (tokens.size() == 6) {
      tokens.get(0).x = x - radius/3;
      tokens.get(0).y = y + radius/3;
      tokens.get(1).x = x;
      tokens.get(1).y = y + radius/3;
      tokens.get(2).x = x + radius/3;
      tokens.get(2).y = y + radius/3;
      tokens.get(3).x = x - radius/3;
      tokens.get(3).y = y - radius/3;
      tokens.get(4).x = x;
      tokens.get(4).y = y - radius/3;
      tokens.get(5).x = x + radius/3;
      tokens.get(5).y = y - radius/3;
    }
  }
}
