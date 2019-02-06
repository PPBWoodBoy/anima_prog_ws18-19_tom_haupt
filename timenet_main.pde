// Global variables
float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 4;

int rand_x_cord;
int rand_y_cord;

// colors:
color c1 = #ff6b6b; // red
color c2 = #a5ff8c; // green
color c3 = #70c5ff; // blue
color c4 = #ffe056; // yellow, orange

// enemy Array:
Enemy[] enemys;



// Enemy Class
class Enemy {
	String name;
	color farbe;
	int punkte;
	int height;
	int width;
	float speed;
	int cordX;
	int cordY;
	
	// Constructor
	Enemy(String nameP, color colorP, int punkteP, int hP, int wP, float sP, int cordXP, int cordYP) {
		name = nameP;
		farbe = colorP;
		punkte = punkteP;
		height = hP;
		width = wP;
		speed = sP;
		cordX = cordXP;
		cordY = cordYP;
	}
	
	void display() {
		// create ellipse
		fill(c2); // fill ellipse with random color
		noStroke();
		ellipse(200, 200, 10, 10); // float X coord, float Y coord, width, height
	}
}

// Setup the Processing Canvas
void setup() {
	// Setup "game" settings
	size(1920, 1080);
	//fullScreen(); // sets the "game" to the full resolution of the browser window
	strokeWeight(2);
	frameRate(60); // 60 fps
	
	X = width / 2;
	Y = height / 2;
	nX = X;
	nY = Y;

	// create enemy array, MAX 4 
	enemys = new Enemy[4];

	// fill enemy array, iterate through enemys array and generate random x, y cords.
	for(int index = 0; index <= enemys.length(); index++) {
		rand_x_cord = random(0, 1920);
		rand_y_cord = random(0, 1080);
		enemys[index++] = new Enemy("enemy_01", c3, 10, 10, 20, rand_x_cord, rand_y_cord); // name, color, height, width, speed, cordX, cordY
	}
}

// Main draw loop
void draw(){
  
	radius = radius + sin( frameCount / 4 );
  
	// Track circle to new destination
	X+=(nX-X)/delay;
	Y+=(nY-Y)/delay;
  
	// Fill canvas white
	background(255); // 0 - 255 (white)
  
	// Set fill-color to blue
	fill(c4);
  
	// Set stroke-color white
	stroke(0); 
  
	// Draw circle
	ellipse( X, Y, radius, radius );    

	// add Text
	text("TimeNet", width/2, height/2);
	
	// iterate enemy array and "draw" them
	for (Enemy enemy : enemys) {
		//enemy.update();
		enemy.display();
	}
	
}


// Set circle's next destination
void mouseMoved(){
  nX = mouseX;
  nY = mouseY;  
}


// starts the game timer at 0:00 in seconds!
void startTime() {
	
}
