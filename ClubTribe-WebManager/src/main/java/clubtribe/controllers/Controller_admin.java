package clubtribe.controllers;

import clubtribe.pojo.ClubMember;
import clubtribe.pojo.User;
import clubtribe.services.ClubMemberServices;
import clubtribe.services.ClubServices;
import clubtribe.services.UserServices;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("admin")
public class Controller_admin {

    @Autowired
    private ClubServices clubServices;
    @Autowired
    private ClubMemberServices clubMemberServices;
    @Autowired
    private UserServices userServices;

    @RequestMapping("ifper")
    @ResponseBody
    public String ifper(String clubid, String userid) {
        if (clubServices.getperid(clubid).equals(userid)) {
            return clubServices.getperid(clubid);
        }
        return "";
    }

    /**
     * 获取社团通知
     *
     * @param clubid
     * @return
     * @throws IOException
     * @throws ClassNotFoundException
     */
    @RequestMapping("getmsg")
    @ResponseBody
    public String getmsg(String clubid, String userid) throws IOException, ClassNotFoundException {
        String filepath = clubServices.getmsg(Integer.parseInt(clubid));
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filepath));
        ArrayList<String> list = (ArrayList<String>) ois.readObject();
        ObjectMapper mapper = new ObjectMapper();
        ois.close();
        return mapper.writeValueAsString(list);
    }

    /**
     * 同意加入
     *
     * @param clubid
     * @param userid
     * @return
     */
    @RequestMapping("agree")
    @ResponseBody
    public String agree(String clubid, String userid) {
        String filepath = clubServices.getmsg(Integer.parseInt(clubid));
        String str = "false";
        ClubMember clubMember = new ClubMember();
        clubMember.setClubid(clubid);
        clubMember.setUserid(userid);
        clubMember.setUsername(userServices.findnamebyid(Integer.parseInt(userid)));
        clubMember.setSign("");
        clubMember.setMsign("");
        clubMember.setIfadmin(0);
        try {
            int flag = clubMemberServices.insert(clubMember);
            if (flag != 0) {
                str = "true";
                ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filepath));
                ArrayList<String> list = (ArrayList<String>) ois.readObject();
                list.remove(userid);
                ois.close();
                ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filepath));
                oos.writeObject(list);
                oos.close();
                String clubids = userServices.getuserclubs(Integer.parseInt(userid));
                clubids = clubids + "@" + clubid;
                User user = new User();
                user.setUserid(Integer.parseInt(userid));
                user.setClubids(clubids);
                userServices.joinclub(user);
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            return str;
        }
    }

    /**
     * 拒绝加入
     *
     * @param clubid
     * @param userid
     * @return
     * @throws IOException
     * @throws ClassNotFoundException
     */
    @RequestMapping("reject")
    @ResponseBody
    public String reject(String clubid, String userid) throws IOException, ClassNotFoundException {
        String str = "false";
        String filepath = clubServices.getmsg(Integer.parseInt(clubid));
        try {
            ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filepath));
            ArrayList<String> list = (ArrayList<String>) ois.readObject();
            list.remove(userid);
            ois.close();
            ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filepath));
            oos.writeObject(list);
            oos.close();
            str = "true";
        } catch (Exception e) {
            System.out.println(e);
        }
        return str;
    }

    /**
     * 获取成员信息
     *
     * @return
     */
    @RequestMapping(value = "getmembermsg")
    @ResponseBody
    public String getmembermsg(String clubid) throws JsonProcessingException {
        ClubMember[] list = clubMemberServices.getmembermsg(clubid);
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(list);
    }

    @RequestMapping(value = "setadmin", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String setadmin(String userid, String clubid) {
        String result = "失败";
        String str = clubServices.getadmin(Integer.parseInt(clubid));
        String[] strs = str.split("@@");
        if (!Arrays.asList(strs).contains(userid)) {
            if (strs.length >= 6) {
                result = "管理员人数达到上限 最多6人";
            } else {
                str = str + "@@" + userid;
                clubMemberServices.setadmin(userid, clubid);
                clubServices.setadmins(clubid, str);
                result = "成功";
            }
        }
        return result;
    }

    /**
     * 删除文件
     *
     * @param clubid
     * @param file
     */
    @RequestMapping("delfile")
    public void delfile(String clubid, String file) {
        String filepath = clubServices.getsharefile(clubid);
        File dir = new File(filepath);
        String[] files = dir.list();
        for (String it : files) {
            if (it.equals(file)) {
                File newfile = new File(filepath + "\\" + it);
                if (newfile.exists()) {
                    newfile.delete();
                }
            }
        }
    }

    /**
     * 删除管理员
     *
     * @param userid
     * @param clubid
     * @return
     */
    @RequestMapping(value = "removeadmin", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String removeadmin(String userid, String clubid) {
        String result = "失败";
        String str = clubServices.getadmin(Integer.parseInt(clubid));
        String[] strs = str.split("@@");
        StringBuilder stringBuilder = new StringBuilder();
        for (String it : strs) {
            if (!it.equals(userid) && !it.equals("")) {
                stringBuilder.append("@@" + it);
            }
        }
        try {
            clubMemberServices.removeadmin(userid, clubid);
            clubServices.setadmins(clubid, stringBuilder.toString());
            result = "成功";
        } catch (Exception e) {
        }
        return result;
    }

    /**
     * 删除成员
     *
     * @param userid
     * @param clubid
     * @return
     */
    @RequestMapping(value = "removemember", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String removemember(String userid, String clubid) {
        clubMemberServices.removemember(userid, clubid);
        String[] strs = userServices.getuserclubs(Integer.parseInt(userid)).split("@");
        StringBuilder stringBuilder = new StringBuilder();
        for (String it : strs) {
            if (!it.equals(clubid) && !it.equals("")) {
                stringBuilder.append("@" + it);
            }
        }
        User user = new User();
        user.setUserid(Integer.parseInt(userid));
        user.setClubids(stringBuilder.toString());
        userServices.joinclub(user);
        return "成功!";
    }

    /**
     * 删除相册
     *
     * @param clubid
     * @param album
     */
    @RequestMapping("delalbum")
    public void delalbum(String clubid, String album) {
        String filepath = clubServices.getalbum(clubid);
        File dir = new File(filepath);
        String[] files = dir.list();
        for (String it : files) {
            if (it.equals(album)) {
                File newfile = new File(filepath + "\\" + it);
                if (newfile.exists()) {
                    newfile.delete();
                }
            }
        }
    }

    /**
     * 上传背景图
     *
     * @param request
     * @param clubid
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/uploadbg", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String uploadFiles(HttpServletRequest request, String clubid) throws IOException {
        String savePath = "D:\\ClubTribe\\ClubTribe-WebManager\\src\\main\\webapp\\img";
        List<MultipartFile> files = ((MultipartHttpServletRequest) request).getFiles("file");
        MultipartFile file = null;
        BufferedOutputStream stream = null;
        for (int i = 0; i < files.size(); ++i) {
            file = files.get(i);
            if (!file.isEmpty()) {
                try {
                    byte[] bytes = file.getBytes();
                    File saveFile = new File(savePath, file.getOriginalFilename());
                    File newfile = new File(savePath + "\\bg" + clubid + ".jpg");
                    saveFile.renameTo(newfile);
                    stream = new BufferedOutputStream(new FileOutputStream(newfile));
                    stream.write(bytes);
                    stream.close();
                } catch (Exception e) {
                    if (stream != null) {
                        stream.close();
                        stream = null;
                    }
                    return "第 " + i + " 个文件上传有错误" + e.getMessage();
                }
            } else {
                return "第 " + i + " 个文件为空";
            }
        }
        return "所有文件上传成功";
    }

    @RequestMapping("initmsg")
    @ResponseBody
    public String initmsg(String clubid) throws JsonProcessingException {
        String clubname = clubServices.findnamebyid(Integer.parseInt(clubid));
        String itrdc = clubServices.getitrdc(clubid);
        String str = clubname + "@@" + itrdc;
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(str);
    }

    @RequestMapping("chagemsg")
    @ResponseBody
    public String chagemsg(String clubid, String clubname, String itrdc) throws JsonProcessingException {
        clubServices.setclubname(Integer.parseInt(clubid), clubname);
        clubServices.setitrdc(clubid, itrdc);
        ObjectMapper objectMapper=new ObjectMapper();
        return objectMapper.writeValueAsString("修改成功!");
    }
}
