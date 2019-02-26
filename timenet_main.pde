/**
	MAIN .pde File
	
	Using:
	ProcessingJS v1.4.8
	BuzzJS v1.2.1
	jQuery??
	
	Made by Tom Haupt, 26.02.19
	DO NOT CHANGE
	
	TODO:
	
	- check bug selected true? after selected true?
	- reset color
	- move Nodes
	- delete Nodes when selected true
	- gamestate
**/


// Global variables
var rand_x_cord;
var rand_y_cord;

var windowXRes = 1280;
var windowYRes = 720;

// backgroundColor
var bg_color; // int

// sound vars
var bg_music = new buzz.sound("sounds/bg_music.mp3");
var selected = new buzz.sound("sounds/enemy_selected.mp3");
var selected_wrong = new buzz.sound("sounds/enemy_selected_wrong.mp3");
var selected_right = new buzz.sound("sounds/enemy_killed.mp3");

// colors:
color c1 = #ff6b6b; // red
color c2 = #a5ff8c; // green
color c3 = #70c5ff; // blue
color c4 = #ffe056; // yellow

// color Array
color[] colors  = {  
  c1, c2, c3, c4
};

// selected Array, init with two
var sArray = [];

// enemy ArrayList:
ArrayList<Enemy> enemys;
ArrayList<Enemy> enemyNodes;

// global function to check array
function checkArray() {
	//if(sArray[0].id == sArray[1].parentID || sArray[0].parentID == sArray[1].id || sArray[1].parentID == sArray[0].id || sArray[1].parentID == sArray[0].id) {
		if(sArray[0].parentID == sArray[1].id) { 
		// true
		console.log(true);
		console.log(sArray.length);

		// reset Array
		resetSelectArray();

		return true;
	} else {
		// false
		console.log(false);
		
		// log array
		console.log('sArray color:');
		console.log(sArray[0].farbe);
		console.log(sArray[1].farbe);
		
		// reset Array
		resetSelectArray();
		
		return false;
	}
}

// function to reset the select Array
function resetSelectArray() {
	sArray = [];
	
	console.log('reset array:');
	console.log(sArray.length);
}

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
	Enemy(int idP, color colorP, int punkteP, int hP, int wP, float sP, float cordXP, float cordYP) {
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
	
	// function to trigger the click
	void clicked() {
		
		var tempCol = this.farbe;
		var d = dist(mouseX, mouseY, this.cordX, this.cordY); // distance var
		
		if(d < this.width/2) {
			this.farbe = color(255, 255, 255);
			// play selected sound
			selected.play();
			sArray.push(this); // push selected Node to the selectedItemsArray
			
			// call check array func.
			if(checkArray() == true) {
				// play "scored" sound and stop selected sound
				selected.stop();
				selected_right.play();
				
				this.farbe = tempCol;
				this.setStroke(color(0,0,0));
				
				console.log('delete enemyNode');
				
			} else {
				selected_wrong.play();
				// TODO: reset color with temp var
				this.farbe = tempCol;
				
			}
		}
	}
	
	// return X Cord.
	float getXCord() {
		return cordX;
	}
	
	// return Y Cord.
	float getYCord() {
		return cordY;
	}
	
	// return ID of the Enemy
	int getID() {
		return id;
	}
	
	// return color of the Enemy
	color getColor() {
		return farbe;
	}
}

// Enemy Node Class
class EnemyNode {
	var parentID; // int
	int id;
	color farbe;
	int height;
	int width;
	float speed;
	float cordX;
	float cordY;
	
	// Constructor
	EnemyNode(int pIDP,int idP, color colorP, int hP, int wP, float sP, float cordXP, float cordYP) {
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
		fill(farbe); // fill ellipse with color
		noStroke();
		//background(100); // draw new "bg" to "delete" the old ellipse
		ellipse(cordX, cordY, width, height); // float X coord, float Y coord, width, height
	}
	
	// move ellipse along the path
	void moveToCore(float xPosP, float yPosP, float xPosCoreP, float yPosCoreP, float amountP) {
		float xPos = lerp(xPosP, xPosCoreP, amountP);
		float yPos = lerp(yPosP, yPosCoreP, amountP);
		
		// draw ellipse moving
		fill(farbe); // fill ellipse with random color
		noStroke();
		background(100); // draw new "bg" to "delete" the old ellipse
		ellipse(xPos, yPos, width, height);
	}
	
	// function to trigger the click
	void clicked() {
		
		var tempCol = this.farbe; // temp color
		var d = dist(mouseX, mouseY, this.cordX, this.cordY); // get distance between mouse and ellipse radius
		
		if(d < this.width/2) {
			this.farbe = color(255, 255, 255);
			// play selected sound
			selected.play();
			sArray.push(this); // push selected Node to the selectedItemsArray
			
			// call check array func.
			if(checkArray() == true) {
				
				selected.stop();
				selected_right.play();
				
				// reset color and delete selected Node
				this.farbe = tempCol;
				
				
			} else {
				selected.stop();
				selected_wrong.play();
				
				// TODO: reset color with temp var
				this.farbe = tempCol;
				
				
			}
		}
	}
	
