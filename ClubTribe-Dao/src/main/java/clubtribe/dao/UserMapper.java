package clubtribe.dao;

import clubtribe.pojo.User;

/**
 * @author MQ
 */
public interface UserMapper {
    /**
     * 获取用户id
     *
     * @param
     * @return
     */
    String getuserid(String username);

    /**
     * 获取用户名
     *
     * @param userid
     * @return
     */
    String getusername(Integer userid);

    /**
     * 获取社团id集合
     *
     * @param userid
     * @return
     */
    String getuserclubs(Integer userid);

    /**
     * 加入社团
     *
     * @return
     */
    int joinclub(User user);

}
