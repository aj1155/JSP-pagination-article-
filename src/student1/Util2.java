package student1;

public class Util2 {
	public static int parseInt(String s, int defaultValue) {
        try { 
            return Integer.parseInt(s); 
        } catch (Exception e) {             
            return defaultValue;
        }
    }
    
    public static boolean isEmptyOrNull(String s) {
        return s == null || s.isEmpty();
    }
    public static boolean isEmptyOrNull2(int s) {
        return s == 0;
    }
    
}
