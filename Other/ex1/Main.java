package ex1;
import java.util.*;
import java.io.*;

public class Main {
    public static Scanner obj = new Scanner(System.in);
    public static PrintWriter out = new PrintWriter(System.out);

    public static void main(String args[]){
        String s;
        s = obj.next();
        int max = 0, curr = 0;
        while (!s.equals("-1")){
            if (!s.equals("")){
                int x = Integer.parseInt(s);
                curr += x;
            } else {
                max = Math.max(max, curr);
                curr = 0;
            }
            s = obj.nextLine();
        }
        out.println(max);
        out.flush();
    }
}