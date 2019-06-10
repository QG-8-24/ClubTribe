package clubtribe.controllers;

import clubtribe.pojo.School;
import clubtribe.services.ClubSearchServices_CJN;
import clubtribe.services.ClubTribeAdminServices_CJN;
import clubtribe.services.UserServices_TYC;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.util.ArrayList;
import java.util.List;


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
    /**
     * 获取学校认证信息
     *
     * @param
     * @return
     */
    @RequestMapping(value = "getmsg", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String getmsg() throws IOException {
        List<String> msgList=new ArrayList<>();
        String filepath="D:\\clubtribefile\\schoolmsg\\school-accr-info.txt";
        String encoding="GBK";
        File file=new File(filepath);
        InputStreamReader read = new InputStreamReader(
                new FileInputStream(file),encoding);//考虑到编码格式
        BufferedReader bufferedReader = new BufferedReader(read);
        String lineTxt = null;
        while((lineTxt = bufferedReader.readLine()) != null){
            System.out.println(lineTxt);
            msgList.add(lineTxt);
        }
        read.close();
        System.out.println(JSONArray.fromObject(msgList).toString());
        return JSONArray.fromObject(msgList).toString();
    }
    /**
     * 同意学校认证
     *
     * @param schoolname
     * @param schooladdress
     * @param username
     * @param userid
     * @param admin
     * @return
     */
    @RequestMapping(value = "agree", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public ModelAndView agree(String schoolname, String schooladdress,String username,String userid,String admin) {
        ModelAndView modelAndView=new ModelAndView();
        Double random = Math.random();
        String schoolid = "";
        String clubids="";
        String message="";
        int flag=clubTribeAdminServices_cjn.insert(schoolname,schoolid,clubids,message,schooladdress);
        if (flag==1){
            File inFile = new File("D:\\clubtribefile\\schoolmsg\\school-accr-info.txt");
            File outFile = new File("D:\\clubtribefile\\schoolmsg\\school-accr-info-agree.txt");
            BufferedReader br = null;
            String readedLine;
            BufferedWriter bw = null;
            try {
                FileWriter fw = new FileWriter(outFile);
                bw = new BufferedWriter(fw);
                if (!outFile.exists()) {
                    outFile.createNewFile();
                }
                br = new BufferedReader(new FileReader(inFile));
                int idx = 0;
                while ((readedLine = br.readLine()) != null) {
                    if (readedLine.contains(schoolname)) {
                        continue;
                    }
                    bw.write(readedLine + "\n");
                    if (idx++ == 100) {
                        bw.flush();
                        idx = 0;
                    }
                }
                bw.flush();
                copyFileUsingFileStreams(outFile,inFile);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (br != null) {
                        br.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
                try {
                    if (bw != null) {
                        bw.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        modelAndView.setViewName("clubtribeadmin_CJN");
        modelAndView.addObject("username",username);
        modelAndView.addObject("username",username);
        modelAndView.addObject("userid",userid);
        modelAndView.addObject("admin",admin);
        return modelAndView;
    }
    /**
     * 拒绝学校认证
     *
     * @param schoolname
     * @param schooladdress
     * @param username
     * @param userid
     * @param admin
     * @return
     */
    @RequestMapping(value = "reject", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public ModelAndView reject(String schoolname, String schooladdress,String username,String userid,String admin) {
        ModelAndView modelAndView=new ModelAndView();
        File inFile = new File("D:\\clubtribefile\\schoolmsg\\school-accr-info.txt");
        File outFile = new File("D:\\clubtribefile\\schoolmsg\\school-accr-info-reject.txt");
        BufferedReader br = null;
        String readedLine;
        BufferedWriter bw = null;
        try {
            FileWriter fw = new FileWriter(outFile);
            bw = new BufferedWriter(fw);
            if (!outFile.exists()) {
                outFile.createNewFile();
            }
            br = new BufferedReader(new FileReader(inFile));
            int idx = 0;
            while ((readedLine = br.readLine()) != null) {
                if (readedLine.contains(schoolname)) {
                    continue;
                }
                bw.write(readedLine + "\n");
                if (idx++ == 100) {
                    bw.flush();
                    idx = 0;
                }
            }
            bw.flush();
            copyFileUsingFileStreams(outFile,inFile);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (br != null) {
                    br.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                if (bw != null) {
                    bw.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        modelAndView.addObject("username",username);
        modelAndView.addObject("userid",userid);
        modelAndView.addObject("admin",admin);
        modelAndView.setViewName("clubtribeadmin_CJN");
        return modelAndView;
    }
    private static void copyFileUsingFileStreams(File source, File dest)
            throws IOException {
        InputStream input = null;
        OutputStream output = null;
        try {
            input = new FileInputStream(source);
            output = new FileOutputStream(dest);
            byte[] buf = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buf)) > 0) {
                output.write(buf, 0, bytesRead);
            }
        } finally {
            input.close();
            output.close();
        }
    }
}
