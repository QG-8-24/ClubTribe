package clubtribe.controllers;

import clubtribe.pojo.Club;
import clubtribe.services.ClubServices;
import clubtribe.services.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;

@Controller
@RequestMapping("user")
public class Controller_MQ {

    @Autowired
    private ClubServices clubsServices;
    @Autowired
    private UserServices userServices;

    /**
     * 登录进入社团主页
     *
     * @param userid
     * @param clubid
     * @return
     */
    @RequestMapping("clubhome")
    public ModelAndView inter(String userid, String clubid) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("clubhome");
        modelAndView.addObject("userid", userid);
        modelAndView.addObject("clubid", clubid);
        return modelAndView;
    }

    /**
     * 根据id获取name init
     *
     * @param userid
     * @param clubid
     * @return
     */
    @RequestMapping(value = "init", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String getinfo(String userid, String clubid) {
        String username = null;
        String clubname = null;
        if (!"".equals(userid)) {
            username = userServices.findnamebyid(Integer.parseInt(userid));
        }
        if (!"".equals(clubid)) {
            clubname = clubsServices.findnamebyid(Integer.parseInt(clubid));
        }
        return username + "@" + clubname;
    }

    /**
     * 加入社团申请
     * @param userid
     * @param clubid
     * @return
     * @throws IOException
     * @throws ClassNotFoundException
     */
    @RequestMapping(value = "joinapply", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String join(String userid, String clubid) throws IOException, ClassNotFoundException {
        String str = "加入失败";
        String[] clubids = new String[0];
        if (userServices.getuserclubs(Integer.parseInt(userid)) != null) {
            clubids = userServices.getuserclubs(Integer.parseInt(userid)).split("@");
        }
        //规定最多五个clubid
        if (clubids.length >= 5) {
            str = "加入失败 每个用户最多加入5个社团";
        } else {
            if (Arrays.asList(clubids).contains(clubid)) {
                str = "你已是该社团成员 无需再次擦操作！";
            } else {
                if (clubsServices.getmsg(Integer.parseInt(clubid)) == null || clubsServices.getmsg(Integer.parseInt(clubid)).length() == 0) {
                    String filename = "D:/clubtribe/clubmsg/msg" + clubid + ".txt";
                    File file = new File(filename);
                    if (!file.exists()) {
                        file.createNewFile();
                        Club club = new Club();
                        club.setClubid(clubid);
                        club.setMsg(file.toString());
                        clubsServices.initmsg(club);
                        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filename));
                        ArrayList<String> list = new ArrayList<>();
                        oos.writeObject(list);
                        oos.close();
                    }
                }
                String filepath = clubsServices.getmsg(Integer.parseInt(clubid));
                ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filepath));
                ArrayList<String> list = (ArrayList<String>) ois.readObject();
                ois.close();
                if (list.contains(userid)) {
                    str = "你已发送过加入申请 不能重复申请 亲耐心等待审核";
                } else {
                    ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filepath));
                    list.add(userid);
                    oos.writeObject(list);
                    oos.close();
                    str = "加入申请已发送!";
                }
            }
        }
        return str;
    }

    @RequestMapping("ifadmin")
    @ResponseBody
    public String ifadmin(String userid, String clubid) {
        String[] admin = clubsServices.getadmin(Integer.parseInt(clubid)).split("@");
        if (Arrays.asList(admin).contains(userid)) {
            return "true";
        }
        return "false";
    }

    @RequestMapping("interadmin")
    public ModelAndView interadmin(String userid, String clubid) throws IOException {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("userid", userid);
        modelAndView.addObject("clubid", clubid);
        modelAndView.setViewName("clubadmin");
        return modelAndView;
    }
}
