package clubtribe.dao;

import java.util.Map;

/**
 * @author tyc
 */
public interface UserMapper_TYC {
    /**
     *
     * @param map
     * @return
     */

    String findUser(Map<String, String> map);

    /**
     *
     * @param usermap
     * @return
     */
    Integer insertUser(Map<String, String> usermap);

    /**
     *
     * @param id
     * @return
     */
    Integer findUserById(String id);

    /**
     *
     * @param username
     * @return
     */
    String selectPasswordByName(String username);

    /**
     * 查找学校id
     * @param map(schoolname,schooladress)
     * @return
     */
    Integer findSchoolID(Map<String, String> map);
}
