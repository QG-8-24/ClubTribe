package clubtribe.test;

import clubtribe.dao.ClubMapper;
import clubtribe.dao.UserMapper;
import clubtribe.pojo.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.*;
import java.util.ArrayList;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/applicationContext-dao.xml")
public class ManagerTest {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ClubMapper clubsMapper;

    @Test
    public void test() {
        User user = new User();
        user.setUserid(870830369);
        user.setClubids("@824");
        userMapper.joinclub(user);
        if (clubsMapper.getmsg(824) == null || clubsMapper.getmsg(824).length() == 0) {
            System.out.println("11");
        }

    }

    @Test
    public void test1() throws IOException {
        String filename = "D:/clubtribemsg/msg" + 824 + ".txt";
//        System.out.println(filename);
        File file = new File(filename);
        if (!file.exists()) {
            file.createNewFile();
            System.out.println(file.toString());
        }
    }

    @Test
    public void test2() throws IOException, ClassNotFoundException {
        String filepath = "D:/clubtribemsg/msg" + "824" + ".txt";
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filepath));
//        try {
            ArrayList<String>list= (ArrayList<String>) ois.readObject();
//        }catch (Exception e){
////            System.out.println("sajh");
////        }
        for(String it:list){
            System.out.println(it);
        }
        ois.close();

    }

}
