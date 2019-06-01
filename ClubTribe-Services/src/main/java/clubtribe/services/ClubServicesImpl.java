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

    @Override
    public int initmsgboard(Club club) {
        return clubMapper.initmsgboard(club);
    }

    @Override
    public String getadmin(Integer clubid) {
        return clubMapper.getadminids(clubid);
    }

    @Override
    public String getmsgboard(Integer clubid) {
        return clubMapper.getmsgboard(clubid);
    }

    @Override
    public int initalbum(Club club) {
        return clubMapper.initalbum(club);
    }

    @Override
    public String getalbum(String clubid) {
        return clubMapper.getalbum(clubid);
    }

    @Override
    public int initnotice(Club club) {
        return clubMapper.initnotice(club);
    }

    @Override
    public String getnotice(Integer clubid) {
        return clubMapper.getnotice(clubid);
    }

}
