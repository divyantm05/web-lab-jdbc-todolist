package com.db;

import java.sql.*;

public class DBConnector {
    private Connection connection;
    private PreparedStatement statement;
    
    public DBConnector() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/myschema", "root", "13071977@edm");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public boolean insert(String task) throws SQLException {
        statement = connection.prepareStatement("INSERT INTO tasks(task) VALUES(?);");
        statement.setString(1, task);
        int rows = statement.executeUpdate(); 
        return rows > 0;
    }

    public boolean remove(int id) throws SQLException {
        statement = connection.prepareStatement("DELETE FROM tasks WHERE id=?;");
        statement.setInt(1, id);
        int rows = statement.executeUpdate();
        return rows > 0;
    }

    public ResultSet getRecords() throws SQLException {
        return connection.createStatement().executeQuery("SELECT * FROM tasks");
    }
}
