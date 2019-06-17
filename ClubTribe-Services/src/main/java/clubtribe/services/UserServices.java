package clubtribe.services;

import clubtribe.pojo.User;

public interface UserServices {
    /**
     * 获取用户id
     *
     * @param
     * @return
     */
    String getuserid(String username);

    /**
     * 根据userid查询用户名
     *
     * @param userid
     * @return
     */
    String findnamebyid(Integer userid);

    /**
     * 获取用户所加入的社团
     *
     * @param userid
     * @return
     */
    String getuserclubs(Integer userid);

    /**
     * 用户加入新的社团
     *
     * @param user
     * @return
     */
    int joinclub(User user);

    /**
     * 获取用户信息
     *
     * @param userid
     * @return
     */
    User getuserbyid(Integer userid);
}
