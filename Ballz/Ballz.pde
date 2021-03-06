final static int BRICKS_PER_ROW=7;
final static int NUM_ROWS=9;
final static int BRICK_WIDTH=70;
final static int BRICK_GAP=8;
final static int BALLS_DELAY=7; //frames between subsequent ball launches
final static int LAUNCH_SCREEN = 0;
final static int ACTIVE_SCREEN = 1;
final static int GAMEOVER_SCREEN = 2;
final static int MAX_MULT = 3; // max number of multipliers per row
final static float BRICKS_DENSITY = 0.5; // (0-1.0] density of bricks in new rows
final static float MULT_DENSITY= .8/(BRICKS_PER_ROW * (1-BRICKS_DENSITY));
ArrayList<Brick> bricks; // all bricks
ArrayList<Multiplier> mults; // all multipliers
ArrayList<Ball> balls; // all balls
ArrayList<Ball> newBalls; //balls to be added at end of round
float startX = 285; // position of launch
int currentLevel; //current level
int gameView = LAUNCH_SCREEN;

int framesToNextLaunch = 0;
boolean firstBallDone;

void setupGame() {
  bricks=new ArrayList<Brick>();
  mults=new ArrayList<Multiplier>();
  balls=new ArrayList<Ball>();
  newBalls=new ArrayList<Ball>();
  currentLevel=1;
  
  noStroke(); // No border in bricks and multipliers
  addRow(); //add first row 
  
 // for (int i=0;i<1;i++){ //TEMP only for test. Scaled up tp 50+ balls with no lag! Will be 1 ball only at start once we have multipliers
  Ball first=new Ball(startX, height - BALL_RADIUS);
  balls.add(first);
 // }
}

/* Shifts all bricks down one row, adds a row or random bricks at row 1. The strength of the bricks created should be >= level
 Maybe we do half of them with strength = level and half of them with random strength up to (level + number of balls). TBD
 returns true if there is at least one brick or one multiplier on the last row (row 9) which triggers game over in the caller
 */
boolean addRow() {
  //Moves down bricks and multipliers. Return true if game over
  for (Brick b: bricks)
    if (b.advance())
      return true;
  for (Multiplier m:mults)
    if (m.advance())
      return true;
  
  //randomly create the new row with a mix of bricks of different strength and some multiplier
  for (int i=0;i<BRICKS_PER_ROW;i++){ 
      float r = random(1);
      Brick newBrick;
      if (r<BRICKS_DENSITY) { // place a brick
          float s = random(1); 
          if (s < BRICKS_DENSITY/2) // to be tweaked, hardest if this threshold is higher
             newBrick=new Brick(1,i, currentLevel*2); // double strength
          else
             newBrick=new Brick(1,i, currentLevel);  // normal strength for this level
          bricks.add(newBrick);
      }
      else {
         r = random(1);
         if (r<MULT_DENSITY) { //place a MULT
          Multiplier newMult = new Multiplier(1,i); //makes a mult
          mults.add (newMult);
         } 
      }
  }
  return false;
}

void setup() {
  size(570, 810);
  setupGame();
}

void draw() {
  background(0);
  // Display the contents of the current screen
  if (gameView == LAUNCH_SCREEN) {
    launchScreen();
  } else if (gameView == ACTIVE_SCREEN) {
    activeScreen();
  }
  else if (gameView == GAMEOVER_SCREEN) {
    gameOverScreen();
  }
}

void mouseReleased() {
  //define angle from mouse position
  if (gameView == LAUNCH_SCREEN) { // we don;t care about the mouse click if not in LAUNCH_SCREEN
    float shootAngle = atan2(mouseY-(height-BALL_RADIUS), mouseX-startX);
    for (Ball b: balls){ // set launch vector for all balls
      b.setLaunchVector(shootAngle, 10);
    }
    gameView = ACTIVE_SCREEN; // switch to game active screen that will launch and move the balls
  }
}


