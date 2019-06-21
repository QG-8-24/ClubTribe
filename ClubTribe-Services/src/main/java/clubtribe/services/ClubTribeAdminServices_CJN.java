package clubtribe.services;


public interface ClubTribeAdminServices_CJN {

    String checkAdmin(String userid);


    int insert(String schoolname, String schoolid, String clubids, String message, String schooladdress);

    String findIdByName(String schoolname);

    String findClubidsByName(String schoolname);

    int updateClubidsByName(String schoolname, String clubids);

    Integer insertClub(Integer schoolid, String clubid, String clubname, Integer perid, String adminid, String msgboard, String msg, String album);



}
