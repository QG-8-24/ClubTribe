package clubtribe.services;

import clubtribe.dao.UserMapper_TYC;
import commom.Generator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author tyc
 */
@Service
public class UserServicesTYCImpl implements UserServices_TYC {

    @Autowired
    private UserMapper_TYC userMapperTYC;

    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     */
    @Override
    public String userLogin(String username, String password) {
        Map<String,String> map=new HashMap<>();
        map.put("username",username);
        map.put("password",password);
        return userMapperTYC.findUser(map);
    }

    /**
     * 用户注册
     * @param usermap
     * @return
     */
    @Override
    public Integer userRegister(Map<String, String> usermap) {
        Generator g=new Generator();
        String userid=g.gRanId();

        while (userMapperTYC.findUserById(userid)!=null){
            userid=g.gRanId();
        }
        System.out.println("id:"+userid);
        usermap.put("userid",userid);
        String status= userMapperTYC.findUser(usermap);
        if(status!=null){
            return null;
        }
        userMapperTYC.insertUser(usermap);
        return Integer.parseInt(userid);
    }

    /**
     * 找回密码
     * @param username
     * @return
     */
    @Override
    public String findPassword(String username) {
        return userMapperTYC.selectPasswordByName(username);
    }

    /**
     * 查询学校id
     * @param schoolname
     * @param schooladress
     * @return
     */
    @Override
    public Integer findSchoolId(String schoolname, String schooladress) {
        Map<String,String> schoolmap=new HashMap<>();
        schoolmap.put("schoolname",schoolname);
        schoolmap.put("schooladress",schooladress);
        return userMapperTYC.findSchoolID(schoolmap);
    }
    @Override
    public Integer findclubId(String schoolname, String clubname) {
        Map<String,String> clubmap=new HashMap<>();
        Integer schoolid=userMapperTYC.findSchoolIDByName(schoolname);
        System.out.println("找到的schoolid:"+schoolid);
        clubmap.put("schoolid",String.valueOf(schoolid));
        clubmap.put("clubname",clubname);
        return userMapperTYC.findclubId(clubmap);
    }

    /**
     * 向文件写入学校认证请求
     * @param url
     * @param map
     * @return
     */
    @Override
    public Integer auditRequest(String url, Map<String, String> map) throws IOException {
        File file=new File(url);
        if(!file.exists()| !file.isFile()){
            System.out.println("不存在指定路径");
            return 0;
        }
        FileWriter fileWriter=new FileWriter(file,true);
        String sep="@";
        String content=map.get("schoolname")+sep+map.get("schooladress")+sep+map.get("img")+"\n";
        fileWriter.write(content);
        fileWriter.close();
        return 1;
    }
    /**
     * 向文件写入社团认证请求
     * @param url
     * @param map
     * @return
     */
    @Override
    public Integer auditRequest2(String url, Map<String, String> map) throws IOException {
        File file=new File(url);
        if(!file.exists()| !file.isFile()){
            System.out.println("不存在指定路径");
            return 0;
        }
        FileWriter fileWriter=new FileWriter(file,true);
        String sep="@";
        String content=map.get("clubname")+sep+map.get("schoolname")+sep+map.get("userid")+sep+map.get("img")+"\n";
        fileWriter.write(content);
        fileWriter.close();
        return 1;
    }
}
