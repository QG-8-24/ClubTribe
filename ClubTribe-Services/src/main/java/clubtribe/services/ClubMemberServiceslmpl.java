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
        return clubMemberMapper.sign(clubMember);
    }

    @Override
    public String getsigntime(ClubMember clubMember) {
        return clubMemberMapper.getsigntime(clubMember);
    }

    /**
     * 凌晨自动清零
     */
    @Override
    @Scheduled(cron = "0 0 0 * * ?")
    public void updataED() {
        List<String> list = clubMapper.getallClubids();
        for (String it : list) {
            ClubMember clubMember = new ClubMember();
            clubMember.setClubname(it);
            clubMemberMapper.updataED(clubMember);
        }
    }
}
