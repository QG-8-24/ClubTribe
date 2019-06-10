package clubtribe.services;

import clubtribe.dao.UserMapper;
import clubtribe.pojo.User;
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
    public String getuserid(String username) {
        return userMapper.getuserid(username);
    }

    @Override
    public String findnamebyid(Integer userid) {
        return userMapper.getusername(userid);
    }

    @Override
    public String getuserclubs(Integer userid) {
        return userMapper.getuserclubs(userid);
    }

    @Override
    public int joinclub(User user) {
        return userMapper.joinclub(user);
    }
}
