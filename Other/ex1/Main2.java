package ex1;
import java.util.*;
import java.io.*;

public class Main2 {
    public static File file = new File("input.txt");
    public static PrintWriter out = new PrintWriter(System.out);
    public static Scanner obj;
    static {
        try {
            obj = new Scanner(file);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String args[]) throws IOException{
        PriorityQueue<Integer> pq = new PriorityQueue<Integer>(Collections.reverseOrder());
        String s;
        s = obj.next();
        int ans = 0, curr = 0;
        while (!s.equals("-1")){
            if (!s.equals("")){
                int x = Integer.parseInt(s);
                curr += x;
            } else {
                pq.add (curr);
                curr = 0;
            }
            s = obj.nextLine();
        }
        pq.add (curr);
        for (int i=0; i<3; i++){
            ans += pq.poll();
        }
        out.println(ans);
        out.flush();
        obj.close();
    }
}