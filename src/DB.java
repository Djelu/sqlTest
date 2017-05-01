import java.sql.*;

public class DB {
    static DB db;
    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;
    final int COLUMNS_WIDTH = 15;

    public static void main(String[] args){
        db = new DB();
        db.connect();
        for(int i = 1; i<=5; i++) db.tasksExecution(i);
        db.disconnect();
    }

    private void disconnect(){
        try {
            resultSet.close();
            statement.close();
            connection.close();

        }catch (SQLException e) {e.printStackTrace();}
    }

    void connect(){
        try {
            Class.forName("org.sqlite.JDBC");
            String currentDir = System.getProperty("user.dir");
            connection = DriverManager.getConnection("jdbc:sqlite:"+currentDir+"\\db.s3db");

        } catch (SQLException | ClassNotFoundException e) {e.printStackTrace();}
    }

    void tasksExecution(int num){
        try {
            statement = connection.createStatement();
            switch (num){
                case 1:{
                    //1)Вывести фамилии всех сотрудников и отделы в которых они работают.
                    resultSet = statement.executeQuery(
                        "SELECT EMP.ENAME,DEPT.DNAME    \n"+
                        "FROM   EMP,DEPT                \n"+
                        "WHERE  EMP.DEPTNO=DEPT.DEPTNO;"
                    );
                }break;
                case 2:{
                    //2)Вывести фамилии, должности и зарплаты сотрудников, которым не положены комисcионные.
                    resultSet = statement.executeQuery(
                        "SELECT ENAME, JOB, SAL \n"+
                        "FROM EMP               \n"+
                        "WHERE COMM IS NULL;"
                    );
                }break;
                case 3:{
                    //3)Вывести количество сотрудников и среднюю зарплату в 20 отделе.
                    resultSet = statement.executeQuery(
                        "SELECT count(ENAME) AS EMP_COUNT, avg(SAL) AS SAL_AVG  \n"+
                        "FROM EMP                                               \n"+
                        "WHERE DEPTNO=20;"
                    );
                }break;
                case 4:{
                    //4)Вывести отделы в которых больше 3-х сотрудников.
                    ////Посчитать количество сотрудников в таких отделах.
                    resultSet = statement.executeQuery(
                        "SELECT DEPT.DNAME, count(EMP.DEPTNO) AS DNAME_COUNT    \n"+
                        "FROM EMP,DEPT                                          \n"+
                        "WHERE EMP.DEPTNO=DEPT.DEPTNO                           \n"+
                        "GROUP BY DEPT.DNAME                                    \n"+
                        "HAVING count(EMP.DEPTNO)>3;"
                    );
                }break;
                case 5:{
                    //5)Выведите фамилии сотрудников, название их отделов,
                    //города расположения отделов, зарплату сотрудников и уровень их зарплаты.
                    //Отсортировать результат в порядке возрастания уровня зарплаты,
                    //если уровень зарплаты совпадает, то по зарплате.
                    resultSet = statement.executeQuery(
                        "SELECT EMP.ENAME,DEPT.DNAME,DEPT.LOC,EMP.SAL,t.grade AS GRADE                  \n"+
                        "FROM EMP,DEPT,(SELECT EMP.SAL AS sal,SALGRADE.GRADE AS grade                   \n"+
                        "               FROM EMP,SALGRADE                                               \n"+
                        "               WHERE EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL) AS t   \n"+
                        "WHERE EMP.DEPTNO=DEPT.DEPTNO AND EMP.SAL=t.sal                                 \n"+
                        "GROUP BY EMP.ENAME,DEPT.DNAME,DEPT.LOC,EMP.SAL,GRADE                           \n"+
                        "ORDER BY GRADE ASC, EMP.SAL ASC"
                    );
                }break;
            }
            if (resultSet!=null) printResult(resultSet,num);

        } catch (SQLException e) { e.printStackTrace();}
    }

    private void printResult(ResultSet resultSet, int taskNum) throws SQLException {
        ResultSetMetaData resultSetMetaData = resultSet.getMetaData();

        int colsCount = resultSetMetaData.getColumnCount();
        int[] colsTypes = new int[colsCount];
        StringBuilder sb = new StringBuilder();
        sb.append("Task number ").append(taskNum).append(":\n\n");

        for(int i=0; i<colsCount; i++){
            sb.append(normalize(resultSetMetaData.getColumnName(i+1),COLUMNS_WIDTH));//приводя к выбранной ширине, записываем имена столбцов
            colsTypes[i] = resultSetMetaData.getColumnType(i+1);
        }
        sb.append("\n");

        for(int i=0; i<colsCount*COLUMNS_WIDTH; i++) sb.append("-");
        sb.append("\n");

        while (resultSet.next()){
            //записываем строки
            for(int i=0,intCell; i<colsCount; i++){
                String sCell = "";
                switch (colsTypes[i]){
                    case 4:{//INTEGER
                        intCell= resultSet.getInt(i+1);
                        sCell = resultSet.wasNull() ?"NULL" :String.valueOf(intCell);
                    }break;
                    case 12:{//VARCHAR
                        sCell = resultSet.getString(i+1);
                        if(resultSet.wasNull()) sCell = "NULL";
                    }break;
                    case 91:{//DATE
                        sCell = resultSet.getString(i+1);
                        if(resultSet.wasNull()) sCell = "NULL";
                    }break;
                }
                sb.append(normalize(sCell,COLUMNS_WIDTH));//приводим к выбранной ширине
            }
            sb.append("\n");
        }
        sb.append("\n");
        System.out.println(sb.toString());
    }

    private String normalize(String string, int n){
        int ln = string.length();
        int newLn = ln<=n ?n :ln;
        int q1 = (newLn-ln)/2;
        int q2 = newLn-q1-ln;
        StringBuilder sb1 = new StringBuilder();
        StringBuilder sb2;
        for(int i=0; i<q1; i++) sb1.append(" ");
        if(q1==q2)
            sb2 = sb1;
        else{
            sb2 = new StringBuilder();
            for(int i=0; i<q2; i++) sb2.append(" ");
        }
        return sb1.toString() + string + sb2.toString();
    }
}
