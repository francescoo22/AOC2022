package ex7;
import java.util.*;

import java.io.*;

public class Main {
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

    public static void main(String args[]){
        FileSystem fs = new FileSystem();

        String s;
        s = obj.nextLine();
        s = obj.nextLine();

        while (!s.equals("end")){
            String[] l = s.split(" ");
            if (l[0].equals("$")){
                if(l[1].equals("cd")) fs.cd(l[2]);
            } else {
                if (l[0].equals("dir")) fs.mkdir(l[1]);
                else {
                    long size = Long.parseLong(l[0]);
                    fs.touch(size, l[1]);
                }
            }
            s = obj.nextLine();
        }

        long ans = fs.getAns(100000, fs.getRoot());
        out.println("ans1: " + ans);

        long moreThan = 30000000 - (70000000 - fs.getRootSize());
        long ans2 = fs.getAns2(moreThan, fs.getRoot());
        out.println("ans2: " + ans2);
        // fs.print(fs.getRoot(), out, 0);
        out.flush();
    }
}