package clubtribe.services;

import clubtribe.pojo.Activity;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;

public interface ActivityServices {
    /**
     * 获取所有活动id
     *
     * @return
     */
    ArrayList<Integer> getids();

    /**
     * 插入新活动
     *
     * @param activity
     * @return
     */
    Integer insertNewActivity(Activity activity);

    /**
     * 获取所有活动
     *
     * @return
     */
    ArrayList<Activity> getallactivity();

    /**
     * 获取活动byid
     *
     * @return
     */
    ArrayList<Activity> getactivitbyid(String clubid);

    /**
     * 删除过期活动
     */
    void removeactivity() throws ParseException, IOException, ClassNotFoundException;

    /**
     * 删除活动byid
     */
    void removeactivitybyid(Integer id) throws ParseException, IOException, ClassNotFoundException;
}
