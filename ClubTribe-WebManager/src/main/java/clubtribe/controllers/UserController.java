package clubtribe.controllers;

import clubtribe.services.ClubsServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private ClubsServices clubsServices;

    @RequestMapping("clubhome")
    public ModelAndView test(String userid, String clubid) {
        System.out.println(userid + "+++++" + clubid);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("clubhome");
        modelAndView.addObject("userid", userid);
        modelAndView.addObject("clubid", clubid);
        return modelAndView;
    }

    @RequestMapping(value = "getclubname", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String test(String clubid) {
       String clubname=clubsServices.findnamebyid(Integer.parseInt(clubid));
        System.out.println(clubname);
        return clubname;
    }
}
