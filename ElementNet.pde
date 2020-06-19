public class ElementNet {
  private final ArrayList<Place> places = new ArrayList();
  private final ArrayList<Transition> transitions = new ArrayList();
  private final ArrayList<Token> tokens = new ArrayList();
  private boolean displayed = true;
  private boolean isAtUpperHalf = false;

  private float left = Integer.MAX_VALUE;
  private float right;
  private float down;
  private float up = Integer.MAX_VALUE;

  private float borderWidth;
  private float borderHalfWidth;
  private float borderHeight;

  private float middleX = 0;
  private float middleY = 0;
  private float shiftY = 0;

  private final float indent = 5;
  public int netYShift;

  public ElementNet () {
  }

  public void draw(ReferenceToken rt, float mainNetUp, float mainNetDown, float middleMainNetY, ArrayList<ReferenceToken> referenceTokens, int tokenNumber) {
    if (displayed) {
      float shiftX = rt.getX() - middleX;
      float lineY = 0;
      shiftY = getAdditionalShiftY(referenceTokens, tokenNumber) + borderHeight + 10;
      float tranShift = 0;
      if (isAtUpperHalf) {
        tranShift = mainNetUp - shiftY;
        lineY = down + tranShift;
      } else {
        tranShift = mainNetDown + shiftY;
        lineY = up + tranShift;
      }

      translate(shiftX, tranShift);
      drawBorders();
      for (Place place : places) {
        place.draw();
      }
      for (Transition transition : transitions) {
        transition.draw();
      }
      for (Token t : tokens) {
        t.draw();
      }
      translate(-shiftX, -tranShift);
      line(rt.getX(), rt.getY(), middleX + shiftX, lineY);
    }
  }

  public void addPlace(Place place) {
    places.add(place);
    if ((place.x + place.radius) > (right - indent)) {
      right = place.x + place.radius + indent;
      borderWidth = right - left;
    }
    if ((place.x - place.radius) < (left + indent)) {
      left = place.x - place.radius - indent;
      borderWidth = right - left;
    }
    if ((place.y + place.radius) > (down - indent)) {
      down = place.y + place.radius + indent;
      borderHeight = down - up;
    }
    if ((place.y - place.radius) < (up + indent)) {
      up = place.y - place.radius - indent;
      borderHeight = down - up;
    }
    middleX = left + (right - left) / 2;
    middleY = up + (down - up) / 2;
    borderHalfWidth = borderWidth/2;
  }

  public void addTransition(Transition transition) {
    transitions.add(transition);
    if ((transition.x + transition.diameter) > (right - indent)) {
      right = transition.x + transition.diameter + indent;
      borderWidth = right - left;
    }
    if ((transition.x) < (left + indent)) {
      left = transition.x - indent;
      borderWidth = right - left;
    }
    if ((transition.y + transition.diameter) > (down - indent)) {
      down = transition.y + transition.diameter + indent;
      borderHeight = down - up;
    }
    if ((transition.y) < (up + indent)) {
      up = transition.y - indent;
      borderHeight = down - up;
    }
    middleX = left + (right - left) / 2;
    middleY = up + (down - up) / 2;
    borderHalfWidth = borderWidth/2;
  }

  private void drawBorders() {
    rect(left, up, borderWidth, borderHeight);
  }

  public void addToken(Token token) {
    tokens.add(token);
  }

  private float getAdditionalShiftY(ArrayList<ReferenceToken> referenceTokens, int tokenNumber) {
    float additionalShiftY = 0;
    for (int i = 0; i < tokenNumber; i++) {
      ReferenceToken checkToken = referenceTokens.get(i);
      if (checkToken.elementNet.displayed && checkToken.elementNet.isAtUpperHalf == isAtUpperHalf) {
        float checkRight = checkToken.getX() + checkToken.elementNet.borderHalfWidth;
        float checkLeft = checkToken.getX() - checkToken.elementNet.borderHalfWidth;
        float thisRight = referenceTokens.get(i).getX() + borderHalfWidth;
        float thisLeft = referenceTokens.get(i).getX() - borderHalfWidth;
        if (!(checkRight < thisLeft || checkLeft > thisRight)) {
          if (additionalShiftY < checkToken.elementNet.shiftY){
            additionalShiftY = checkToken.elementNet.shiftY;
          }
        }
      }
    }
    return additionalShiftY;
  }
}
