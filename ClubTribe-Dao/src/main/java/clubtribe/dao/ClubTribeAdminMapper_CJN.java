package clubtribe.dao;

import org.apache.ibatis.annotations.Param;

public interface ClubTribeAdminMapper_CJN {
    String checkAdmin(@Param("userid") String userid);

    int insert(@Param("schoolname") String schoolname, @Param("schoolid") String schoolid, @Param("clubids") String clubids, @Param("message") String message, @Param("schooladdress") String schooladdress);

    String findIdByName(@Param("schoolname") String schoolname);

    String findClubidsByName(@Param("schoolname") String schoolname);

    int updateClubidsByName(@Param("schoolname") String schoolname, @Param("clubids") String clubids);

    Integer insertClub(@Param("schoolid") Integer schoolid, @Param("clubid") String clubid, @Param("clubname") String clubname, @Param("perid") Integer perid, @Param("adminid") String adminid, @Param("msgboard") String msgboard, @Param("msg") String msg, @Param("album") String album);



}
