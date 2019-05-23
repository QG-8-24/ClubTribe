package clubtribe.services;

import clubtribe.dao.ClubMapper;
import clubtribe.dao.ClubMemberMapper;
import clubtribe.pojo.ClubMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClubMemberServiceslmpl implements ClubMemberServices {

    @Autowired
    private ClubMemberMapper clubMemberMapper;

    @Autowired
    private ClubMapper clubMapper;

    @Override
    public int insert(ClubMember clubMember) {
        return clubMemberMapper.insert(clubMember);
    }

    @Override
    public int sign(ClubMember clubMember) {
        //月签到天数加一
        clubMemberMapper.UPdatemsign(clubMember);
        return clubMemberMapper.sign(clubMember);
    }

    @Override
    public String getsigntime(ClubMember clubMember) {
        return clubMemberMapper.getsigntime(clubMember);
    }

    /**
     * 每天签到重置
     */
    @Override
    @Scheduled(cron = "0 0 0 * * ?")
    public void updataED() {
        clubMemberMapper.updataED();
    }

    /**
     * 每月签到重置
     */
    @Override
    @Scheduled(cron = "0 0 0 1 * ?")
    public void updataEM() {
        clubMemberMapper.updataEM();
    }

    @Override
    public ClubMember[] getsignmsg(String clubid) {
        return clubMemberMapper.getsignmsg(clubid);
    }
}
