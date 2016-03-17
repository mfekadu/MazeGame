import java.util.*;

/**
 * Class that contains all the logic to model a Maze with Treasures, Monsters, and an Explorer.
 * 
 * @author Michael Fekadu
 * @version Project 3
 * @version CPE102-01
 * @version Fall 2015
 * @version 1.0.2
 * 
 * <br>Revisions:
 *    <br>1.0.2 fixed lookAround to check directions correctly and removed code which would prevent setInView(true)
 *    <br>1.0.1 Fixed foundAllTreasures() to check for null on each treasure
 *    <br>1.0.0 Initial version.
 */

public class Maze
{
   // named constants
   public static final int ACTIVE = 0;
   public static final int EXPLORER_WIN = 1;
   public static final int MONSTER_WIN = 2;
    
    // instance variables
   private Square[][] squares;
   private ArrayList<RandomOccupant> randOccupants;
   private Explorer explorer;
   private int rows;
   private int cols;

   /**
    * Constructor for objects of class Maze
    */
   public Maze(Square[][] squares, int rows, int cols)
   {
      this.squares = squares;
      this.rows = rows;
      this.cols = cols;
      
      randOccupants = new ArrayList<RandomOccupant>();		
   }
	
   // QUERIES
   public Square getSquare(int row, int col) { return squares[row][col]; }
   public int rows() {return rows;}
   public int cols() {return cols;}
   public String explorerName() {return explorer.name();}
   public Explorer getExplorer() {return explorer;}

   public RandomOccupant getRandomOccupant(int index) {return randOccupants.get(index);}
   public int getNumRandOccupants() {return randOccupants.size();}
	
   // COMMANDS
   public void addRandomOccupant(RandomOccupant ro) {randOccupants.add(ro);}

   public void setExplorer(Explorer e) {explorer = e;}

   public void explorerMove(int key)
   {
      explorer.move(key);
   }
	
   public void randMove()
   {
      for (int i = 0; i < randOccupants.size(); i++)
      {
         randOccupants.get(i).move();
      }
   }
	
   /**
    * Returns the status of the game.
    *
    * If all treasures have been found, return EXPLORER_WIN.
    * If not, check each maze occupant, if it is a Monster and
    *    it is in the same location as the Explorer, return
    *    MONSTER_WIN.  Note that you can use == to check locations, do you know why?
    * Otherwise, return ACTIVE.
    */
   public int gameStatus()
   {
      int status = ACTIVE;
        
      if (foundAllTreasures() == true)
      {
         return EXPLORER_WIN;
      }
      
      if (foundAllTreasures() != true)
      {
         for (int i = 0; i < randOccupants.size(); i++)
         {
            if (randOccupants.get(i) instanceof Monster &&
                randOccupants.get(i).location() == explorer.location())
            {
               return MONSTER_WIN;
            }
         }
      }
      return status;
   }
	
   private boolean foundAllTreasures()
   {
      boolean foundAll = true;
      
      for (int i = 0; i < randOccupants.size(); i++)
      {
         if (randOccupants.get(i).location().treasure() != null)
         {
            foundAll &= randOccupants.get(i).location().treasure().found();
         }
      }
              
      return foundAll;
   }
    
   public void lookAround(Square s)
   {
      int row = s.row();
      int col = s.col();

      int goUp    = row - 1;
      int goRight = col + 1;
      int goDown  = row + 1;
      int goLeft  = col - 1;
        
      // Clear what was previously in view
      resetInView();
        
      // Set the current square so that we are viewing it (obviously)
      s.setInView(true);

      if (s.wall(Square.UP) == false)
      {
         Square up = getSquare(goUp, col);
         squares[up.row()][up.col()].setInView(true);

         if (up.wall(Square.LEFT) == false)
         {
            Square upLeft = getSquare(goUp, goLeft);
            squares[upLeft.row()][upLeft.col()].setInView(true);
         }

         if (up.wall(Square.RIGHT) == false)
         {
            Square upRight = getSquare(goUp, goRight);
            squares[upRight.row()][upRight.col()].setInView(true);
         }
      }

      if (s.wall(Square.RIGHT) == false)
      {
         Square right = getSquare(row, goRight);
         squares[right.row()][right.col()].setInView(true);

         if (right.wall(Square.UP) == false)
         {
            Square rightUp = getSquare(goUp, goRight);
            squares[rightUp.row()][rightUp.col()].setInView(true);
         }

         if (right.wall(Square.DOWN) == false)
         {
            Square rightDown = getSquare(goDown, goRight);
            squares[rightDown.row()][rightDown.col()].setInView(true);
         }
      }

      if (s.wall(Square.DOWN) == false)
      {
         Square down = getSquare(goDown, col);
         squares[down.row()][down.col()].setInView(true);

         if (down.wall(Square.LEFT) == false)
         {
            Square downLeft = getSquare(goDown, goLeft);
            squares[downLeft.row()][downLeft.col()].setInView(true);
         }

         if (down.wall(Square.RIGHT) == false)
         {
            Square downRight = getSquare(goDown, goRight);
            squares[downRight.row()][downRight.col()].setInView(true);
         }
      }

      if (s.wall(Square.LEFT) == false)
      {
         Square left = getSquare(row, goLeft);
         squares[left.row()][left.col()].setInView(true);

         if (left.wall(Square.UP) == false)
         {
            Square leftUp = getSquare(goUp, goLeft);
            squares[leftUp.row()][leftUp.col()].setInView(true);
         }

         if (left.wall(Square.DOWN) == false)
         {
            Square leftDown = getSquare(goDown, goLeft);
            squares[leftDown.row()][leftDown.col()].setInView(true);
         }
      }
   }
    
   private void resetInView()
   {
      for (int i = 0; i<rows; i++) {
         for (int j = 0; j<cols; j++) {
            squares[i][j].setInView(false);
         }
      }
   }
}