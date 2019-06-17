package clubtribe.services;

import clubtribe.dao.ActivityMapper;
import clubtribe.pojo.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class ActivityServicesImpl implements ActivityServices {
    @Autowired
    private ActivityMapper activityMapper;

    @Override
    public ArrayList<Integer> getids() {
        return activityMapper.getids();
    }

    @Override
    public Integer insertNewActivity(Activity activity) {
        return activityMapper.insertNewActivity(activity);
    }

    @Override
    public ArrayList<Activity> getallactivity() {
        return activityMapper.getallactivity();
    }

    @Override
    public ArrayList<Activity> getactivitbyid(String clubid) {
        return activityMapper.getactivitbyid(clubid);
    }
}
