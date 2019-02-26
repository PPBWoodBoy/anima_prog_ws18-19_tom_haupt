/**
	MAIN .pde File
	
	Using:
	
	ProcessingJS v1.4.8
	BuzzJS v1.2.1
	jQuery v3.3.1
	
	Made by Tom Haupt, 27.02.19
	DO NOT CHANGE
**/

// Global variables
var rand_x_cord;
var rand_y_cord;

// HUD elements
var time;
var pScore;

var windowXRes = $('#timeNet_canvas').width(); // was 1280
var windowYRes = $('#timeNet_canvas').height(); // was 720

// backgroundColor
var bg_color;

// sound vars
var bg_music = new buzz.sound("sounds/bg_music.mp3");
var selected = new buzz.sound("sounds/enemy_selected.mp3");
var selected_wrong = new buzz.sound("sounds/enemy_selected_wrong.mp3");
var selected_right = new buzz.sound("sounds/enemy_killed.mp3");
var enemy_scored = new buzz.sound("sounds/enemy_scored.mp3");
var game_won = new buzz.sound("sounds/game_end_won.mp3");
var game_lost = new buzz.sound("sounds/game_end_lost.mp3");

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
		if(sArray[0].parentID == sArray[1].id && sArray[1].name == "Enemy") { 
		// true
		return true;
	} else {
		// false
		return false;
	}
}

// function to reset the select Array
function resetSelectArray() {
	sArray = [];
}

// Enemy Class
class Enemy {
	int id;
	color farbe;
	int punkte;
	int height;
	int width;
	float cordX;
	float cordY;
	var dx;
	var dy;
	var name;
	
	// Constructor
	Enemy(int idP, color colorP, int punkteP, int hP, int wP, float cordXP, float cordYP, var nP) {
		this.id = idP;
		this.farbe = colorP;
		this.punkte = punkteP;
		this.height = hP;
		this.width = wP;
		this.cordX = cordXP;
		this.cordY = cordYP;
		this.dx = -0.1;
		this.dy = 0;
		this.name = nP;
	}
	
	// initial draw
	void display() {
		// create ellipse
		fill(farbe); // fill ellipse with random color
		noStroke();
		ellipse(cordX, cordY, width, height); // float X coord, float Y cord, width, height
	}
	
