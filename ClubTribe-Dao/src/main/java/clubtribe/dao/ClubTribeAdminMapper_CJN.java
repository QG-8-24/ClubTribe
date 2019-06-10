package clubtribe.dao;

import clubtribe.pojo.School;
import org.apache.ibatis.annotations.Param;

public interface ClubTribeAdminMapper_CJN {
    String checkAdmin(@Param("userid")String userid);

    int insert(@Param("schoolname")String schoolname, @Param("schoolid")String schoolid, @Param("clubids")String clubids, @Param("message")String message, @Param("schooladdress")String schooladdress);
}
