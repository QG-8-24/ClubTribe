package clubtribe.services;

import clubtribe.dao.ClubsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author MQ
 */
@Service
public class ClubsServicesImpl implements ClubsServices {

    @Autowired
    private ClubsMapper clubsMapper;

    @Override
    public String findnamebyid(Integer cludid) {
        return clubsMapper.getclubname(cludid);
    }
}
