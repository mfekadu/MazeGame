import java.awt.event.KeyEvent;

/**
 * This is the class for an Explorer object, which is a subclass of Occupant.
 *
 * @author Michael Fekadu
 * @version Project 3
 * @version CPE102-01
 * @version Fall 2015
 * @version 1.0.1
 * 
 * <br>Revisions:
 *    <br>1.0.1 Fixed move(int key) to actually move the Explorer.
 *    <br>1.0.0 Initial version.
 */

public class Explorer extends Occupant
{
   private String name;
   
   private Maze maze;

   public Explorer(Square location, Maze maze, String name)
   {
      super(location);
      this.maze = maze;
      this.name = name;
      this.maze.lookAround(location);
   }
   
   public String name() {return name;}
   
   public void move(int key)
   {
      int row = location().row();
      int col = location().col();
      
      if (key == KeyEvent.VK_UP || key == KeyEvent.VK_KP_UP)
      {
         row -= 1;

         maze.lookAround(location());
         if (location().wall(Square.UP) == false && row >= 0)
         {
            moveTo(maze.getSquare(row, col));
         }
      }
      
      if (key == KeyEvent.VK_RIGHT || key == KeyEvent.VK_KP_RIGHT)
      {
         col += 1;

         maze.lookAround(location());
         if (location().wall(Square.RIGHT) == false && col < maze.cols())
         {
            moveTo(maze.getSquare(row, col));
         }
      }
      
      if (key == KeyEvent.VK_DOWN || key == KeyEvent.VK_KP_DOWN)
      {
         row += 1;

         maze.lookAround(location());
         if (location().wall(Square.DOWN) == false && row < maze.rows())
         {
            moveTo(maze.getSquare(row, col));
         }
      }
      
      if (key == KeyEvent.VK_LEFT || key == KeyEvent.VK_KP_LEFT)
      {
         col -= 1;

         maze.lookAround(location());

         if (location().wall(Square.LEFT) == false && col >= 0)
         {
            moveTo(maze.getSquare(row, col));
         }
      }
   }
   
   @Override
   public void moveTo(Square s)
   {
      super.moveTo(s);
      s.enter();
      maze.lookAround(s);
   }
}