	// function to move the core on the canvas
	void moveCore() {
		// move the Core (change cords.)
		this.cordX += this.dx;
		
		// set the boundaries of the window
		if(cordX < 0) { // change X movement
			this.setDX(0.1);
		}
		if(cordX > windowXRes) {
			this.setDX(-0.1);
		} // change Y movement
		if(cordY < 0) {
			this.setDY(0.1);
		}
		if(cordY > windowYRes) {
			this.setDY(-0.1);
		}
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
				
				// set enemyNode id to delete
				var deletePID = sArray[0].parentID;
				var deleteID = sArray[0].id;
				
				for(i = 0; i < enemyNodes.size(); i++) {
					if(enemyNodes.get(i).parentID == deletePID && enemyNodes.get(i).id == deleteID) {
						// delete Node out of array						
						enemyNodes.remove(i);
						
						// add points to player
						pScore = pScore + 10;
						
						// reset select array
						resetSelectArray();
						
					} else {
						// reset select array
						resetSelectArray();
					}
				}
				
				// reset Array
				resetSelectArray();				
			} else {
				selected_wrong.play();
				// TODO: reset color with temp var
				this.farbe = tempCol;
				
				// reset Array
				resetSelectArray();
				
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
	
	// change X cord. speed and direction
	void setDX(xVal) {
		this.dx = xVal;
	}
	
	// change Y cord. speed and direction
	void setDY(yVal) {
		this.dy = yVal;
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
	float cordX;
	float cordY;
	var dx;
	var dy;
	var name;
	
	// Constructor
	EnemyNode(int pIDP,int idP, color colorP, int hP, int wP, float cordXP, float cordYP, var nP) {
		this.parentID = pIDP;
		this.id = idP;
		this.farbe = colorP;
		this.height = hP;
		this.width = wP;
		this.cordX = cordXP;
		this.cordY = cordYP;
		this.dx = 0.2;
		this.dy = 0;
		this.name = nP;
	}
	
	void display() {
		// create ellipse
		fill(farbe); // fill ellipse with color
		noStroke();
		ellipse(cordX, cordY, width, height); // float X coord, float Y coord, width, height
	}
	
	// function to move the core on the canvas
	void moveNode() {
		// move the Core (change cords.)
		this.cordX += this.dx;
		
		// set the boundaries of the window
		if(cordX < 0) { // change X movement
			this.setDX(random(2, 4)); // set random movement was 0.1
		}
		if(cordX > windowXRes) {
			this.setDX(random(-2, -4)); // // set random movement was -0.1
		} // change Y movement
		if(cordY < 0) {
			this.setDY(random(2, 4)); // set random movement was 0.1
		}
		if(cordY > windowYRes) {
			this.setDY(random(-2, -4)); // set random movement was -0.1
		}
	}
	
	// function to trigger the click
	void clicked() {
		
		var tempColorArray = [];		
		var d = dist(mouseX, mouseY, this.cordX, this.cordY); // get distance between mouse and ellipse radius
		
		if(d < this.width/2) {
			
			// play selected sound
			selected.play();
			sArray.push(this); // push selected Node to the selectedItemsArray
			
			// set selected color
			this.farbe = color(255, 255, 255);
			
			// call check array func.
			if(checkArray() == true) {
				
				selected.stop();
				selected_right.play();
				
				this.farbe = tempCol;
				
				// reset selected Array
				resetSelectArray();
				
				
			} else {
				selected.stop();
				selected_wrong.play();
				
				// reset selected Array
				resetSelectArray();				
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
	
	// change X cord. speed and direction
	void setDX(xVal) {
		this.dx = xVal;
	}
	
	// change Y cord. speed and direction
	void setDY(yVal) {
		this.dy = yVal;
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
	bg_music.play().loop();
	

	// create enemy array
	enemys = new ArrayList<Enemy>();
	enemyNodes = new ArrayList<EnemyNode>();
	

	// fill enemy array, iterate through enemys array and generate random x, y cords. int index
	for(index = 0; index <= 3; index++) { // replace with arrayList
		// generate random values:
		rand_x_cord = random(0, windowXRes-40); // get win X size minus 10 pixels (margin)
		rand_y_cord = random(0, windowYRes-40); // get win Y size minus 10 pixels (margin)
	
		enemys.add(new Enemy(index+1, colors[index], 2, 25, 25, rand_x_cord, rand_y_cord, "Enemy"));
		
		for(indNodes = 0; indNodes <= 9; indNodes++) {
			// set new x and y cords. for the nodes
			rand_x_cord = random(0, windowXRes-20); // get win X size minus 10 pixels (margin)
			rand_y_cord = random(0, windowYRes-20); // get win Y size minus 10 pixels (margin)
			
			enemyNodes.add(new EnemyNode(index+1, indNodes+1, colors[index], 15, 15, rand_x_cord, rand_y_cord, "EnemyNode"));
		}
	}
	
	// set time to 0
	time = 0;
	pScore = 0;
}

// Main draw loop
void draw() {
	
	//background(bg_color); // 0 - 255 (black - white), replace with function
	background(100);
	
	// iterate enemy array and "draw" them
	for (int i = 0; i <= enemys.size()-1; i++) {		
		Enemy enemy = enemys.get(i);
		enemy.display();
	}
	
	// iterate enemyNode array and "draw" them
	for(j = 0; j <= enemyNodes.size()-1; j++) { // int		
		EnemyNode eNode = enemyNodes.get(j);
		Enemy enemy = enemys.get(0);

		eNode.display();
		eNode.moveNode();
		
		// draw lines between the "core" and "nodes"
		if(enemys.get(0).getID() == enemyNodes.get(j).getParentID()) { // draw RED
			stroke(enemys.get(0).getColor());
			enemys.get(0).moveCore();
			line(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(0).getXCord(), enemys.get(0).getYCord()); // x1, y1, x2, y2
		} else if(enemys.get(1).getID() == enemyNodes.get(j).getParentID()) { // draw GREEN
			stroke(enemys.get(1).getColor());
			enemys.get(1).moveCore();
			line(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(1).getXCord(), enemys.get(1).getYCord()); // x1, y1, x2, y2
		} else if(enemys.get(2).getID() == enemyNodes.get(j).getParentID()) { // draw BLUE
			stroke(enemys.get(2).getColor());
			enemys.get(2).moveCore();
			line(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(2).getXCord(), enemys.get(2).getYCord()); // x1, y1, x2, y2
		} else if(enemys.get(3).getID() == enemyNodes.get(j).getParentID()) { // draw YELLOW
			stroke(enemys.get(3).getColor());
			enemys.get(3).moveCore();
			line(enemyNodes.get(j).getXCord(), enemyNodes.get(j).getYCord(), enemys.get(3).getXCord(), enemys.get(3).getYCord()); // x1, y1, x2, y2
		}
	}
	
	// draw HUD
	drawHUD(parseInt((time++)/60), pScore);
	
	// check gamestate (win or lose)
	if((time/60) == 181) {
		$('#timeNet_canvas').hide();
		$('#lost').show();
		bg_music.stop();
		game_lost.play();
	} else if(pScore == 400) {
		$('#timeNet_canvas').hide();
		$('#won').show();
		bg_music.stop();
		game_won.play();
	}
}

// if mouse is pressed (not released)
void mousePressed() {
	// check if ellipse is clicked?
	// iterate nodes array
	for (int j = 0; j <= enemyNodes.size()-1; j++) {		
		EnemyNode eNode = enemyNodes.get(j);
		eNode.clicked();
	}
	
	// iterate enemy array
	for (int i = 0; i <= enemys.size()-1; i++) {		
		Enemy enemy = enemys.get(i);
		enemy.clicked();
	}
}

function drawHUD(t, p) {	
	//background(100);
	fill(color(255,255,255));
	// time:
	text("Seconds: "+t+" ( "+ parseInt(t-180)*(-1) +" seconds left)", width/2, 20);
	
	// player points
	text("Player Score: "+p, (width/2)-120, 20);
}