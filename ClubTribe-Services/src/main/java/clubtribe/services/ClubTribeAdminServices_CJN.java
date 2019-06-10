package clubtribe.services;

import clubtribe.pojo.School;

public interface ClubTribeAdminServices_CJN {

    String checkAdmin(String userid);


    int insert(String schoolname, String schoolid, String clubids, String message, String schooladdress);
}
