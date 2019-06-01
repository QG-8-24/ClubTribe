package clubtribe.controllers;

import clubtribe.services.ClubSearchServices_CJN;
import clubtribe.services.ClubTribeAdminServices_CJN;
import clubtribe.services.UserServices_TYC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("clubtribeadmin")
public class ClubTribeAdminController_CJN {

    @Autowired
    private UserServices_TYC userServicesTYC;

    @Autowired
    private ClubTribeAdminServices_CJN clubTribeAdminServices_cjn;

    @Autowired
    private ClubSearchServices_CJN clubSearchServices_cjn;

    /**
     * 跳转到登录页面
     * @return
     */

    @RequestMapping(value = "toLogin")
    public ModelAndView toLoginPage(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("adminlogin_CJN");
        return modelAndView;
    }

    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     */
    @RequestMapping(value="adminLogin", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String login(String username,String password){
        String userid= userServicesTYC.userLogin(username,password);
        String admin=clubTribeAdminServices_cjn.checkAdmin(userid);
        if(userid!= null&&admin.equals("1")){
            System.out.println(userid+"@"+admin);
            return userid+"@"+admin;
        }
        return "false";
    }
    /**
     * 进入管理员页面
     * @param userid
     * @param admin
     * @return
     */
    @RequestMapping(value="intoAdmin", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public ModelAndView intoAdmin(String userid,String admin){
        ModelAndView modelAndView = new ModelAndView();
        String username = clubSearchServices_cjn.getUsername(userid);
        modelAndView.addObject("userid", userid);
        modelAndView.addObject("username", username);
        modelAndView.addObject("admin", admin);
        modelAndView.setViewName("clubtribeadmin_CJN");
        return modelAndView;
    }
}
