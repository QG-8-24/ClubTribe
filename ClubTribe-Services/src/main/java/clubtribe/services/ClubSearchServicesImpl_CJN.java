package clubtribe.services;

import clubtribe.dao.ClubSearchMapper_CJN;
import clubtribe.pojo.Club;
import clubtribe.pojo.School;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClubSearchServicesImpl_CJN implements ClubSearchServices_CJN {

    @Autowired
    private ClubSearchMapper_CJN clubSearchMapper_cjn;


    @Override
    public List<Club> searchAll() {
        return clubSearchMapper_cjn.searchAll();

    }

    @Override
    public Club findnamebyid(Integer clubid) {

        return clubSearchMapper_cjn.findnamebyid(clubid);
    }


    @Override
    public List<School> searchFirstData() {
        return clubSearchMapper_cjn.searchFirstData();
    }

    @Override
    public String getclubs(Integer userid) {
        return clubSearchMapper_cjn.getclubs(userid);
    }

    @Override
    public List<School> searchSecondDataByAddress(String SchoolAddress) {
        return clubSearchMapper_cjn.searchSecondDataByAddress(SchoolAddress);
    }

    @Override
    public String searchClubidsBySchoolname(String Schoolname) {

        return clubSearchMapper_cjn.searchClubidsBySchoolname(Schoolname);
    }

    @Override
    public List<Club> searchClubByName(String Clubname) {
        return clubSearchMapper_cjn.searchClubByName(Clubname);

    }

    @Override
    public String getUsername(String userid) {

        return clubSearchMapper_cjn.getUsername(userid);
    }


}
