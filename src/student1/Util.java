package student1;

public class Util {
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


}
