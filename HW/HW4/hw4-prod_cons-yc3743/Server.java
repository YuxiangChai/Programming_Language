/**
 * Server.java
 *
 * This creates the buffer and the producer and consumer threads.
 *
 */

public class Server
{
	public static void main(String args[]) {
		Control control = new Control();
		Buffer buffer1 = new Buffer(control, "Alice");
		Buffer buffer2 = new Buffer(control, "Moira");


      		// now create the producer and consumer threads

      		Producer producerThread1 = new Producer(buffer1, "Alice");
			Producer producerThread2 = new Producer(buffer2, "Moira");
      		Consumer consumerThread = new Consumer(buffer1, buffer2, "Johnny", control);

      		producerThread1.start();
			producerThread2.start();
      		consumerThread.start();

	}//main
}//class
