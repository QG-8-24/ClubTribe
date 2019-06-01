package clubtribe.test;

import clubtribe.dao.ClubMapper;
import clubtribe.dao.ClubMemberMapper;
import clubtribe.dao.UserMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.IOException;
import java.util.ArrayList;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/applicationContext-dao.xml")
public class ManagerTest {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ClubMapper clubsMapper;
    @Autowired
    private ClubMemberMapper clubMemberMapper;

    @Test
    public void test() {
//        if(userMapper.getuserclubs(111111111)==null){
//            System.out.println(userMapper.getuserclubs(870830369).split("@").length);
//            System.out.println("sfa");
//        }
        String[] clubids = new String[0];
        System.out.println(clubids.length);
    }

    @Test
    public void test1() throws IOException {
        ArrayList<String> list = new ArrayList<>();
        list.add("<li>1<br>2019-06-01 11:42:25<span class=\"removenotice\">×</span></li>");
        list.add("<li>2<br>2019-06-01 11:54:02<span class=\"removenotice\">×</span></li>)");
        for (String it:list){
            System.out.println(it);
        }
        list.remove("<li>2<br>2019-06-01 11:54:02<span class=\"removenotice\">×</span></li>)");
        for (String it:list){
            System.out.println(it);
        }
    }

    @Test
    public void test2() throws IOException, ClassNotFoundException {

    }
}

