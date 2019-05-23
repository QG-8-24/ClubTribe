package clubtribe.services;

import clubtribe.pojo.ClubMember;

public interface ClubMemberServices {
    /**
     * 注册新成员
     *
     * @param clubMember
     */
    int insert(ClubMember clubMember);

    /**
     * 签到
     *
     * @param clubMember
     * @return
     */
    int sign(ClubMember clubMember);

    /**
     * 获取签到时间
     *
     * @param clubMember
     * @return
     */
    String getsigntime(ClubMember clubMember);

    /**
     * 每天签到重置
     */
    void updataED();

    /**
     * 每月签到重置
     */
    void updataEM();

    //获取社团成员信息
    ClubMember[] getsignmsg(String clubid);
}
