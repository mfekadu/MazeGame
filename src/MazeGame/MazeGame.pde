import java.awt.event.KeyEvent.*;
import java.util.Random;

GameGUI gui;
final int ROWS = 10;
final int COLS = 10;
final int NUM_MONSTERS = 2;
final int NUM_TREASURES = 3;
int counter;
PFont f;
PSys fireW[];
int numF, fireFrame, numA;

void setup()
{
   gui = new GameGUI(ROWS, COLS, NUM_MONSTERS, NUM_TREASURES);
   
   colorMode(RGB, 255, 255, 255, 100);
//   size(COLS*Square.SQUARE_SIZE, ROWS*Square.SQUARE_SIZE);
   size(500, 500);
   counter = 0;  
   
   // setup for final scenes
   f = loadFont("AmericanTypewriter-CondensedBold-48.vlw");
   numF = 6;
   fireW = new PSys[numF];
   for (int i= 0; i < numF; i++) 
   {
      fireW[i] = new PSys(100, new PVector(random(width/2,width*4/5), random(height/4), 0));
   }
   fireFrame = 0;
   numA = 1;
}

void draw()
{
   gui.draw();
   if (!gui.isGameOver())
   {
      counter++;
      if (counter % 60 == 0)
      {
         gui.monsterMove();
      }
   }
}

void keyPressed() 
{
  if (!gui.isGameOver())
  {
     if (key == CODED)
     switch (keyCode)
     { 
        case DOWN:
           gui.move(KeyEvent.VK_DOWN);
           break;
        case UP:
           gui.move(KeyEvent.VK_UP);
           break;
        case LEFT:
           gui.move(KeyEvent.VK_LEFT);
           break;
        case RIGHT:
           gui.move(KeyEvent.VK_RIGHT);
           break;
     }
  }
}

/**
 * Class GameGUI - the user interface for MazeGame.
 */
public class GameGUI 
{
    private int rows;
    private int cols;
    private int numMonsters;
    private int numTreasures;

    private DrawableMaze maze; 
    private boolean gameover = false;
    
    // for random maze generation
    int[][] cell= new int[200][100];
    int xdim = 5;
    int ydim = 5;

    public GameGUI(int r, int c, int m, int t)
    {
        rows = r;
        cols = c;
        numMonsters = m;
        numTreasures = t;
        init();
    }
    
    public boolean isGameOver() {return gameover;}
    
    private void init()
    {
        DrawableSquare[][] squares = new DrawableSquare[rows][cols];
        int[][] randMaze;
        int N = MazeGenerator.N;
        int E = MazeGenerator.E;
        int S = MazeGenerator.S;
        int W = MazeGenerator.W;
        
        MazeGenerator mg = new MazeGenerator();
        boolean up, right, down, left;
        
        // generate a maze stored as integer values (bitwise & of 1,2,4,8)
        randMaze = mg.generate_maze(rows, cols);
        
        // remove some walls to make it easier - loops and rooms
        for (int i=0; i<ROWS+COLS; i++)
        {
            int row = (int)random(rows-2)+1; 
            int col = (int)random(cols-2)+1;
            
            switch (i%4)
            {
               case 0:
                   randMaze[row][col] &= N+E+S;
                   randMaze[row][col-1] &= N+W+S;
                   break;
               case 1: 
                   randMaze[row][col] &= E+S+W;
                   randMaze[row-1][col] &= E+N+W;
                   break;
               case 2:
                   randMaze[row][col] &= N+S+W;
                   randMaze[row][col+1] &= N+S+E;
                   break;
               default:
                   randMaze[row][col] &= N+E+W;
                   randMaze[row+1][col] &= S+E+W;
                   break;
            }          
        }
        
        // construct the maze squares with values from the randMaze
        for (int i=0; i<rows; i++) {
            for (int j=0; j<cols; j++) {
                up = ((randMaze[i][j] & N) == N);
                right = ((randMaze[i][j] & E) == E);
                down = ((randMaze[i][j] & S) == S);
                left = ((randMaze[i][j] & W) == W);
                
                squares[i][j] = new DrawableSquare(up, right, down, left, i, j);
            }
        }
        
        // construct the maze
        maze = new DrawableMaze(squares, rows, cols);
        
        // add monsters and treasures
        for (int i=0; i<numMonsters; i++)
           maze.addRandomOccupant(new DrawableMonster(maze));
           
        for (int i=0; i<numTreasures; i++)
           maze.addRandomOccupant(new DrawableTreasure(maze));
         
        // add the explorer  
        maze.setExplorer(new DrawableExplorer(squares[0][0], maze, "Kitty"));
    }    
    
    public void move(int key)
    {
       maze.getExplorer().move(key);
    }
    
    public void monsterMove()
    {
       maze.randMove(); 
    }

    /**
     * Draw method for GUI.
     */
    public void draw()
    {           
        int status = maze.gameStatus();
        
        if (status == Maze.ACTIVE)
        {
           maze.draw();
        }
        else if (status == Maze.EXPLORER_WIN) {
            maze.draw();
            gameover = true;
            
            // draw big cheese
            DrawableTreasure cheese = new DrawableTreasure(maze, maze.getSquare(6, 4));
            cheese.setFound();
            pushMatrix();
            translate(-1125, -1600);
            scale(6);
            cheese.draw();
            popMatrix();  
            
            // draw big kitty
            DrawableExplorer winner = new DrawableExplorer(maze.getSquare(6, 4), maze, "Kitty");
            pushMatrix();
            translate(-900, -1300);
            scale(5);
            winner.draw();
            popMatrix();    
          
            // tell them they won
            fill(255, 255, 0);
            textFont(f, 32);
            text("You win!!! Meowwww!!!", 50, 150);  
            
            // stagger the start of the fireworks
            if (fireFrame%20 ==0 && numA < numF) 
            {
               numA++;
            }
            
            // main firework loop
            for (int i= 0; i < numA; i++) 
            {
               fireW[i].run();
               if (fireW[i].dead()) 
               {
                  fireW[i] = new PSys(100, new PVector(random(width/3,width), random(height/4), 0));
               }
            }
            fireFrame++;
        }
        else if (status == Maze.MONSTER_WIN) {
            maze.draw();
            gameover = true;
            
            // draw large monster
            DrawableMonster dog = new DrawableMonster(maze, maze.getSquare(6, 4));
            maze.getSquare(6,4).setInView(true);
            pushMatrix();
            translate(-900, -1300);
            scale(5);
            dog.draw();
            popMatrix();
            
            // tell them they lost
            fill(255, 0, 0);
            textFont(f, 32);
            text("You lose!!! Ha ha ha!!!!", 50, 150);
        }
    }
}