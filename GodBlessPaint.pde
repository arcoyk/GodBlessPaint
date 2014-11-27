//created by Yui Arco Kita
//http://bluedog.herokuapp.com/godblesspaint

PShader shader;
PGraphics graphic;

void setup() {
  size(600, 600, P2D);
  graphic = createGraphics(600, 600, P2D);
  color c = color(255, 0, 0);
  graphic.set(width / 2, height /2, c);
  shader = loadShader("spread.glsl");
  background(255);
}

void draw() {
  graphic.beginDraw();
  graphic.noFill();
  //graphic.background(255);
  graphic.stroke(255, 0, 0);
  graphic.ellipse(mouseX, mouseY, 100, 100);
  graphic.filter(shader);
  graphic.endDraw();
  image(graphic, 0, 0, width, height);
}
