package clubtribe.services;

import clubtribe.dao.ClubMapper;
import clubtribe.pojo.Club;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author MQ
 */
@Service
public class ClubServicesImpl implements ClubServices {

    @Autowired
    private ClubMapper clubMapper;

    @Override
    public String findnamebyid(Integer clubid) {
        return clubMapper.getclubname(clubid);
    }

    @Override
    public String getmsg(Integer clubid) {
        return clubMapper.getmsg(clubid);
    }

    @Override
    public int initmsg(Club club) {
        return clubMapper.initmsg(club);
    }
}
