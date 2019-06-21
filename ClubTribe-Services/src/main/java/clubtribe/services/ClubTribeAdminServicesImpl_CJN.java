package clubtribe.services;

import clubtribe.dao.ClubTribeAdminMapper_CJN;
import clubtribe.pojo.School;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClubTribeAdminServicesImpl_CJN implements ClubTribeAdminServices_CJN{
    @Autowired
    private ClubTribeAdminMapper_CJN clubTribeAdminMapper_cjn;

    @Override
    public String checkAdmin(String userid) {
        return  clubTribeAdminMapper_cjn.checkAdmin(userid);

    }

    @Override
    public int insert(String schoolname, String schoolid, String clubids, String message, String schooladdress) {
        return clubTribeAdminMapper_cjn.insert(schoolname,schoolid,clubids,message,schooladdress);
    }

    @Override
    public String findIdByName(String schoolname) {
        return clubTribeAdminMapper_cjn.findIdByName(schoolname);
    }

    @Override
    public String findClubidsByName(String schoolname) {
        return clubTribeAdminMapper_cjn.findClubidsByName(schoolname);
    }

    @Override
    public int updateClubidsByName(String schoolname, String clubids) {
        return clubTribeAdminMapper_cjn.updateClubidsByName(schoolname,clubids);
    }
    @Override
    public Integer insertClub(Integer schoolid, String clubid, String clubname, Integer perid, String adminid, String msgboard, String msg, String album) {
        return  clubTribeAdminMapper_cjn.insertClub(schoolid,clubid,clubname,perid,adminid,msgboard,msg,album);
    }


}
