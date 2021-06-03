final static int BRICKS_PER_ROW=7;
final static int NUM_ROWS=9;
final static int BRICK_WIDTH=70;
final static int BRICK_GAP=10;
final static int BALLS_DELAY=7; //frames between subsequent ball launches
ArrayList<Brick> bricks; // all bricks
ArrayList<Multiplier> mults; // all multipliers
ArrayList<Ball> balls; // all balls
float startX = 285; // position of launch
int currentLevel; //current level
int gameView = 0;
// 0: Launch Screen
// 1: Game Screen
// 2: Gameover Screen (LATER)
int framesToNextLaunch = 0;
boolean firstBallDone;

void setupGame() {
  bricks=new ArrayList<Brick>();
  mults=new ArrayList<Multiplier>();
  balls=new ArrayList<Ball>();
  currentLevel=1;
  
  addRow(); //add first row 
  
  for (int i=0;i<10;i++){ //TEMP only for test. Scaled up tp 50+ balls with no lag! Will be 1 ball only at start
    Ball first=new Ball(startX);
    balls.add(first);
  }
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
   
    for (int i=0;i<BRICKS_PER_ROW;i++){ //TBD this will have to randomly create the new row with a mix of bricks of different strength and some multiplier
      Brick test=new Brick(1,i,(i+1)*5);
      bricks.add(test);
      
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
  if (gameView == 0) {
    launchScreen();
  } else if (gameView == 1) {
    activeScreen();
  }
  else if (gameView == 2) {
    gameOverScreen();
  }
}

void mouseReleased() {
  //define angle from mouse position
  float shootAngle = atan2(mouseY-(height-BALL_RADIUS), mouseX-startX);
  for (Ball b: balls){ // set launch vector for all balls
      b.setLaunchVector(shootAngle, 10);
  }
  gameView = 1; // switch to game active screen that will launch and move the balls
}


void launchScreen() {

  // THIS JUST DISPLAYS THE WHOLE BRICKS MAP - TEMPORARY
  //for (int r = 1; r< 9; r++) {
  //  for (int c=0; c<7; c++) {
  //    fill(50);
  //    rect(10+c*80, 10+r*80, 70, 70); // Use this formula in Brick class to calculate x,y from column and row of brick
  //    }
  //  }
  
    //if(addRow()){
    //  gameView = 2; //Game is over
    //  return;
    //}
    //else {  // draw map for new round
      for (Brick b: bricks)
         b.display();
    //}
    
    //Prepare for new round of balls by setting all of them to "readyToLaunch"
    for (Ball b: balls){
      b.readyToLaunch();
    }
    firstBallDone = false; // start of the round, initialize first ball down flag that will determine next startX
    
    framesToNextLaunch = 0; 
 
    if (mousePressed == true){
      stroke(125);
      strokeWeight(3);
      line(startX,height - BALL_RADIUS, mouseX, mouseY);
    }  

    
    //TBD HERE we need to take care of aim using mouse input, setting the initial direction of launch of all "readyToLaunch" balls 
    //for (Ball b: balls){
    //  b.setLaunchVector(-QUARTER_PI, 10);  //TEMP - will be set with aim controls
    //}
    //gameView = 1; // start balls animation
    
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
           b.checkCollision(bricks);
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
         b.checkCollision(bricks);
         b.display();
         anyBallActive = true;
       }
       else {
         b.display();
       }
     }
     
     if (!anyBallActive){ // the round is done -> add a row for next roundswitch to launch screen
         if(addRow()){
            gameView = 2; //Game is over
            return;
         }
         currentLevel++; // increment score
         gameView = 0; //switch to launch screen
     }

  //delay (500); // TEMP to see new rows added
  //if (addRow())
  //  gameView = 2 ; //GAME OVER screen
  
  //else {
  //  for (Brick b: bricks)
  //   b.display();
  //}
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
  - add the strength counter in the middle of blocks
  - clean up stroke in all displays for map objects
  - complete multiplier class
  - tune color scheme if needed (now tweaked for 50 levels max red color)
  - implement multiplier effect
    - add animation for new balls when collected
  - adjust the startX to where the first ball drops
  - set x for all readyToLaunch balls to the global startX at the beginning of the launchScreen
  - randomize row creation
    - add animation to collect all balls to the startX position at the beginning of launchScreen
  - tune gameplay with random elements
  - implement "fast forward" button
  - add sound??
 */
