package clubtribe.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ClubActivityMapper {
    String queryClubidsByUserid(@Param("userid") String userid);

    List<String> queryClubsByClubid(@Param("clubid") String clubid);
}
