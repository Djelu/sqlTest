import java.io.IOException;
import java.util.Properties;

public class CreateConsole {
 
    public static void main(String[] args) throws IOException {
        Properties prop = System.getProperties();
        ProcessBuilder pb;
        if ("Linux".equals(prop.getProperty("os.name"))) {
            pb = new ProcessBuilder("xterm");
        } else {
            pb = new ProcessBuilder("cmd");
        }
        pb.start();
    }
 
}