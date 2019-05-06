package clubtribe.dao;


/**
 * @author MQ
 */
public interface ClubsMapper {
    /**
     * 根据cludid查询社团名
     *
     * @param cludid
     * @return clubname
     */
    String getclubname(Integer cludid);
}
