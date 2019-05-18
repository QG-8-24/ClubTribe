package clubtribe.dao;

import clubtribe.pojo.ClubMember;

public interface ClubMemberMapper {

    /**
     * 插入新成员
     *
     * @param member
     */
    int insert(ClubMember member);
}
