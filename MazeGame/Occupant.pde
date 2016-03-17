/**
* This is the abstract class for an Occupant object, which is a superclass for Explorer and Random Occupant.
*
* @author Michael Fekadu
* @version Project 3
* @version CPE102-01
* @version Fall 2015
*/

public abstract class Occupant
{
   private Square location;

   public Occupant() {}
   
   public Occupant(Square start)
   {
      this.location = start;
   }
   
   public Square location()
   {
      return location;
   }
   
   public void moveTo(Square newLoc)
   {
      this.location = newLoc;
   }
}
