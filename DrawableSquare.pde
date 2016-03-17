/**
* This is the class for a DrawableSquare, which is a Square object that can be drawn.
*
* @author Michael Fekadu
* @version Project 3
* @version CPE102-01
* @version Fall 2015
*/

public class DrawableSquare extends Square implements Drawable
{

   public DrawableSquare(boolean up, boolean right, boolean down, boolean left,
         int row, int col)
   {
      super(up, right, down, left, row, col);
   }

   @Override
   public void draw()
   {
      int x1 = x();
      int y1 = y();
      int x2 = x() + SQUARE_SIZE;
      int y2 = y() + SQUARE_SIZE;
      
      if (inView())
      {
         fill(255);
         noStroke();
         rect(x1,y1,x2,y2);

         stroke(0);
         strokeWeight(5);
         
         if(wall(UP))
         {
            line(x1,y1,x2,y1);
         }
         if (wall(RIGHT))
         {
            line(x2,y1,x2,y2);
         }
         if(wall(DOWN))
         {
            line(x2,y2,x1,y2);
         }
         if(wall(LEFT))
         {
            line(x1,y2,x1,y1);
         }
      }
      
      if (seen() && !inView())
      {
         fill(100);
         noStroke();
         rect(x1,y1,x2,y2);

         stroke(0);
         strokeWeight(3);

         if(wall(UP))
         {
            line(x1,y1,x2,y1);
         }
         if (wall(RIGHT))
         {
            line(x2,y1,x2,y2);
         }
         if(wall(DOWN))
         {
            line(x2,y2,x1,y2);
         }
         if(wall(LEFT))
         {
            line(x1,y2,x1,y1);
         }
      }
        
   }

}