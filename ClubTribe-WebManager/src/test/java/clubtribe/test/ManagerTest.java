package clubtribe.test;

import clubtribe.dao.ClubMapper;
import clubtribe.dao.ClubMemberMapper;
import clubtribe.dao.UserMapper;
import clubtribe.pojo.ClubMember;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.File;
import java.io.IOException;

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
        ClubMember clubMember=new ClubMember();
        clubMember.setClubname("824");
        clubMember.setUserid("870830369");
        System.out.println(clubMemberMapper.getsigntime(clubMember));
    }
}

