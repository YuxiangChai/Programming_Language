/**
 * Consumer.java
 *
 * This is the consumer thread for the bounded buffer problem.
 *
 */

import java.util.*;

public class Consumer extends Thread
{
   public Consumer(Buffer b1, Buffer b2, String n, Control c)
   {
      buffer1 = b1;
      buffer2 = b2;
      name = n;
      control = c;
   }

   public void run()
   {
      int value;
      String str;
      int i = 0;
      String prod_name;

      while (i < 12)
      {
         prod_name = control.get_name();
         if(prod_name == "Alice")
         {
            value = (int)buffer1.remove();
            str = String.valueOf(value);
         }
         else
         {
            value = (int)buffer2.remove();
            str = String.valueOf(value);
         }

         System.out.println("Consumer " + name + " consumed " + str + " by producer " + prod_name);
         i = i + 1;
      }
   }

   private Buffer buffer1;
   private Buffer buffer2;
   private String name;
   private Control control;
}


