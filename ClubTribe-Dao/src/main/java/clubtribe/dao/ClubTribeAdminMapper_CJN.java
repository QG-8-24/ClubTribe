package clubtribe.dao;

import org.apache.ibatis.annotations.Param;

public interface ClubTribeAdminMapper_CJN {
    String checkAdmin(@Param("userid")String userid);
}
