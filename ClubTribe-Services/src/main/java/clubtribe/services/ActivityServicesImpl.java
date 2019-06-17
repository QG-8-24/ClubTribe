package clubtribe.services;

import clubtribe.dao.ActivityMapper;
import clubtribe.pojo.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

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

    /**
     * 每天自动删除过期活动
     *
     * @throws ParseException
     * @throws IOException
     * @throws ClassNotFoundException
     */
    @Override
    @Scheduled(cron = "0 0 0 * * ?")
    public void removeactivity() throws ParseException, IOException, ClassNotFoundException {
        System.out.println("执行++++++++++++");
        String file = "D:\\ClubTribe\\ClubTribe-WebManager\\src\\main\\webapp\\clubtribefile\\activatyfile\\activity.txt";
        Date dt = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        ArrayList<Activity> list = activityMapper.getallactivity();
        for (Activity it : list) {
            if (df.parse(sdf.format(dt)).getTime() > df.parse(it.getEndtime()).getTime()) {
                activityMapper.removeactivity(it.getId());
                ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file));
                Map<Integer, ArrayList<String>> map = (Map<Integer, ArrayList<String>>) ois.readObject();
                map.remove(it.getId());
                ois.close();
                ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file));
                oos.writeObject(map);
                oos.close();
            }
        }
    }

    @Override
    public void removeactivitybyid(Integer id) throws ParseException, IOException, ClassNotFoundException {
        activityMapper.removeactivity(id);
    }
}
