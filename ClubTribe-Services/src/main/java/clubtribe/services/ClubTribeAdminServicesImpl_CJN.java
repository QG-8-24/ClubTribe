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


}
