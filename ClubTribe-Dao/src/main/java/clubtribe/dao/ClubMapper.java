package clubtribe.dao;


import clubtribe.pojo.Club;

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
}
