package clubtribe.services;

import clubtribe.dao.ClubMemberMapper;
import clubtribe.pojo.ClubMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClubMemberServiceslmpl implements ClubMemberServices {

    @Autowired
    private ClubMemberMapper clubMemberMapper;
    @Override
    public int insert(ClubMember clubMember) {
        return clubMemberMapper.insert(clubMember);
    }
}
