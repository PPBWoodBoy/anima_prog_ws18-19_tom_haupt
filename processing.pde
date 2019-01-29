ArrayList balls = new ArrayList();

void setup() {
    size(1920, 1080);
    background(100);
}

void draw() {

    // reset bgcolor
    background(100);

    if(balls.size() > 0) {
        for(int i = 0; i < balls.size(); i++) {
            balls.get(i).update(); // iterate through ball arraylist and update every ball
            balls.get(i).draw(); // iterate through ball arraylist and draw every ball
        }
    }

    void update() {
        yV += gravity;
        y += yV;

        if(y > 480) {
            yV = -20;
        }
    }
}

// overwrite the mouseClicked function
void mouseClicked() {
    Ball b = new Ball(mouseX, mouseY); // create new ball when clicked
    balls.add(b); // add ball to balls array
}

class Ball {
    int x, y;
    int yV;
    int gravity;

    Ball(int initX, int initY) {
        x = initX;
        y = initY;
        yV = 1;
        gravity = 1;
    }
}