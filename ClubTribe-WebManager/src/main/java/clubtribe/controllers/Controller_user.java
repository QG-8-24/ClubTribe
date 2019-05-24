package clubtribe.controllers;

import clubtribe.pojo.Club;
import clubtribe.pojo.ClubMember;
import clubtribe.services.ClubMemberServices;
import clubtribe.services.ClubServices;
import clubtribe.services.UserServices;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

@Controller
@RequestMapping("user")
public class Controller_user {

    @Autowired
    private ClubServices clubsServices;
    @Autowired
    private UserServices userServices;
    @Autowired
    private ClubMemberServices clubMemberServices;

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
     *
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
        //规定最多五个clubid7
        if (clubids.length >= 5) {
            str = "加入失败 每个用户最多加入5个社团";
        } else {
            if (Arrays.asList(clubids).contains(clubid)) {
                str = "你已是该社团成员 无需再次擦操作！";
            } else {
                if (clubsServices.getmsg(Integer.parseInt(clubid)) == null || clubsServices.getmsg(Integer.parseInt(clubid)).length() == 0) {
                    String filename = "D:/clubtribefile/clubmsg/msg" + clubid + ".txt";
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

    /**
     * 判断是否为管理员
     *
     * @param userid
     * @param clubid
     * @return
     */
    @RequestMapping("ifadmin")
    @ResponseBody
    public String ifadmin(String userid, String clubid) {
        String[] admin = clubsServices.getadmin(Integer.parseInt(clubid)).split("@");
        if (Arrays.asList(admin).contains(userid)) {
            return "true";
        }
        return "false";
    }

    /**
     * 进入管理员页面
     *
     * @param userid
     * @param clubid
     * @return
     * @throws IOException
     */
    @RequestMapping("interadmin")
    public ModelAndView interadmin(String userid, String clubid) throws IOException {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("userid", userid);
        modelAndView.addObject("clubid", clubid);
        modelAndView.setViewName("clubadmin");
        return modelAndView;
    }

    /**
     * 社团成员签到
     *
     * @param userid
     * @param clubid
     * @return
     */
    @RequestMapping(value = "sign", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String sign(String userid, String clubid) {
        String flag = "签到失败 仅限社员";
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String[] clubids = userServices.getuserclubs(Integer.parseInt(userid)).split("@");
        if (Arrays.asList(clubids).contains(clubid)) {
            ClubMember clubMember = new ClubMember();
            clubMember.setClubid(clubid);
            clubMember.setUserid(userid);
            String signtime = clubMemberServices.getsigntime(clubMember);
            if (signtime.length() == 0 || signtime == null) {
                String time = df.format(new Date());
                clubMember.setSign(time);
                if (clubMemberServices.sign(clubMember) != 0) {
                    flag = "签到成功";
                }
            } else {
                flag = "你今日已经签到过";
            }
        }
        return flag;
    }

    @RequestMapping(value = "getsignmsg")
    @ResponseBody
    public String getsignmsg(String clubid) throws ParseException, JsonProcessingException {
        ClubMember[] list = clubMemberServices.getsignmsg(clubid);
        ClubMember tep = new ClubMember();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (int i = 0; i < list.length; i++) {
            for (int j = i + 1; j < list.length; j++) {
                Date date1 = sdf.parse(list[i].getSign());
                Date date2 = sdf.parse(list[j].getSign());
                if (date1.compareTo(date2) > 0) {
                    tep = list[i];
                    list[i] = list[j];
                    list[j] = tep;
                }
            }
        }
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(list);
    }
}
