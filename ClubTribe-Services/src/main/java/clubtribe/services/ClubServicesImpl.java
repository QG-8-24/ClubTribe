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
    public String getschoolid(Integer clubid) {
        return clubMapper.getschoolid(clubid);
    }

    @Override
    public String getsnamebyid(String schoolid) {
        return clubMapper.getsnamebyid(schoolid);
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

    @Override
    public int initsharefile(Club club) {
        return clubMapper.initsharefile(club);
    }

    @Override
    public String getsharefile(String clubid) {
        return clubMapper.getsharefile(clubid);
    }

    @Override
    public void setadmins(String clubid, String admins) {
        clubMapper.setadmins(clubid, admins);
    }

    @Override
    public String getperid(String clubid) {
        return clubMapper.getperid(clubid);
    }

    @Override
    public int setclubname(Integer clubid, String clubname) {
        return clubMapper.setclubname(clubid,clubname);
    }

    @Override
    public String getitrdc(String clubid) {
        return clubMapper.getitrdc(clubid);
    }

    @Override
    public void setitrdc(String clubid, String itrdc) {
        clubMapper.setitrdc(clubid,itrdc);
    }
}
