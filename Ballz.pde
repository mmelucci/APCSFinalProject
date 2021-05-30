final static int BRICKS_PER_ROW=5;
final static int NUM_ROWS=9;
final static int BRICK_WIDTH=70;
final static int BRICK_GAP=10;
ArrayList<Brick> bricks; // all bricks
ArrayList<Multiplier> mults; // all multipliers
ArrayList<Ball> balls; // all balls
int startX; // position of launch
int currentLevel; //current level
int gameView = 1;
// 0: Launch Screen
// 1: Game Screen
// 2: Gameover Screen (LATER)
void setupGame() {
  bricks=new ArrayList<Brick>();
  mults=new ArrayList<Multiplier>();
  balls=new ArrayList<Ball>();
  currentLevel=0;
  addRow();
  addRow();
}
/* Shifts all bricks down one row, adds a row or random bricks at row 1. The strength of the bricks created should be >= level
 Maybe we do half of them with strength = level and half of them with random strength up to (level + number of balls). TBD
 returns true if there is at least one brick on the last row (row 9) which triggers game over in the caller
 */
boolean addRow() {
  for (Brick b: bricks)
    if (b.advance())
    return true;
  for (Multiplier m:mults){
    m.advance();
  }
    for (int i=0;i<BRICKS_PER_ROW;i++){
      Brick test=new Brick(0,i,i);
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
  //else if (gameScreen == 2) {
  //  gameOverScreen();
  //}
}

void mousePressed() {
}

void aim() {
}

void launchScreen() {

  /* THIS IS JUST FOR US TO SEE THE WHOLE BRICKS MAP - TEMPORARY
   we will build the array of bricks and call Bricks.display() for each of the bricks in the arraylist to build map
   */
  for (int r = 1; r< 9; r++) {
    for (int c=0; c<7; c++) {
      fill(50);
      rect(10+c*80, 10+r*80, 70, 70); // Use this formula in Brick class to calculate x,y from column and row of brick
    }
  }
}

void activeScreen() {
  /* Here we are gonna have to implement all the bouncing, hitting and multiplying action.
   When all the balls get to the bottom of the screen the round ends by setting gameView = 0 that
   triggers launchScreen()
   */
   for (Brick b: bricks){
   b.display();
  
}
  // code to be added here
}
