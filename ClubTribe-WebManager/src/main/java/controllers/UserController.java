package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("test")
public class UserController {

    @RequestMapping("test1")
    public ModelAndView show(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("clubhome");
        System.out.println("123");
        return modelAndView;
    }

}
