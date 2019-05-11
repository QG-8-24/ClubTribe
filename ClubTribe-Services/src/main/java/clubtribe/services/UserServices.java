package clubtribe.services;

public interface UserServices {
    /**
     * 根据userid查询用户名
     *
     * @param userid
     * @return
     */
    String findnamebyid(Integer userid);
}
