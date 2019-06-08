package clubtribe.services;

import clubtribe.dao.ClubTribeAdminMapper_CJN;
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
}
