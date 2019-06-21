package clubtribe.controllers;

import clubtribe.services.ClubSearchServices_CJN;
import clubtribe.services.ClubTribeAdminServices_CJN;
import clubtribe.services.UserServices_TYC;
import commom.Generator;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
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
    public String login(String username,String password,HttpSession session){
        String userid= userServicesTYC.userLogin(username,password);
        String admin=clubTribeAdminServices_cjn.checkAdmin(userid);
        if(userid!= null&&admin.equals("1")){
            System.out.println(userid+"@"+admin);
            session.setAttribute("userid",userid);
            session.setAttribute("admin",admin);
            return userid+"@"+admin;
        }
        return "false";
    }
    /**
     * 进入学校认证页面
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
        Generator g=new Generator();
        String schoolid = g.gRanId();
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

    /**
     * 进入社团认证页面
     * @param userid
     * @param admin
     * @return
     */
    @RequestMapping(value="clubCheck", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public ModelAndView clubCheck(String userid,String admin){
        ModelAndView modelAndView = new ModelAndView();
        String username = clubSearchServices_cjn.getUsername(userid);
        modelAndView.addObject("userid", userid);
        modelAndView.addObject("username", username);
        modelAndView.addObject("admin", admin);
        modelAndView.setViewName("clubcheck_CJN");
        return modelAndView;
    }
    /**
     * 获取社团认证信息
     *
     * @param
     * @return
     */
    @RequestMapping(value = "getclub", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String getclub() throws IOException {
        List<String> msgList=new ArrayList<>();
        String filepath="D:\\clubtribefile\\clubcheckmsg\\club-accr-info.txt";
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
     * 同意社团认证
     *
     * @param schoolname
     * @param clubname
     * @param username
     * @param applyman
     * @param userid
     * @param admin
     * @return
     */
    @RequestMapping(value = "clubagree", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public ModelAndView clubagree(String schoolname, String clubname,String applyman,String username,String userid,String admin) {
        ModelAndView modelAndView=new ModelAndView();
        System.out.println(schoolname);
        Integer schoolid=Integer.parseInt(clubTribeAdminServices_cjn.findIdByName(schoolname));
        String clubids=clubTribeAdminServices_cjn.findClubidsByName(schoolname);
        String clubid=String.valueOf((int)(Math.random()*900+100));
        if (clubids.equals("")){
            clubids=clubids+clubid;
            System.out.println(clubids);
        }else {
            clubids=clubids+"@"+clubid;
            System.out.println(clubids);
        }
        Integer perid=Integer.parseInt(applyman);
        String adminid="@@"+applyman;
        String msgboard="";
        String msg="";
        String album="";
        int flag=clubTribeAdminServices_cjn.updateClubidsByName(schoolname,clubids);
        int flag1=clubTribeAdminServices_cjn.insertClub(schoolid,clubid,clubname,perid,adminid,msgboard,msg,album);
        if (flag==1&&flag1==1){
            File inFile = new File("D:\\clubtribefile\\clubcheckmsg\\club-accr-info.txt");
            File outFile = new File("D:\\clubtribefile\\clubcheckmsg\\club-accr-info-agree.txt");
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
                    if (readedLine.contains(clubname)) {
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
        modelAndView.setViewName("clubcheck_CJN");
        modelAndView.addObject("username",username);
        modelAndView.addObject("username",username);
        modelAndView.addObject("userid",userid);
        modelAndView.addObject("admin",admin);
        return modelAndView;
    }
    /**
     * 拒绝社团认证
     *
     * @param schoolname
     * @param clubname
     * @param username
     * @param applyman
     * @param userid
     * @param admin
     * @return
     */
    @RequestMapping(value = "clubreject", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public ModelAndView clubreject(String schoolname, String clubname,String applyman,String username,String userid,String admin) {
        ModelAndView modelAndView=new ModelAndView();
        File inFile = new File("D:\\clubtribefile\\clubcheckmsg\\club-accr-info.txt");
        File outFile = new File("D:\\clubtribefile\\clubcheckmsg\\club-accr-info-reject.txt");
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
        modelAndView.setViewName("clubcheck_CJN");
        return modelAndView;
    }
}
