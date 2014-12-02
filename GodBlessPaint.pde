//created by Yui Arco Kita
//http://bluedog.herokuapp.com/godblesspaint

PShader shader;
PGraphics graphic;
color c;

void setup() {
  size(600, 600, P2D);
  graphic = createGraphics(600, 600, P2D);
  color c = color(255, 0, 0);
  graphic.set(width / 2, height /2, c);
  shader = loadShader("spread.glsl");
  graphic.beginDraw();
  graphic.background(255);
  plot_random();
  graphic.endDraw();
}
float offset = 0.03;
void draw() {
  shader.set("timer", random(255));
  shader.set("r1", random(-offset,offset));
  shader.set("r2", random(-offset,offset));
  shader.set("r3", random(-offset,offset));
  graphic.beginDraw();
  graphic.noFill();
  graphic.filter(shader);
  graphic.endDraw();
  image(graphic, 0, 0, width, height);
}

void mouseDragged() {
  graphic.beginDraw();
  graphic.stroke(c);
  graphic.ellipse(mouseX, mouseY, 10, 10);
  graphic.endDraw();
}

void plot_random() {
  for (int i = 0; i < 10; i++) {
    c = color((int)random(255),(int)random(255),(int)random(255));
    graphic.beginDraw();
    graphic.stroke(c);
    graphic.ellipse(random(width), random(height), 10, 10);
    graphic.endDraw();
  }
}

void mousePressed() {
  c = color((int)random(255),(int)random(255),(int)random(255));
}
