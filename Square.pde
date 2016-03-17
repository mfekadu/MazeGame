/**
* This is the class for a Square object.
* Square is used to define the spaces that an object can enter/move into within the Maze.
* 
* @author Michael Fekadu
* @version Project 3
* @version CPE102-01
* @version Fall 2015
*/

public class Square
{
   public static final int SQUARE_SIZE = 50;
   public static final int UP = 0;
   public static final int RIGHT = 1;
   public static final int DOWN = 2;
   public static final int LEFT = 3;
   
   private boolean[] walls = new boolean[4];
   private boolean seen;
   private boolean inView;
   private int row;
   private int col;
   
   private Treasure treasure = null;
   
   public Square(boolean up, boolean right, boolean down, boolean left, int row, int col)
   {
      this.walls[UP] = up;
      this.walls[RIGHT] = right;
      this.walls[DOWN] = down;
      this.walls[LEFT] = left;
      this.row = row;
      this.col = col;
      this.seen = false;
      this.inView = false;
   }
   
   public boolean wall(int direction) //query for wall in given dir
   {
      if (direction >= UP && direction <= LEFT)
      {
         return walls[direction];
      }
      return false;
   }

   public boolean seen() {return seen;}

   public boolean inView() {return inView;}

   public int row() {return row;}
 
   public int col() {return col;}
   
   public Treasure treasure() {return treasure;}
   
   public int x() {return SQUARE_SIZE*col;}
   
   public int y() {return SQUARE_SIZE*row;}
   
   public void setInView(boolean inView)
   {
      this.inView = inView;
      
      if (this.inView == true)
      {
         this.seen = true;
      }
   }
   
   public void setTreasure(Treasure t)
   {
      this.treasure = t;
   }
   
   public void enter()
   {
      if (this.treasure != null)
      {
         treasure.setFound();
      }
   }
}
