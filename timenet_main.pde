// Global variables
int rand_x_cord;
int rand_y_cord;

int windowXRes = 1280;
int windowYRes = 720;

// colors:
color c1 = #ff6b6b; // red
color c2 = #a5ff8c; // green
color c3 = #70c5ff; // blue
color c4 = #ffe056; // yellow, orange

// color Array
color[] colors  = {  
  c1, c2, c3, c4
};

// enemy ArrayList:
ArrayList<Enemy> enemys;
ArrayList<Enemy> enemyNodes;

// Enemy Class
class Enemy {
	int id;
	color farbe;
	int punkte;
	int height;
	int width;
	float speed;
	float cordX;
	float cordY;
	
	// Constructor
	Enemy(int idP, color colorP, int punkteP, int hP, int wP, float sP, int cordXP, int cordYP) {
		this.id = idP;
		this.farbe = colorP;
		this.punkte = punkteP;
		this.height = hP;
		this.width = wP;
		this.speed = sP;
		this.cordX = cordXP;
		this.cordY = cordYP;
	}
	
	void display() {
		// create ellipse
		fill(farbe); // fill ellipse with random color
		noStroke();
		ellipse(cordX, cordY, width, height); // float X coord, float Y coord, width, height
	}
}

// Enemy Node Class
class EnemyNode {
	int parentID;
	int id;
	color farbe;
	int height;
	int width;
	float speed;
	float cordX;
	float cordY;
	
	// Constructor
	EnemyNode(int pIDP,int idP, color colorP, int hP, int wP, float sP, int cordXP, int cordYP) {
		this.parentID = pIDP;
		this.id = idP;
		this.farbe = colorP;
		this.height = hP;
		this.width = wP;
		this.speed = sP;
		this.cordX = cordXP;
		this.cordY = cordYP;
	}
	
	void display() {
		// create ellipse
		fill(farbe); // fill ellipse with random color
		noStroke();
		ellipse(cordX, cordY, width, height); // float X coord, float Y coord, width, height
	}
}

// Setup the Processing Canvas
void setup() {
	// Setup "game" settings
	//size(displayWidth, displayHeight)
	//fullScreen(); // sets the "game" to the full resolution of the browser window
	size(windowXRes, windowYRes);
	//strokeWeight(2); 
	frameRate(60); // 60 fps

	// create enemy array
	enemys = new ArrayList<Enemy>();
	enemyNodes = new ArrayList<EnemyNode>();
	

	// fill enemy array, iterate through enemys array and generate random x, y cords.
	for(int index = 0; index <= 3; index++) { // replace with arrayList
		// generate random values:
		rand_x_cord = random(0, windowXRes);
		rand_y_cord = random(0, windowYRes);
	
		enemys.add(new Enemy(index+1, colors[index], 2, 20, 20, 100, rand_x_cord, rand_y_cord));
		
		for(int indNodes = 0; indNodes <= 9; indNodes++) {
			// set new x and y cords. for the nodes
			rand_x_cord = random(0, windowXRes);
			rand_y_cord = random(0, windowYRes);
			
			enemyNodes.add(new EnemyNode(index+1, indNodes+1, colors[index], 10, 10, 100, rand_x_cord, rand_y_cord));
		}
	}
	
	// log all enemyNodes
	for(int k = 0; k <= enemyNodes.size()-1; k++) {
		console.log(enemyNodes.get(k));
	}
		
}

// Main draw loop
void draw(){ // NO CONSOLE.LOG()!!!!
    
	// Fill canvas white
	background(100); // 0 - 255 (black - white), replace with function
  
	// add Text
	//text("TimeNet", width/2, height/2);
	
	// iterate enemy array and "draw" them
	for (int i = 0; i <= enemys.size()-1; i++) {		
		Enemy enemy = enemys.get(i);
		enemy.display();
		//enemy.update();
	}
	
	// iterate enemyNode array and "draw" them
	for (int i = 0; i <= enemyNodes.size()-1; i++) {		
		EnemyNode eNode = enemyNodes.get(i);
		eNode.display();
		//enemy.update();
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
