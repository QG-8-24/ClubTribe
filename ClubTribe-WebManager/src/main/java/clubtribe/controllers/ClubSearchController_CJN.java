package clubtribe.controllers;


import clubtribe.pojo.Club;
import clubtribe.pojo.School;
import clubtribe.services.ClubSearchServices_CJN;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("search")
public class ClubSearchController_CJN {

    @Autowired
    private ClubSearchServices_CJN clubSearchServices_cjn;

    /**
     * 判断登录
     *
     * @param userid
     * @return
     */
    @RequestMapping(value = "init", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String init(String userid) {
        String username = clubSearchServices_cjn.getUsername(userid);
        if (username != null) {
            return username;
        }
        return "";
    }

    /**
     * 查找个人社团
     *
     * @param userid
     * @return
     */
    @RequestMapping("myClub")
    @ResponseBody
    public ModelAndView searchMyClub(String userid, Model model) {
        ModelAndView modelAndView = new ModelAndView();
        System.out.println("my club..........");
        System.out.println(userid);
        String clubids = clubSearchServices_cjn.getclubs(Integer.parseInt(userid));
        String username = clubSearchServices_cjn.getUsername(userid);
        System.out.println(clubids);
        if (clubids != null) {
            String[] clubidList = clubids.split("@");
            List<Club> clubList = new ArrayList<>();
            int count = clubidList.length;
            for (int i = 0; i < count; i++) {
                String clubid = clubidList[i];
                System.out.println(clubid);
                if (clubid != null) {
                    Club club = clubSearchServices_cjn.findnamebyid(Integer.parseInt(clubid));
                    clubList.add(club);
                }
            }
            modelAndView.addObject("clubList", clubList);
            modelAndView.addObject("username", username);
            modelAndView.addObject("userid", userid);
            modelAndView.setViewName("myclub_CJN");
        }

        return modelAndView;
    }

    @RequestMapping(value = "firstData", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String searchFirstData() {
        List<School> firstData = clubSearchServices_cjn.searchFirstData();
        int count = firstData.size();
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
        String Clubids = clubSearchServices_cjn.searchClubidsBySchoolname(Schoolname);
        String[] clubidList = Clubids.split("@");
        List<Club> clubList = new ArrayList<>();
        int count = clubidList.length;
        for (int i = 0; i < count; i++) {
            String clubid = clubidList[i];
            Club club = clubSearchServices_cjn.findnamebyid(Integer.parseInt(clubid));
            clubList.add(club);
        }
        return JSONArray.fromObject(clubList).toString();
    }

    /**
     * @param Clubname
     * @return
     */
    @RequestMapping(value = "searchClubByName", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String searchClubByName(String Clubname) {
        List<Club> clubList = clubSearchServices_cjn.searchClubByName(Clubname);
        return JSONArray.fromObject(clubList).toString();
    }
}
