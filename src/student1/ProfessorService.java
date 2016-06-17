package student1;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;


public class ProfessorService {
	public static Professor makeProfessor(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        Professor professor = new Professor();
        
        String s = request.getParameter("id");
        int id = Util.parseInt(s, 0);
        professor.setId(id);
        
        s = request.getParameter("name");
        if (s == null) s = "";
        professor.setName(s);
        
        s = request.getParameter("departmentId");
        int departmentId = Util.parseInt(s, 0);
        professor.setDepartmentId(departmentId);
        
       
        
        return professor;
    }
    
    public static Professor makeProfessor() {
        Professor professor = new Professor();
        professor.setId(0);
        professor.setName("");
        return professor;
    }
    
    public static String validateBeforeInsert(Professor professor) throws Exception {
        int s = professor.getId();
        if (Util2.isEmptyOrNull2(s)) 
            return "학번을 입력하세요.";
        String s2;
        s2 = professor.getName();
        if (Util2.isEmptyOrNull(s2)) 
            return "이름을 입력하세요.";

      
        Professor professor2 = ProfessorDAO.selectById(s);
        if (professor2 != null)
            return "학번이 중복됩니다.";

        return null;
    }

    public static String validateBeforeUpdate(Professor professor) throws Exception {
    	 int s = professor.getId();
         if (Util2.isEmptyOrNull2(s)) 
             return "학번을 입력하세요.";
         String s2;
         s2 = professor.getName();
         if (Util2.isEmptyOrNull(s2)) 
             return "이름을 입력하세요.";
       
         Professor professor2 = ProfessorDAO.selectById(s);
        if (professor2 != null && professor2.getId() != professor2.getId())
            return "학번이 중복됩니다.";

        return null;
    }


}
