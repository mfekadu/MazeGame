/**
* This is the class for a DrawableMaze, which is a Maze object that can be drawn.
*
* @author Michael Fekadu
* @version Project 3
* @version CPE102-01
* @version Fall 2015
*/

public class DrawableMaze extends Maze implements Drawable
{
   public DrawableMaze(Square[][] squares, int rows, int cols)
   {
      super(squares, rows, cols);
   }

   @Override
   public void draw()
   {
      background(0);

      for (int i = 0; i < rows(); i++)
      {
         for (int j = 0; j < cols(); j++) 
         {
            DrawableSquare s = (DrawableSquare) getSquare(i,j);
            s.draw();
         }
      }
      
      for (int i = 0; i < getNumRandOccupants(); i++)
      {
         if (getRandomOccupant(i) instanceof Treasure)
         {
            DrawableTreasure t = (DrawableTreasure) getRandomOccupant(i);
            t.draw();
         }
         
         else if (getRandomOccupant(i) instanceof Monster)
         {
            DrawableMonster m = (DrawableMonster) getRandomOccupant(i);
            m.draw();
         }
      }
      
      DrawableExplorer ex = (DrawableExplorer) getExplorer();
      ex.draw();
   }

}