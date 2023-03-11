let ahead;
let buffet = [];
let over = false;


function setup() {
  createCanvas(windowWidth, windowHeight);
  ahead = new Head();
}


function draw() {
  background(255, 255, 0);
  fill(0, 255, 255);
  textSize(20);
  textAlign(LEFT, TOP);
  text(ahead.score, 0, 0);
  if(over) return;
  ahead.move();
  for(let i = 0; i < buffet.length; i++) {
    let someFood = buffet[i];
    let rendered = renderFood(someFood);
    if(!rendered) {
      buffet.splice(i, 1); // remove(i) is basically this...
    }
  }
  renderHead(ahead);
}

function deathScreen() {
  over = true;
}


class Head {
  
  
  constructor() {
		this.body = [];
    this.x = width/2;
    this.y = height/2;
    this.direction = 0;
    this.speed = 3;
		this.snakeLength = 100;
		this.score = 0;
  }
  
  // ACTIONS
  render() {
    renderBody(this.body);
    fill(255);
    stroke(200);
    strokeWeight(3);
    ellipse(this.x, this.y, 20, 20);
  }
  
  move() {
    this.body.push(new Tail(this));
    if (this.body.length > this.snakeLength) {
      this.body.splice(0, 1);
    }
    if(parseInt(random(10+1)) == 1 && buffet.length < 100) {
      buffet.push(new Food(this));
    }
    if(dist(mouseX, mouseY, this.x, this.y) < this.speed) { this.x = mouseX; this.y = mouseY; return; }
    this.direction = atan2(mouseX-this.x, mouseY-this.y);
    this.x += sin(this.direction) * this.speed;
    this.y += cos(this.direction) * this.speed;
    this.collide();
  }
  
  collide() {
    if(this.x + (20 / 2) > width || this.x - (20 / 2) < 0 || this.y + (20 / 2) > height || this.y - (20 / 2) < 0) {
      deathScreen();
    }
  }

}

class Tail {
  
  constructor(_parent) {
    this.x = _parent.x;
    this.y = _parent.y;
  }
  
  render() {
    fill(100);
    noStroke();
    // If we add stroke it won't look good and look mega ugly so nostroke.
    ellipse(this.x, this.y, 10, 10);
  }
}

class Food { 
  
  constructor(_parent) {
		this.speed = 2;
		this.size=random(5, 9);
		this.floatVar = false;
		this.ate = false;
    this.c = randColor();
    this.x = parseInt(random(0,width+1));
    this.y = parseInt(random(0,height+1));
    this.parent = _parent;
  }
  
  render() {
    
    //stroke(100);
    //strokeWeight(5);
    noStroke();
    ellipseMode(CENTER);
    if(this.floatVar) {
      if(dist(this.parent.x, this.parent.y, this.x, this.y) < this.speed) { this.x = this.parent.x; this.y = this.parent.y; this.ate = true; this.parent.score++; return; }
      let direction = atan2(this.parent.x-this.x, this.parent.y-this.y);
      this.x += sin(direction) * this.speed;
      this.y += cos(direction) * this.speed;
      
      this.speed *= 1.2;
      this.size-=this.speed/4;
    }
		//console.log('rendered');
    for(let i = 0; i < 255/20; i++) { fill(red(this.c), green(this.c), blue(this.c), 255-(i*20)); ellipse(this.x, this.y, this.size+(i), this.size+(i)); }
    this.collide();
  }
  
  collide() {
    if(dist(this.parent.x, this.parent.y, this.x, this.y) < 100) {
      this.floatVar = true;
    }
  }
  
}
