package clubtribe.dao;

import clubtribe.pojo.Club;
import clubtribe.pojo.School;
import clubtribe.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ClubSearchMapper_CJN {
    List<Club> searchAll();

    User searchMyClub(@Param("userid") String userid);


    Club findnamebyid(@Param("clubid") Integer clubid);

    List<School> searchFirstData();

    String getclubs(@Param("userid")Integer userid);

    List<School> searchSecondDataByAddress(@Param("SchoolAddress")String SchoolAddress);

    String searchClubidsBySchoolname(@Param("Schoolname")String Schoolname);

    List<Club> searchClubByName(@Param("Clubname")String Clubname);

    String getUsername(@Param("userid")String userid);
}
