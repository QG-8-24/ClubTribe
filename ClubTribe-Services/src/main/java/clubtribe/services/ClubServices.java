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

    /**
     * 初始化公告
     *
     * @param club
     * @return
     */

    int initnotice(Club club);

    /**
     * 获取公告
     *
     * @param clubid
     * @return
     */
    String getnotice(Integer clubid);

    /**
     * 初始化共享文件
     *
     * @param club
     * @return
     */
    int initsharefile(Club club);

    /**
     * 获取共享文件
     *
     * @param clubid
     * @return
     */
    String getsharefile(String clubid);

    /**
     * 设置管理员
     *
     * @param clubid
     * @param admins
     */
    void setadmins(String clubid, String admins);

    /**
     * 获取社长id
     *
     * @param clubid
     * @return
     */
    String getperid(String clubid);

    /**
     * 设置社团名
     *
     * @param  clubname
     * @return
     */
    int setclubname(Integer clubid,String clubname);
    /**
     * 获取社团简介
     *
     * @param clubid
     * @return
     */
    String getitrdc(String clubid);

    /**
     * 设置社团简介
     *
     * @param clubid
     * @return
     */
    void setitrdc(String clubid,String itrdc);
}
