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
  
  addRow(); //add first row 
  
 // for (int i=0;i<1;i++){ //TEMP only for test. Scaled up tp 50+ balls with no lag! Will be 1 ball only at start once we have multipliers
  Ball first=new Ball(startX);
  balls.add(first);
 // }
}

/* Shifts all bricks down one row, adds a row or random bricks at row 1. The strength of the bricks created should be >= level
 Maybe we do half of them with strength = level and half of them with random strength up to (level + number of balls). TBD
 returns true if there is at least one brick on the last row (row 9) which triggers game over in the caller
 */
boolean addRow() {
  //Moves down bricks and multipliers. Return true if game over
  for (Brick b: bricks)
    if (b.advance())
    return true;
  for (Multiplier m:mults){
    m.advance();
  }
   
   
  for (int i=0;i<BRICKS_PER_ROW;i++){ //randomly create the new row with a mix of bricks of different strength and some multiplier
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
    //for (int i=0;i<BRICKS_PER_ROW;i++){ //TBD this will have to randomly create the new row with a mix of bricks of different strength and some multiplier
    //  Brick test=new Brick(1,i,(i+1)*5);
    //  bricks.add(test);
      
    //}
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
    firstBallDone = false; // start of the round, initialize first ball down flag that will determine next startX
    
    framesToNextLaunch = 0; 
 
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
}

void keyPressed() { //TEMP restarts the game. We can have different actions implemented later: e.g. speed up, restart
  if (keyCode == 32){
    setup();
  }
}


/* TO BE DONE: 
  V add the strength counter in the middle of blocks
  V clean up stroke in all displays for map objects
  V complete multiplier class
  - tune color scheme if needed (now tweaked for 40 levels max red color)
  V implement multiplier effect
  V adjust the startX to where the first ball drops
  V set x for all readyToLaunch balls to the global startX at the beginning of the launchScreen
  V randomize row creation
  - tune gameplay balancing (difficulty) with random elements
  - implement "fast forward" button
  - add sound??
  - handle the case when gameover happens because a multiplier reached bottom screen
  - add animation to collect all balls to the startX position at the beginning of launchScreen
  - add animation for new balls when collected
  - add score on the top
  - add score on Game Over
  - add number of balls above the launch position in LAUNCH_SCREEN
 */
