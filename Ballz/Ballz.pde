final static int BRICKS_PER_ROW=7;
final static int NUM_ROWS=9;
final static int BRICK_WIDTH=70;
final static int BRICK_GAP=10;
ArrayList<Brick> bricks; // all bricks
ArrayList<Multiplier> mults; // all multipliers
ArrayList<Ball> balls; // all balls
int startX = 285; // position of launch
int currentLevel; //current level
int gameView = 0;
// 0: Launch Screen
// 1: Game Screen
// 2: Gameover Screen (LATER)


void setupGame() {
  bricks=new ArrayList<Brick>();
  mults=new ArrayList<Multiplier>();
  balls=new ArrayList<Ball>();
  currentLevel=0;
  Ball first=new Ball(startX);
  balls.add(first);
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
   
    for (int i=0;i<BRICKS_PER_ROW;i++){
      Brick test=new Brick(1,i,i);
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

void mousePressed() {
  // TBD to allow aim and shoot
}

void aim() {
  //TBD controlling with mouse to set initial angle and speed for all balls
}

void launchScreen() {
  // THIS JUST DISPLAYS THE WHOLE BRICKS MAP - TEMPORARY
  //for (int r = 1; r< 9; r++) {
  //  for (int c=0; c<7; c++) {
  //    fill(50);
  //    rect(10+c*80, 10+r*80, 70, 70); // Use this formula in Brick class to calculate x,y from column and row of brick
  //    }
  //  }
  
    if(addRow()){
      gameView = 2; //Game is over
      return;
    }
    else {  // draw map for new round
      for (Brick b: bricks)
         b.display();
    }
    
    //TBD HERE we need to take care of aim using mouse input, setting the initial direction of launch of all "readyToLaunch" balls 
    for (Ball b: balls){
        b.setLaunchVector(-QUARTER_PI, 10);  //TEMP - will be set with aim controls
        b.activate();
    }
    gameView = 1; // start balls animation
    
}

void activeScreen() {
  /* Here we are gonna have to implement all the bouncing, hitting and multiplying action.
   When all the balls get to the bottom of the screen the round ends by setting gameView = 0 that
   triggers launchScreen()
   */
  
  //Draw current map of bricks and multipliers
     for (Brick b: bricks)
       b.display();
     for (Multiplier m: mults)
       m.display();
       
     for (Ball b: balls){
       if (b.isActive()){
         b.move();
         b.checkCollision(bricks);
         b.display();
       }
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
