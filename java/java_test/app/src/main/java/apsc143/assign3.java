package apsc143;

public class assign3 {
    public static void main(){
        System.out.println("Enter a time in seconds: ");
        String sysread = "3.2";//System.console().readLine();
        double t = Double.parseDouble(sysread);
        double Vi = 8* Math.cos(Math.PI *t);
        System.out.printf("Time: %f Voltage: %f\n", t, Vi);
    }
}
