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
     *
     * @param clubid
     * @return
     */
    String getmsg(Integer clubid);

    /**
     * 初始化msg
     *
     * @param club
     * @return
     */
    int initmsg(Club club);

    /**
     * 初始化社团留言墙
     *
     * @param club
     * @return
     */
    int initmsgboard(Club club);

    /**
     * 获取社团管理员
     *
     * @param clubid
     * @return
     */
    String getadmin(Integer clubid);

    /**
     * 获取留言墙
     *
     * @param clubid
     * @return
     */
    String getmsgboard(Integer clubid);

    /**
     * 初始化相册
     *
     * @param club
     * @return
     */
    int initalbum(Club club);

    /**
     * 获取相册
     *
     * @param clubid
     * @return
     */
    String getalbum(String clubid);
}
