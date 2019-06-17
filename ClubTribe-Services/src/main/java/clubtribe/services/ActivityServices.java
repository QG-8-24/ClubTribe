package clubtribe.services;

import clubtribe.pojo.Activity;

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
}
