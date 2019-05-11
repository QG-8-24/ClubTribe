package clubtribe.controllers;

import clubtribe.services.ClubsServices;
import clubtribe.services.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

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

    @RequestMapping(value = "logout")
    public String logout(HttpSession session) {
        return "redirect:clubhome";
    }
}
