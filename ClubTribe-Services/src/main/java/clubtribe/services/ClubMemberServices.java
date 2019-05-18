package clubtribe.services;

import clubtribe.pojo.ClubMember;

public interface ClubMemberServices {
    /**
     *
     * @param clubMember
     */
    int insert(ClubMember clubMember);

    /**
     * 签到
     * @param clubMember
     * @return
     */
    int sign(ClubMember clubMember);

    /**
     * 获取签到时间
     * @param clubMember
     * @return
     */
    String getsigntime(ClubMember clubMember);
}
