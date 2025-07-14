import java.util.*;

public class CHECK {
    public static void main(String[] args) {
        Scanner in =new Scanner(System.in);
        String []res1=new String[40];
        String []res2=new String[41];
        for(int i=0;i<40;i++){
            res1[i]=in.nextLine();
        }
        for(int i=0;i<41;i++){
            res2[i]=in.nextLine();
        }
        Arrays.sort(res1);
        Arrays.sort(res2);
        // for(String s:res1)System.out.println(s);
        // for(String s:res2)System.out.println(s);
        System.out.println(Arrays.toString(res1));
        System.out.println(Arrays.toString(res2));
    }
}



