public class ReferenceToken extends Token {
  private final ElementNet elementNet;
  private final MainNet mainNet;
  public ReferenceToken(float diameter, MainNet mainNet, ElementNet elementNet) {
    super(diameter);
    this.mainNet = mainNet;
    this.elementNet = elementNet;
  }

  public void drawElementNet(float mainNetUp, float mainNetDown, float middleMainNetY, ArrayList<ReferenceToken> referenceTokens, int tokenNumber) {
    elementNet.draw(this, mainNetUp, mainNetDown, middleMainNetY, referenceTokens, tokenNumber);
  }

  public void updateHalf() {
    elementNet.isAtUpperHalf = mainNet.middleY > getY();
  }
}
