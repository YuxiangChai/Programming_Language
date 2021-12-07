public class Control {
    public Object[] c;
    private boolean flag;
    public Control()
    {
        c = new Object[1];
        flag = false;
    }

    public synchronized void rename(String n)
    {
        synchronized (c) {
            try {
                while(flag){
                    c.wait();
                }
            } catch (InterruptedException e) {;}

            flag = true;
            c[0] = n;
            c.notifyAll();
        }
    }

    public String get_name()
    {
        String temp;
        synchronized (c) {
            try {
                while(!flag){
                    c.wait();
                }
            } catch (InterruptedException e) {;}
            temp = String.valueOf(c[0]);
        }
        return temp;
    }

    public void after_remove()
    {
        synchronized (c) {
            c[0] = "none";
            flag = false;
            c.notifyAll();
        }
    }
}
