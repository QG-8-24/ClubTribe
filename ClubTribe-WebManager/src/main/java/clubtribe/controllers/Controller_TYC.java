package clubtribe.controllers;

import clubtribe.services.UserServices_TYC;
import commom.MailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("user")
public class Controller_TYC {

    @Autowired
    private UserServices_TYC userServicesTYC;
    @Autowired
    private MailUtil mailUtil;
    @Autowired
    HttpSession session;

    /**
     * 跳转到登录页面
     * @return
     */

    @RequestMapping(value = "toLogin")
    public ModelAndView toLoginPage(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("login");
        return modelAndView;
    }

    /**
     * 跳转到注册页面
     * @return
     */
    @RequestMapping(value = "toRegister")
    public ModelAndView toRegister(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("register");
        return modelAndView;
    }

    /**
     * 跳转到找回密码页面
     * @return
     */
    @RequestMapping(value = "toPassword")
    public ModelAndView toPassword(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("findpassword");
        return modelAndView;
    }
    /**
     * 跳转到找回密码页面
     * @return
     */
    @RequestMapping(value = "toCompusAccr")
    public ModelAndView toCompusAccr(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("compusaccr");
        return modelAndView;
    }
    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     */
    @RequestMapping(value="userLogin",produces = "text/plain")
    @ResponseBody
    public String login(String username,String password){
        String userid= userServicesTYC.userLogin(username,password);
        System.out.println("userid:"+userid);
        if(userid!= null){
            return userid;
        }
        return "false";
    }

    /**
     * 用户注册
     * @param username
     * @param password
     * @param useremail
     * @param vcodeWritted
     * @return
     */
    @RequestMapping(value = "userRegister")
    @ResponseBody
    public String userRegister(String username,String password,String useremail,String vcodeWritted) {

        if(!vcodeWritted.trim().equals(session.getAttribute("vcode"))){
            System.out.println("vcode:"+session.getAttribute("vcode"));
            System.out.println("vcodew:"+vcodeWritted);
            System.out.println("相等？"+(vcodeWritted.trim() !=  session.getAttribute("vcode")));
            return "false";
        }
        Map<String,String> usermap=new HashMap<>();
        usermap.put("username",username);
        usermap.put("password",password);
        usermap.put("useremail",useremail);
        Integer id= userServicesTYC.userRegister(usermap);
        System.out.println("id:"+id);
        if(id!=null){
            return "true";
        }else{
            return "false";
        }
    }

    /**
     * 验证注册邮箱,发送随机验证码
     * @param useremail
     * @return
     */
    @RequestMapping(value = "VMailBox")
    @ResponseBody
    public String validation_code(String useremail){
        String code=String.valueOf((int)(Math.random()*9000+1000));
        Integer status=mailUtil.send(useremail,"clubtribe验证码",code);
        System.out.println("code:"+code);
        session.setAttribute("vcode",code);
        if(status!=null){
            return code;
        }else{
            return null;
        }
    }

    /**
     * 登录页面找回密码
     * @param username
     * @return
     */
    @RequestMapping(value = "userFindPassword")
    @ResponseBody
    public String findPassword(String username,String useremail,String code)
    {
        System.out.println("进入findPassword函数");
        String password= userServicesTYC.findPassword(username);
        if(!code.trim().equals(session.getAttribute("vcode"))){
            return "false";
        }
        if(password!=null){
            mailUtil.send(useremail,"找回密码",password);
            return "true";
        }else{
            return "false";
        }
    }

    /**
     * 文件上传
     * @param file
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "fileUpload" ,produces = "text/plain")
    @ResponseBody
    public String fileUpload(@RequestParam("img")MultipartFile file){
        String orignalName=file.getOriginalFilename();
        String realPath="D:\\clubtribefile\\schoolphotos\\";
        String uuidName=UUID.randomUUID().toString();
        String newFilePath=realPath+uuidName+orignalName.substring(orignalName.lastIndexOf("."));
        File newFile=new File(newFilePath);
        try {
            file.transferTo(newFile);
        } catch (IOException e) {
            e.printStackTrace();
            return "error";
        }
        return "http://localhost:8080//schoolphotos//"+uuidName+orignalName.substring(orignalName.lastIndexOf("."));
    }

    /**
     * 学校认证
     * @param schoolname
     * @param schooladress
     * @param
     * @return
     * @throws IOException
     */
    @RequestMapping(value ="schoolAccr")
    @ResponseBody
    public String schoolAccr(String schoolname,String schooladress,String URL) throws IOException {
        String url="D:\\clubtribefile\\schoolfile\\school-accr-info.txt";
        System.out.println("URL:"+URL);
        Integer status;
        Integer id=userServicesTYC.findSchoolId(schoolname,schooladress);
        System.out.println("查询到的id:..........."+id);
        if(id!=null){
            return "existed";
        }else{
//            status状态码：1发送成功；0发送失败
            Map<String,String> map=new HashMap<>();
            map.put("schoolname",schoolname);
            map.put("schooladress",schooladress);
            map.put("img",URL);
            status=userServicesTYC.auditRequest(url,map);
        }
        if (status==0){
            return "false";
        }else{
            return "true";
        }
    }
}
