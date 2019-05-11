package clubtribe.services;

import clubtribe.dao.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author MQ
 */
@Service
public class UserServicesImpl implements UserServices {

    @Autowired
    private UserMapper userMapper;

    @Override
    public String findnamebyid(Integer userid) {
        return userMapper.getusername(userid);
    }
}
