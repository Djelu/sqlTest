import java.sql.*;

public class DB {
    static DB db;
    Connection connection;
    Statement statement;
    ResultSet resultSet;

    public static void main(String[] args){
        db = new DB();
        try{
        db.connect();
        }catch (ClassNotFoundException|SQLException e) { e.printStackTrace();}


    }

    void connect() throws ClassNotFoundException, SQLException {
        Class.forName("org.sqlite.JDBC");
        connection = DriverManager.getConnection("jdbc:sqlite:F:/programming/db/sqlite/db.s3db");
    }
}
