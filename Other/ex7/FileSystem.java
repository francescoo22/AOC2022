package ex7;
import java.io.PrintWriter;
import java.util.*;

public class FileSystem {

    private Directory root;
    private Directory curr;

    public class Directory{
        private String name;
        private long size;
        private Directory parent;
        private ArrayList <Directory> subdirs;
        public ArrayList <String> files;

        public Directory(String name){
            size = 0;
            this.name = name;
            parent = null;
            subdirs = new ArrayList <Directory>();
            files = new ArrayList <String>();
        }
    }

    public FileSystem(){
        root = new Directory("/");
        curr = root;
    }

    public Directory getRoot(){
        return root;
    }

    public long getRootSize(){
        return root.size;
    }

    public void cd (String name){
        if (name.equals("..")){
            if (curr.parent != null) curr = curr.parent;
        } else {
            for (Directory d : curr.subdirs){
                if (d.name.equals(name)){
                    curr = d;
                }
            }
        }
    }

    public void mkdir (String name){
        for (Directory d : curr.subdirs){
            if (d.name.equals(name)) return;
        }
        Directory d = new Directory(name);
        d.parent = curr;
        curr.subdirs.add(d);
    }

    public void touch (long size, String name){
        for (String s : curr.files){
            if (s.equals(name)) return;
        }
        curr.files.add(name);
        curr.size += size;
        Directory p = curr.parent;
        while (p != null){
            p.size += size;
            p = p.parent;
        }
    }

    public long getAns (long lessThan, Directory dir){
        long ans = 0;
        if (dir.size <= lessThan) ans += dir.size;
        for (Directory d : dir.subdirs){
            ans += getAns(lessThan, d);
        }
        return ans;
    }

    public long getAns2 (long moreThan, Directory dir){
        long ans = Long.MAX_VALUE;
        if (dir.size >= moreThan) ans = dir.size;
        for (Directory d : dir.subdirs){
            ans = Math.min(ans, getAns2(moreThan, d));
        }
        return ans;
    }

    public void print (Directory dir, PrintWriter out, int level){
        if (dir == null) return;
        String s = "";
        for (int i = 0; i < level; i++) s += " ";
        out.println(s + dir.name + " " + dir.size);
        for (Directory d : dir.subdirs){
            print(d, out, level + 1);
        }
    }
}