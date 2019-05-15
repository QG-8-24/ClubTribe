package clubtribe.controllers;

import clubtribe.services.ClubActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("club")
public class ActivityController {

    @Autowired
    private ClubActivityService clubActivityService;

    @RequestMapping("activity")
    public String queryClubidsByUserid(@RequestParam("userid")String userid, Model model){
        String ids=clubActivityService.queryClubidsByUserid(userid);
        String clubsid[]=ids.split("@");
        int count =clubsid.length;
        int flag=0;
        if (count==0){
            model.addAttribute("count",count);
            return "clubindex";
        }
        else{
            for (int i=0;i<count;i++){
                List<String> club=clubActivityService.queryClubsByClubid(clubsid[i]);
                String admins=club.get(4);
                String adminids[]=admins.split("@");
                int index=adminids.length;
                for (int j=0;j<index;j++){
                    if (adminids[j].equals(userid)){
                        flag=1;
                        model.addAttribute("flag",flag);
                        return "clubindex";
                    }
                    else {
                        model.addAttribute("flag",flag);
                        return "clubindex";
                    }
                }
            }
        }
        return "clubindex";
    }
}
