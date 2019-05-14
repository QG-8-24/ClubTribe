package clubtribe.controllers;

import clubtribe.pojo.User;
import clubtribe.services.ClubsServices;
import clubtribe.services.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private ClubsServices clubsServices;
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

    @RequestMapping(value = "join",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String join(String userid, String clubid) {
        String str = "加入失败";
        String clubids = userServices.getclubs(Integer.parseInt(userid));
        String[] strs = clubids.split("@");
        //规定最多五个clubid
        if (strs.length >= 5) {
            str = "加入失败 每个用户最多加入5个社团";
        } else {
            if (Arrays.asList(strs).contains(clubid)) {
                str = "你已是该社团成员 无需再次擦操作！";
            } else {
                clubids = clubids + "@" + clubid;
                User user=new User();
                user.setUserid(Integer.parseInt(userid));
                user.setClubids(clubids);
                userServices.joinclub(user);
                str = "加入成功!";
            }
        }
        return str;
    }
}
