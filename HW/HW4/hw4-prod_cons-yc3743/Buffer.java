/**
 * BoundedBuffer.java
 *
 * This program implements the bounded buffer using shared memory.
 * Note that this solution is thread-safe - notice the usage of
 * AtomicInteger (read about it here - 
 * https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/atomic/AtomicInteger.html)
 * 
 * @author Abhishek Verma
 */

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

public class Buffer
{
   public Buffer(Control c, String n)
   {
      // buffer is initially empty
      flag = false;
      control = c;
      name = n;
      buffer = new Object[BUFFER_SIZE];
   }

   // producer calls this method
   public void enter(Object item, String n){
      
      // add an item to the buffer
      buffer[0] = item;
      flag = true;
      control.rename(n);
   }

   // consumer calls this method
   public Object remove(){
      Object item;
      
      item = buffer[0];
      flag = false;
      control.after_remove();
      
      return item;
   }

   public static final int    NAP_TIME = 3;
   private static final int   BUFFER_SIZE = 1;

   private boolean flag;
   private Object[] buffer;
   private Control control;
   private String name;
}
