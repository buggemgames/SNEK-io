Head ahead;
ArrayList<Food> buffet = new ArrayList<Food>();
boolean over = false;


void setup() {
  fullScreen(P2D);
  ahead = new Head();
}


void draw() {
  background(255, 255, 0);
  fill(0, 255, 255);
  textSize(20);
  textAlign(LEFT, TOP);
  text(ahead.score, 0, 0);
  if(over) return;
  ahead.move();
  for(int i = 0; i < buffet.size(); i++) {
    Food someFood = buffet.get(i);
    boolean rendered = renderFood(someFood);
    if(!rendered) {
      buffet.remove(i);
    }
  }
  renderHead(ahead);
}

void deathScreen() {
  over = true;
}


class Head {
  
  float x, y, speed, direction, snakeLength = 100, score = 0;
  ArrayList<Tail> body = new ArrayList();
  
  
  Head() {
    x = width/2;
    y = height/2;
    direction = 0;
    speed = 3;
  }
  
  // ACTIONS
  void render() {
    renderBody(body);
    fill(255);
    stroke(200);
    strokeWeight(3);
    ellipse(x, y, 20, 20);
  }
  
  void move() {
    body.add(new Tail(this));
    if (body.size() > snakeLength) {
      body.remove(0);
    }
    if((int) random(10+1) == 1 && buffet.size() < 100) {
      buffet.add(new Food(this));
    }
    if(dist(mouseX, mouseY, x, y) < speed) { x = mouseX; y = mouseY; return; }
    direction = atan2(mouseX-x, mouseY-y);
    x += sin((direction)) * speed;
    y += cos((direction)) * speed;
    collide();
  }
  
  void collide() {
    if(x + (20 / 2) > width || x - (20 / 2) < 0 || y + (20 / 2) > height || y - (20 / 2) < 0) {
      deathScreen();
    }
  }

}

class Tail {
  float x, y;
  
  Tail(Head parent) {
    x = parent.x;
    y = parent.y;
  }
  
  void render() {
    fill(100);
    noStroke();
    // If we add stroke it won't look good and look mega ugly so nostroke.
    ellipse(x, y, 10, 10);
  }
}

class Food { 
  float x, y, speed = 2, size = 5;
  color c;
  Head parent;
  boolean floatVar = false, ate = false;
  
  Food(Head _parent) {
    c = randColor();
    x = (int) random(0,width+1);
    y = (int) random(0,height+1);
    parent = _parent;
  }
  
  void render() {
    
    //stroke(100);
    //strokeWeight(5);
    noStroke();
    ellipseMode(CENTER);
    if(floatVar) {
      if(dist(parent.x, parent.y, x, y) < speed) { x = parent.x; y = parent.y; ate = true; parent.score++; return; }
      float direction = atan2(parent.x-x, parent.y-y);
      x += sin((direction)) * speed;
      y += cos((direction)) * speed;
      
      speed *= 1.2;
      size-=speed/4;
    }
    for(int i = 0; i < 255/20; i++) { fill(red(c), green(c), blue(c), 255-(i*20)); ellipse(x, y, size+(i), size+(i)); }
    collide();
  }
  
  void collide() {
    if(dist(parent.x, parent.y, x, y) < 100) {
      floatVar = true;
    }
  }
  
}
