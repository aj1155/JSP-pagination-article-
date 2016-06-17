package student1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDAO {
    private static Department makeDepartment(ResultSet resultSet) throws SQLException {
        Department department = new Department();
        department.setId(resultSet.getInt("id"));
        department.setDepartmentName(resultSet.getString("departmentName"));
        return department;
    }

    public static List<Department> selectAll() throws Exception {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;        
        try {
            connection = DB.getConnection();
            String sql = "SELECT * FROM [Department]"; 
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            ArrayList<Department> list = new ArrayList<Department>();            
            while (resultSet.next()) 
                list.add(makeDepartment(resultSet));
            return list;            
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }
}
