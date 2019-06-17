package clubtribe.dao;

import clubtribe.pojo.Activity;

import java.util.ArrayList;

/**
 * @author QGshen
 */
public interface ActivityMapper {
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
    void removeactivity(Integer id);
}
