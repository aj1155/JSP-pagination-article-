package student1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProfessorDAO 
{
	 private static Professor makeProfessor(ResultSet resultSet, boolean hasDepartName) throws SQLException {
	        Professor professor = new Professor();
	        professor.setId(resultSet.getInt("id"));
	        professor.setName(resultSet.getString("professorName"));
	        professor.setDepartmentId(resultSet.getInt("departmentId"));
	        if (hasDepartName)
	            professor.setDepartmentName(resultSet.getString("departmentName"));        
	
	        return professor;
	    }

	    public static Professor selectById(int id) throws Exception {
	        Professor user = null;
	        Connection connection = null;
	        PreparedStatement statement = null;
	        ResultSet resultSet = null;        
	        try {
	            connection = DB.getConnection();
	            String sql = "SELECT * FROM [Professor] WHERE [id] = ?"; 
	            statement = connection.prepareStatement(sql);
	            statement.setInt(1, id);
	            resultSet = statement.executeQuery();
	            if (resultSet.next()) user = makeProfessor(resultSet, false);
	        } finally {
	            if (resultSet != null) resultSet.close();
	            if (statement != null) statement.close();
	            if (connection != null) connection.close();
	        }
	        return user;
	    }
	    
	    public static ArrayList<Professor> selectPage(int currentPage, int pageSize) throws Exception {
	        Connection connection = null;
	        PreparedStatement statement = null;
	        ResultSet resultSet = null;
	        try {
	            connection = DB.getConnection();
	            String sql = "EXEC professorSelectPage ?, ?"; 
	            statement = connection.prepareStatement(sql);
	            statement.setInt(1, currentPage);
	            statement.setInt(2, pageSize);
	            resultSet = statement.executeQuery();
	            ArrayList<Professor> list = new ArrayList<Professor>();
	            while (resultSet.next())
	                list.add(makeProfessor(resultSet, true));
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
	            String sql = "SELECT COUNT(*) FROM [Professor]"; 
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
	    
	    public static void insert(Professor professor) throws Exception {
	        Connection connection = null;
	        PreparedStatement statement = null;
	        try {
	            connection = DB.getConnection();
	            String sql = "set identity_insert Professor on INSERT [Professor] ([id], [professorName], [departmentId]) VALUES (?, ?, ?)"; 
	            statement = connection.prepareStatement(sql);
	            statement.setInt(1, professor.getId());
	            statement.setString(2, professor.getName());
	            statement.setInt(3, professor.getDepartmentId());
	            
	            statement.executeUpdate();
	        } finally {
	            if (statement != null) statement.close();
	            if (connection != null) connection.close();
	        }
	    }
	    
	    public static void update(Professor professor) throws Exception {
	        Connection connection = null;
	        PreparedStatement statement = null;
	        try {
	            connection = DB.getConnection();
	            String sql = "UPDATE [PROFESSOR] SET [id] = ?, [professorName] = ?, [departmentId] = ? WHERE [id] = ?"; 
	            statement = connection.prepareStatement(sql);
	            statement.setInt(1, professor.getId());
	            statement.setString(2, professor.getName());
	            statement.setInt(3, professor.getDepartmentId());
	            
	            statement.setInt(4, professor.getId());
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
	            String sql = "DELETE FROM [Professor] WHERE [id] = ?"; 
	            statement = connection.prepareStatement(sql);
	            statement.setInt(1, id);
	            statement.executeUpdate();
	        } finally {
	            if (statement != null) statement.close();
	            if (connection != null) connection.close();
	        }
	    }     
}
