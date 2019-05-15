package clubtribe.services;

import clubtribe.dao.ClubActivityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("clubActivityService")
public class ClubActivityServiceImpl implements ClubActivityService{

    @Autowired
    private ClubActivityMapper clubActivityMapper;

    @Override
    public String queryClubidsByUserid(String userid) {
        return  clubActivityMapper.queryClubidsByUserid(userid);
    }

    @Override
    public List<String> queryClubsByClubid(String clubid) {
        return clubActivityMapper.queryClubsByClubid(clubid);
    }
}
