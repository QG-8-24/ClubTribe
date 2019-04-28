package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("user")
public class UserController {

    @RequestMapping("clubhome")
    public ModelAndView test(String userid,String clubid){
        System.out.println(userid + "+++++" + clubid);
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("clubhome");
        modelAndView.addObject("userid",userid);
        modelAndView.addObject("cludid",clubid);
        return modelAndView;
    }
}
