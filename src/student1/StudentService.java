package student1;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;

public class StudentService {
    
    public static Student makeStudent(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        Student student = new Student();
        
        String s = request.getParameter("id");
        int id = Util.parseInt(s, 0);
        student.setId(id);
        
        s = request.getParameter("studentNumber");
        if (s == null) s = "";
        student.setStudentNumber(s);
        
        s = request.getParameter("studentName");
        if (s == null) s = "";
        student.setStudentName(s);
        
        s = request.getParameter("departmentId");
        int departmentId = Util.parseInt(s, 0);
        student.setDepartmentId(departmentId);
        
        s = request.getParameter("year");
        int year = Util.parseInt(s, 0);
        student.setYear(year);
        
        return student;
    }
    
    public static Student makeStudent() {
        Student student = new Student();
        student.setStudentNumber("");
        student.setStudentName("");
        return student;
    }
    
    public static String validateBeforeInsert(Student student) throws Exception {
        String s = student.getStudentNumber();
        if (Util.isEmptyOrNull(s)) 
            return "학번을 입력하세요.";

        s = student.getStudentName();
        if (Util.isEmptyOrNull(s)) 
            return "이름을 입력하세요.";

        s = student.getStudentNumber();
        Student student2 = StudentDAO.selectByStudentNumber(s);
        if (student2 != null)
            return "학번이 중복됩니다.";

        return null;
    }

    public static String validateBeforeUpdate(Student student) throws Exception {
        String s = student.getStudentNumber();
        if (Util.isEmptyOrNull(s)) 
            return "학번을 입력하세요.";

        s = student.getStudentName();
        if (Util.isEmptyOrNull(s)) 
            return "이름을 입력하세요.";

        s = student.getStudentNumber();
        Student student2 = StudentDAO.selectByStudentNumber(s);
        if (student2 != null && student.getId() != student2.getId())
            return "학번이 중복됩니다.";

        return null;
    }
}
