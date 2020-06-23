 //<>//
MainNet mainNet;
ActionController controller;
void setup() {
  size(1080, 700);
  frameRate(15);
  ModelReader modelReader = new ModelReader("run.xml");
  mainNet = modelReader.readMainNet();
  controller= modelReader.getActionController(mainNet);
  println("model has been read"); //<>//
}

float scale = 0.5;
float firstX = -1;
float firstY = -1;
float translateX = 200;
float translateY = 200;

/*
//temp
 color referenctokensColor = color(255, 204, 0);
 color tokensColor = color(255, 255, 255);
 
 MainNet mainNet = new MainNet();
 Token t1 = new Token(10, tokensColor);
 Token t2 = new Token(10, tokensColor);
 Token t3 = new Token(10, tokensColor);
 Token t4 = new Token(10, tokensColor);
 
 Token rt1 = new Token(10, referenctokensColor);
 Token rt2 = new Token(10, referenctokensColor);
 Token rt3 = new Token(10, referenctokensColor);
 
 Place p1 = new Place("lol", "kek", 250, 150, 50);
 Place p2 = new Place("lol", "kek", 800, 150, 50);
 Place p3 = new Place("lol", "kek", 250, 500, 50);
 Place p4 = new Place("lol", "kek", 800, 500, 50);
 
 Transition tr1 = new Transition(450, 150, 50);
 Transition tr2 = new Transition(450, 500, 50);
 Transition tr3 = new Transition(450, 300, 50);
 
 Arc p1Tr1 = new Arc(p1, tr1);
 Arc tr1P2 = new Arc(tr1, p2);
 Arc p3Tr2 = new Arc(p3, tr2);
 Arc tr2P4 = new Arc(tr2, p4);
 Arc p1Tr3 = new Arc(p1, tr3);
 Arc p3Tr3 = new Arc(p3, tr3);
 Arc tr3P2 = new Arc(tr3, p2);
 Arc tr3P4 = new Arc(tr3, p4);
 
 
 //Element ent1
 
 ElementNet en1 = new ElementNet(mainNet, 5, 2, 5);
 Token en1t1 = new Token(10, tokensColor);
 Token en1t2 = new Token(10, tokensColor);
 Token en1t3 = new Token(10, tokensColor);
 
 Place en1p1 = new Place("lol", "kek", 0, 0, 50);
 Place en1p2 = new Place("lol", "kek", 400, 0, 50);
 
 Transition en1tr1 = new Transition(200, 0, 50);
 
 Arc en1p1Tr1 = new Arc(en1p1, en1tr1);
 Arc en1tr1P2 = new Arc(en1tr1, en1p2);
 
 //Element ent2
 ElementNet en2 = new ElementNet(mainNet, 5, 2, 5);
 Token en2t1 = new Token(10, tokensColor);
 Token en2t2 = new Token(10, tokensColor);
 Token en2t3 = new Token(10, tokensColor);
 
 Place en2p1 = new Place("lol", "kek", 0, 0, 50);
 Place en2p2 = new Place("lol", "kek", 400, 0, 50);
 
 Transition en2tr1 = new Transition(200, 0, 50);
 
 Arc en2p1Tr1 = new Arc(en2p1, en2tr1);
 Arc en2tr1P2 = new Arc(en2tr1, en2p2);
 
 
 ActionController controller = new ActionController(mainNet);
 
 
 {
 mainNet.addPlace(p1);
 mainNet.addPlace(p2);
 mainNet.addPlace(p3);
 mainNet.addPlace(p4);
 
 mainNet.addTransition(tr1);
 mainNet.addTransition(tr2);
 mainNet.addTransition(tr3);
 
 mainNet.addToken(t1);
 mainNet.addToken(t2);
 mainNet.addToken(t3);
 mainNet.addToken(rt1);
 mainNet.addToken(rt2);
 mainNet.addToken(rt3);
 
 mainNet.addArc(p1Tr1);
 mainNet.addArc(tr1P2);
 mainNet.addArc(p3Tr2);
 mainNet.addArc(tr2P4);
 mainNet.addArc(p1Tr3);
 mainNet.addArc(p3Tr3);
 mainNet.addArc(tr3P2);
 mainNet.addArc(tr3P4);
 
 
 //InitialMarking
 p1.addToken(t1);
 p1.addToken(t2);
 p3.addToken(t3);
 p3.addToken(rt3);
 p1.addToken(rt1);
 p1.addToken(rt2);
 
 en1.addArc(en1p1Tr1);
 en1.addArc(en1tr1P2);
 en1.addReferenceToken(rt1);
 en1.addReferenceToken(rt2);
 en1.addReferenceToken(rt3);
 mainNet.addElementNet(en1);
 
 
 en2.addArc(en2p1Tr1);
 en2.addArc(en2tr1P2);
 en2.addReferenceToken(rt1);
 en2.addReferenceToken(rt2);
 en2.addReferenceToken(rt3);
 mainNet.addElementNet(en2);
 
 //Action1
 HashMap<Token, Place> action1Remove = new HashMap();
 action1Remove.put(t1, p1);
 action1Remove.put(rt1, p1);
 HashMap<Token, Place> action1Add = new HashMap();
 action1Add.put(rt1, p2);
 Action action1 = new Action(10, 30, 5, tr1, mainNet, action1Remove, action1Add, color(33, 150, 9));
 
 //Action2
 HashMap<Token, Place> action2Remove = new HashMap();
 action2Remove.put(t2, p1);
 action2Remove.put(t3, p3);
 HashMap<Token, Place> action2Add = new HashMap();
 action2Add.put(t4, p2);
 Action action2 = new Action(10, 30, 5, tr3, mainNet, action2Remove, action2Add, color(33, 150, 9));
 
 
 //Action3
 HashMap<Token, Place> action3Remove = new HashMap();
 action3Remove.put(rt2, p1);
 HashMap<Token, Place> action3Add = new HashMap();
 action3Add.put(rt2, p4);
 Action action3 = new Action(25, 45, 5, tr3, mainNet, action3Remove, action3Add, color(33, 150, 9));
 
 
 controller.addAction(action1);
 controller.addAction(action2);
 controller.addAction(action3);
 
 
 
 ////Element ent1
 
 en1.addPlace(en1p1);
 en1.addPlace(en1p2);
 en1.addTransition(en1tr1);
 
 en1.addToken(en1t1);
 en1p1.addToken(en1t1);
 
 ////Element ent2
 
 en2.addPlace(en2p1);
 en2.addPlace(en2p2);
 en2.addTransition(en2tr1);
 
 en2.addToken(en2t1);
 en2p1.addToken(en2t1);
 
 //ActionEN1
 HashMap<Token, Place> en1action1Remove = new HashMap();
 en1action1Remove.put(en1t1, en1p1);
 HashMap<Token, Place> en1action1Add = new HashMap();
 en1action1Add.put(en1t2, en1p2);
 en1action1Add.put(en1t3, en1p2);
 Action en1action1 = new Action(10, 30, 5, en1tr1, en1, en1action1Remove, en1action1Add, color(50, 50, 9));
 controller.addAction(en1action1);
 
 //ActionEN2
 HashMap<Token, Place> en2action1Remove = new HashMap();
 en2action1Remove.put(en2t1, en2p1);
 HashMap<Token, Place> en2action1Add = new HashMap();
 en2action1Add.put(en2t1, en2p2);
 Action en2action1 = new Action(20, 40, 5, en2tr1, en2, en2action1Remove, en2action1Add, color(50, 50, 9));
 controller.addAction(en2action1);
 
 
 controller.addElementNetTimeIntervals(100);
 }*/





int currentTime = 0;

void draw() {
  clear();
  background(204);
  translate(translateX, translateY);
  scale(scale);
  mainNet.draw();
  controller.moveActions(currentTime);
  currentTime++;
  if (currentTime == 560) {
    currentTime = 0;
    setup();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e >= 1 && scale >= 0) {
    scale /= 1.05;
  } else {
    scale *= 1.05;
  }
}
void mousePressed() {
  if (mouseButton == LEFT) {
    firstX = mouseX;
    firstY = mouseY;
  }
}

void mouseDragged() {
  if (firstX >= 0) {
    translateX = translateX + (mouseX - firstX);
    translateY = translateY + (mouseY - firstY);
    firstX = mouseX;
    firstY = mouseY;
  }
}