void launchScreen() {
    textSize(30);
    text("Score: " + currentLevel, 225,50);
    if (currentLevel == 1) {
      textSize(10);
      text("(Press SPACEBAR to restart)", 25,50);
    }
    // Build Map with current bricks and ball multipliers
    for (Brick b: bricks)
         b.display();
    for (Multiplier m: mults)
       m.display();
    
    //Prepare for new round of balls by setting all of them to "readyToLaunch"
    for (Ball b: balls){
      b.readyToLaunch();
      b.display();
    }
    textSize(10);
    fill(255);
    text(balls.size(), startX, height - 2*BALL_RADIUS);
    
    firstBallDone = false; // start of the round, initialize first ball down flag that will determine next startX
    
    framesToNextLaunch = 0; // to time the launch of subsequent balls every BALLS_DELAY frames
 
    if (mousePressed == true){
      stroke(125);
      strokeWeight(3);
      line(startX,height - BALL_RADIUS, mouseX, mouseY);
      noStroke(); // we do not want borders on bricks, balls etc. 
    }  
}

void activeScreen() {
  /* Here we implement all the bouncing, hitting and multiplying action.
   When all the balls get to the bottom of the screen the round ends by setting gameView = 0 that
   triggers launchScreen()
   */
  boolean anyBallActive = false; //to keep track if we still have any balls running on the round
  textSize(30);
  text("Score: " + currentLevel, 225,50);
  //Draw current map of bricks and multipliers
     for (Brick b: bricks)
       b.display();
     for (Multiplier m: mults)
       m.display();
     
  //Launch "readyToLaunch" ball
     if (framesToNextLaunch == 0){ //handles the shooting of new balls that are "readyToLaunch
       for (Ball b: balls){
         if (b.isReadyToLaunch()){
           b.move();
           b.activate();
           b.checkCollision(bricks,mults,newBalls);
           b.display();
           framesToNextLaunch = BALLS_DELAY;
           break;
         }
       }
     }
     framesToNextLaunch--; //decrease the counter of frames in between subsequent ball launches
     
  //Handle active balls movement   
     for (Ball b: balls){
       if (b.isActive()){
         b.move();
         b.checkCollision(bricks,mults,newBalls);
         b.display();
         anyBallActive = true;
       }
       else {
         b.display();
       }
     }
     
     //Handle newly collected balls movement - they should drop to the bottom
     for (Ball b: newBalls){
       if (b.isActive()){ //move them down but with no collision detection
         b.move();
         b.display();
       }
       else {
         b.display();
       }
     }
     
     if (!anyBallActive){ // the round is done -> add a row for next roundswitch to launch screen
         if(addRow()){
            gameView = GAMEOVER_SCREEN; //Game is over
            return;
         }
         currentLevel++; // increment score
         gameView = LAUNCH_SCREEN; //switch to launch screen
         balls.addAll(newBalls);
         newBalls.clear();
     }
}

void gameOverScreen()  {
  textSize(45);
  text("Game Over",150,400);
  textSize(30);
  text("Score: " + currentLevel,150, 450);
}

void keyPressed() { //TEMP restarts the game. We can have different actions implemented later: e.g. speed up, restart
  if (keyCode == 32){
    setup();
    gameView=LAUNCH_SCREEN;
  }
}


/* TO BE (HAS BEEN) DONE: 
  V add the strength counter in the middle of blocks
  V clean up stroke in all displays for map objects
  V complete multiplier class
  V tune color scheme if needed (now tweaked for 40 levels max red color)
  V implement multiplier effect
  V adjust the startX to where the first ball drops
  V set x for all readyToLaunch balls to the global startX at the beginning of the launchScreen
  V randomize row creation
  V tune gameplay balancing (difficulty) with random elements
  V handle the case when gameover happens because a multiplier reached bottom screen
  V add animation for new balls when collected
  V add score on the top
  V add score on Game Over
  V add number of balls above the launch position in LAUNCH_SCREEN
 */
