package clubtribe.dao;

import clubtribe.pojo.ClubMember;
import org.apache.ibatis.annotations.Param;

public interface ClubMemberMapper {

    /**
     * 插入新成员
     *
     * @param member
     */
    int insert(ClubMember member);

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
     * 签到天数加一
     */
    void UPdatemsign(ClubMember clubMember);

    /**
     * 每天清零签到
     */
    void updataED();

    /**
     * 每月清零签到
     */
    void updataEM();

    /**
     * 获取社团成员信息
     */
    ClubMember[] getmembermsg(String clubid);

    /**
     * 设置管理员
     *
     * @param userid
     * @return
     */
    int setadmin(@Param("userid") String userid, @Param("clubid") String clubid);

    /**
     * remove管理员
     *
     * @param userid
     * @return
     */
    int removeadmin(@Param("userid") String userid, @Param("clubid") String clubid);

    /**
     * 删除成员
     *
     * @param clubid
     * @param userid
     */
    void removemember(@Param("userid") String userid, @Param("clubid") String clubid);
}
