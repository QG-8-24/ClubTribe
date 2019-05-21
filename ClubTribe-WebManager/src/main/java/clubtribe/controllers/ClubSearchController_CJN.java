package clubtribe.controllers;


import clubtribe.pojo.Club;
import clubtribe.pojo.School;
import clubtribe.services.ClubSearchServices_CJN;
import clubtribe.services.UserServices;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("search")
public class ClubSearchController_CJN {

    @Autowired
    private ClubSearchServices_CJN clubSearchServices_cjn;

    @RequestMapping("allClub")
    public String searchAll(Model model) {
        System.out.println("search.............");
        List<Club> list = clubSearchServices_cjn.searchAll();
        model.addAttribute("clubs", list);
        return "clubsearch_CJN";
    }

    /**
     * 查找个人社团
     *
     * @param userid
     * @return
     */
    @RequestMapping("myClub")
    @ResponseBody
    public String searchMyClub(String userid, HttpSession httpSession) {
        System.out.println("my club..........");
        System.out.println(userid);
        String clubids = clubSearchServices_cjn.getclubs(Integer.parseInt(userid));
        String[] clubidList = clubids.split("@");
        List<Club> clubList = new ArrayList<>();
        int count = clubidList.length;
        for (int i = 0; i < count; i++) {
            String clubid = clubidList[i];
            Club club = clubSearchServices_cjn.findnamebyid(Integer.parseInt(clubid));
            clubList.add(club);
        }
        String str = null;
        if (clubidList.length != 0) {
            str = "查找成功";
        } else {
            str = "失败";
        }
        httpSession.setAttribute("clubList", clubList);
        return str;
    }

    @RequestMapping(value = "firstData", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String searchFirstData() {
        List<School> firstData = clubSearchServices_cjn.searchFirstData();
        int count = firstData.size();
        for (int i = 0; i < count; i++) {
            System.out.println(firstData.get(i).getSchoolAddress());
        }
        System.out.println(JSONArray.fromObject(firstData).toString());
        return JSONArray.fromObject(firstData).toString();

    }

    /**
     * @param SchoolAddress
     * @return
     */
    @RequestMapping(value = "secondData", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String searchSecondData(String SchoolAddress) {
        System.out.println(SchoolAddress);
        List<School> secondData = clubSearchServices_cjn.searchSecondDataByAddress(SchoolAddress);
        int count = secondData.size();
        for (int i = 0; i < count; i++) {
            System.out.println(secondData.get(i).getSchoolname());
        }
        System.out.println(JSONArray.fromObject(secondData).toString());
        return JSONArray.fromObject(secondData).toString();
    }

    /**
     * @param Schoolname
     * @return
     */
    @RequestMapping(value = "thirdData", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String searchThirdData(String Schoolname) {
        System.out.println(Schoolname);
        String Clubids = clubSearchServices_cjn.searchClubidsBySchoolname(Schoolname);
        System.out.println(Clubids);
        String[] clubidList = Clubids.split("@");
        List<Club> clubList = new ArrayList<>();
        int count = clubidList.length;
        for (int i = 0; i < count; i++) {
            String clubid = clubidList[i];
            Club club = clubSearchServices_cjn.findnamebyid(Integer.parseInt(clubid));
            clubList.add(club);
        }
        System.out.println(JSONArray.fromObject(clubList).toString());
        return JSONArray.fromObject(clubList).toString();
    }

    /**
     * @param Clubname
     * @return
     */
    @RequestMapping(value = "searchClubByName", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String searchClubByName(String Clubname) {
        System.out.println(Clubname);
        List<Club> clubList = clubSearchServices_cjn.searchClubByName(Clubname);
        System.out.println(JSONArray.fromObject(clubList).toString());
        return JSONArray.fromObject(clubList).toString();
    }
}
