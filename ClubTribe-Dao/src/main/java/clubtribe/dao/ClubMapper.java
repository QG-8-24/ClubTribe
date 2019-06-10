package clubtribe.dao;


import clubtribe.pojo.Club;
import org.apache.ibatis.annotations.Param;

/**
 * @author MQ
 */
public interface ClubMapper {
    /**
     * 根据cludid查询社团名
     *
     * @param clubid
     * @return clubname
     */
    String getclubname(Integer clubid);

    /**
     * 设置社团名
     *
     * @param clubid
     * @param clubname
     * @return
     */
    int setclubname(@Param("clubid") Integer clubid, @Param("clubname") String clubname);

    /**
     * 获取社团msg
     *
     * @param clubid
     * @return
     */
    String getmsg(Integer clubid);

    /**
     * 初始化社团msg
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
    String getadminids(Integer clubid);

    /**
     * 获取留言墙
     *
     * @param clubid
     * @return
     */
    String getmsgboard(Integer clubid);

    /**
     * 初始公告
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
    void setadmins(@Param("clubid") String clubid, @Param("admins") String admins);

    /**
     * 获取社长id
     *
     * @param clubid
     * @return
     */
    String getperid(String clubid);

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
    void setitrdc(@Param("clubid") String clubid, @Param("itrdc") String itrdc);

}
