package clubtribe.controllers;

import clubtribe.pojo.ClubMember;
import clubtribe.pojo.User;
import clubtribe.services.ClubMemberServices;
import clubtribe.services.ClubServices;
import clubtribe.services.UserServices;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.util.ArrayList;

@Controller
@RequestMapping("admin")
public class Controller_admin {

    @Autowired
    private ClubServices clubServices;
    @Autowired
    private ClubMemberServices clubMemberServices;
    @Autowired
    private UserServices userServices;

    /**
     * 获取社团通知
     *
     * @param clubid
     * @return
     * @throws IOException
     * @throws ClassNotFoundException
     */
    @RequestMapping("getmsg")
    @ResponseBody
    public String getmsg(String clubid, String userid) throws IOException, ClassNotFoundException {
        String filepath = clubServices.getmsg(Integer.parseInt(clubid));
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filepath));
        ArrayList<String> list = (ArrayList<String>) ois.readObject();
        ObjectMapper mapper = new ObjectMapper();
        ois.close();
        return mapper.writeValueAsString(list);
    }

    @RequestMapping("agree")
    @ResponseBody
    public String agree(String clubid, String userid) {
        String filepath = clubServices.getmsg(Integer.parseInt(clubid));
        String str = "false";
        ClubMember clubMember = new ClubMember();
        clubMember.setClubname(clubid);
        clubMember.setUserid(userid);
        clubMember.setSign("");
        clubMember.setMsign("");
        try {
            int flag = clubMemberServices.insert(clubMember);
            if (flag != 0) {
                str = "true";
                ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filepath));
                ArrayList<String> list = (ArrayList<String>) ois.readObject();
                list.remove(userid);
                ois.close();
                ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filepath));
                oos.writeObject(list);
                oos.close();
                String clubids=userServices.getuserclubs(Integer.parseInt(userid));
                clubids=clubids+"@"+clubid;
                User user=new User();
                user.setUserid(Integer.parseInt(userid));
                user.setClubids(clubids);
                userServices.joinclub(user);
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            return str;
        }
    }

    @RequestMapping("reject")
    @ResponseBody
    public String reject(String clubid, String userid) throws IOException, ClassNotFoundException {
        String str = "false";
        String filepath = clubServices.getmsg(Integer.parseInt(clubid));
        try {
            ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filepath));
            ArrayList<String> list = (ArrayList<String>) ois.readObject();
            list.remove(userid);
            ois.close();
            ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filepath));
            oos.writeObject(list);
            oos.close();
            str = "true";
        } catch (Exception e) {
            System.out.println(e);
        }
        return str;
    }
}
