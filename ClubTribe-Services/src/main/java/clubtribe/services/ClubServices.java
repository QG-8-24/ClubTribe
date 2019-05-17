package clubtribe.services;

import clubtribe.pojo.Club;

public interface ClubServices {
    /**
     * 根据cludid查询社团名
     *
     * @param clubid
     * @return
     */
    String findnamebyid(Integer clubid);

    /**
     * 获取通知
     * @param clubid
     * @return
     */
    String getmsg(Integer clubid);

    /**
     * 初始化msg
     * @param club
     * @return
     */
    int initmsg(Club club);

    /**
     * 获取社团管理员
     * @param clubid
     * @return
     */
    String getadmin(Integer clubid);
}