	// return X Cord.
	float getXCord() {
		return cordX;
	}
	
	// return Y Cord.
	float getYCord() {
		return cordY;
	}
	
	// return parentID of the EnemyNode.
	int getParentID() {
		return parentID;
	}
	
	// set x cord.
	void setXCord(float xPara) {
		cordX = xPara;
	}
	
	// set y cord.
	void setYCord(float yPara) {
		cordY = yPara;
	}
}

// Setup the Processing Canvas
void setup() {
	
	// set the background color
	bg_color = 255;
	background(bg_color);
	smooth(8);
	
	// Setup "game" settings
	size(windowXRes, windowYRes);
	frameRate(60); // 60 fps

	// play bg music sound, dont play now
	//bg_music.play().loop();
	

	// create enemy array
	enemys = new ArrayList<Enemy>();
	enemyNodes = new ArrayList<EnemyNode>();
	

	// fill enemy array, iterate through enemys array and generate random x, y cords. int index
	for(index = 0; index <= 3; index++) { // replace with arrayList
		// generate random values:
		rand_x_cord = random(0, windowXRes-10); // get win X size minus 10 pixels (margin)
		rand_y_cord = random(0, windowYRes-10); // get win Y size minus 10 pixels (margin)
	
		enemys.add(new Enemy(index+1, colors[index], 2, 20, 20, 100, rand_x_cord, rand_y_cord));
		
		for(indNodes = 0; indNodes <= 9; indNodes++) {
			// set new x and y cords. for the nodes
			rand_x_cord = random(0, windowXRes-10); // get win X size minus 10 pixels (margin)
			rand_y_cord = random(0, windowYRes-10); // get win Y size minus 10 pixels (margin)
			
			enemyNodes.add(new EnemyNode(index+1, indNodes+1, colors[index], 10, 10, 100, rand_x_cord, rand_y_cord));
		}
	}
	
	// log all enemyNodes + x and y cords.
	/*for(k = 0; k <= enemyNodes.size()-1; k++) {
		console.log(enemyNodes.get(k));
		
		console.log("enemyNode X/Y:");
		console.log(enemyNodes.get(k).getXCord());
		console.log(enemyNodes.get(k).getYCord());
		
		console.log("enemy X/Y:");
		console.log(enemys.get(k).getXCord());
		console.log(enemys.get(k).getYCord());
		
	}*/
}

// Main draw loop
void draw(){ // NO CONSOLE.LOG()!!!!
	
	// Fill canvas white
	//bg_color = bg_color - 1;
	//background(bg_color); // 0 - 255 (black - white), replace with function
	background(100);
  
	// add Text
	//text("TimeNet", width/2, height/2);
	
	// iterate enemy array and "draw" them
	for (int i = 0; i <= enemys.size()-1; i++) {		
		Enemy enemy = enemys.get(i);
		enemy.display();
	}
	
	// iterate enemyNode array and "draw" them
	for (int j = 0; j <= enemyNodes.size()-1; j++) {		
		EnemyNode eNode = enemyNodes.get(j);
		Enemy enemy = enemys.get(0);

		eNode.display();
		
		
		// draw lines between the "core" and "nodes"
		if(enemys.get(0).getID() == enemyNodes.get(j).getParentID()) { // draw RED
			stroke(enemys.get(0).getColor());
			line(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(0).getXCord(), enemys.get(0).getYCord()); // x1, y1, x2, y2
			//eNode.moveToCore(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(0).getXCord(), enemys.get(0).getYCord(), 0.5);
		} else if(enemys.get(1).getID() == enemyNodes.get(j).getParentID()) { // draw GREEN
			stroke(enemys.get(1).getColor());
			line(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(1).getXCord(), enemys.get(1).getYCord()); // x1, y1, x2, y2
		} else if(enemys.get(2).getID() == enemyNodes.get(j).getParentID()) { // draw BLUE
			stroke(enemys.get(2).getColor());
			line(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(2).getXCord(), enemys.get(2).getYCord()); // x1, y1, x2, y2
		} else if(enemys.get(3).getID() == enemyNodes.get(j).getParentID()) { // draw YELLOW
			stroke(enemys.get(3).getColor());
			line(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(3).getXCord(), enemys.get(3).getYCord()); // x1, y1, x2, y2
		}
	}
}

// if mouse is pressed (not released)
void mousePressed() {
	// check if ellipse is clicked?
	
	// iterate nodes array
	for (int j = 0; j <= enemyNodes.size()-1; j++) {		
		EnemyNode eNode = enemyNodes.get(j);
		//Enemy enemy = enemys.get(0);
		
		eNode.clicked();
	}
	
	// iterate enemy array
	for (int i = 0; i <= enemys.size()-1; i++) {		
		Enemy enemy = enemys.get(i);
		enemy.clicked();
	}
}