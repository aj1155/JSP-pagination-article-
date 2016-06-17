package student1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StudentDAO {
    
    private static Student makeStudent(ResultSet resultSet, boolean hasDepartName) throws SQLException {
        Student student = new Student();
        student.setId(resultSet.getInt("id"));
        student.setStudentNumber(resultSet.getString("studentNumber"));
        student.setStudentName(resultSet.getString("studentName"));
        student.setDepartmentId(resultSet.getInt("departmentId"));
        if (hasDepartName)
            student.setDepartmentName(resultSet.getString("departmentName"));        
        student.setYear(resultSet.getInt("year"));
        return student;
    }

    public static Student selectById(int id) throws Exception {
        Student user = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;        
        try {
            connection = DB.getConnection();
            String sql = "SELECT * FROM [Student] WHERE [id] = ?"; 
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) user = makeStudent(resultSet, false);
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return user;
    }
    
    public static Student selectByStudentNumber(String studentNumber) throws Exception {
        Student user = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;        
        try {
            connection = DB.getConnection();
            String sql = "SELECT * FROM [Student] WHERE [studentnumber] = ?"; 
            statement = connection.prepareStatement(sql);
            statement.setString(1, studentNumber);
            resultSet = statement.executeQuery();
            if (resultSet.next()) user = makeStudent(resultSet, false);
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return user;
    }
    
    public static ArrayList<Student> selectPage(int currentPage, int pageSize) throws Exception {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DB.getConnection();
            String sql = "EXEC studentSelectPage ?, ?"; 
            statement = connection.prepareStatement(sql);
            statement.setInt(1, currentPage);
            statement.setInt(2, pageSize);
            resultSet = statement.executeQuery();
            ArrayList<Student> list = new ArrayList<Student>();
            while (resultSet.next())
                list.add(makeStudent(resultSet, true));
            return list;
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }        
    }
    
    public static int getRecordCount() throws Exception {
        int count = 0;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;        
        try {
            connection = DB.getConnection();
            String sql = "SELECT COUNT(*) FROM [Student]"; 
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            if (resultSet.next()) 
                count = resultSet.getInt(1);
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return count;
    }    
    
    public static void insert(Student student) throws Exception {
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = DB.getConnection();
            String sql = "INSERT [Student] ([studentNumber], [studentName], [departmentId], [year]) VALUES (?, ?, ?, ?)"; 
            statement = connection.prepareStatement(sql);
            statement.setString(1, student.getStudentNumber());
            statement.setString(2, student.getStudentName());
            statement.setInt(3, student.getDepartmentId());
            statement.setInt(4, student.getYear());
            statement.executeUpdate();
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }
    
    public static void update(Student student) throws Exception {
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = DB.getConnection();
            String sql = "UPDATE [Student] SET [studentNumber] = ?, [studentName] = ?, [departmentId] = ?, [year] = ? WHERE [id] = ?"; 
            statement = connection.prepareStatement(sql);
            statement.setString(1, student.getStudentNumber());
            statement.setString(2, student.getStudentName());
            statement.setInt(3, student.getDepartmentId());
            statement.setInt(4, student.getYear());
            statement.setInt(5, student.getId());
            statement.executeUpdate();
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }     

    public static void delete(int id) throws Exception {
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = DB.getConnection();
            String sql = "DELETE FROM [Student] WHERE [id] = ?"; 
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }     
    
}
