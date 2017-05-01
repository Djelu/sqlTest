public class Main {

    public static void main(String[] args){
        DB db = new DB();
        db.connect();

        //Выполняем задания
        for(int i = 1; i<=5; i++)
            db.tasksExecution(i);

        db.disconnect();
    }
}
