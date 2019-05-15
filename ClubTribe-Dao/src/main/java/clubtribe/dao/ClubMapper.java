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
     * 获取msg
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
}
