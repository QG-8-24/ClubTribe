package clubtribe.services;

import clubtribe.pojo.Club;
import clubtribe.pojo.School;

import java.util.List;

public interface ClubSearchServices_CJN {
    List<Club> searchAll();

    Club findnamebyid(Integer clubid);



    List<School> searchFirstData();

    String getclubs(Integer userid);

    List<School> searchSecondDataByAddress(String SchoolAddress);

    String searchClubidsBySchoolname(String Schoolname);

    List<Club> searchClubByName(String Clubname);

    String getUsername(String userid);
}
