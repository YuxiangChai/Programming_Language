/**
 * Producer.java
 *
 * This is the producer thread for the bounded buffer problem.
 *
 */

import java.util.*;

public class Producer extends Thread
{
   public Producer(Buffer b, String n) {
      buffer = b;
      name = n;
   }

   public void run()
   {
      int value;
      String str;
      int i = 0;

      while (i < 6)
      {
         int sleeptime = (int) (Buffer.NAP_TIME * Math.random()) +1;

         System.out.println("Producer " + name + " sleeping for " + sleeptime + " seconds");

         try { sleep(sleeptime*1000); }
         catch(InterruptedException e) {}

         // produce an item & enter it into the buffer
         value = 4000 + (int)(Math.random() * ((60000 - 4000) + 1));
         str = String.valueOf(value);
         System.out.println("Producer " + name + " produced " + str);

         buffer.enter(value, name);
         i = i + 1;
      }
   }

   private Buffer buffer;
   private String name;
   private Control control;
}
