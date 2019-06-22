package clubtribe.pojo;

import java.util.ArrayList;

/**
 * 活动pojo
 *
 * @author QGshen
 */
public class Activity {
    private String clubid;
    private Integer id;
    private String name;
    private String begintime;
    private String endtime;
    private Integer ifjoin;
    private ArrayList<String> memberid;
    private String site;
    private String itrdc;
    private String schoolname;
    private String clubname;
    /**
     * 活动类型
     * 1 社团内部活动
     * 2 联合活动
     */
    private Integer type;

    public Activity() {
        super();
    }

    public Activity(String clubid, Integer id, String name, String begintime, String endtime, Integer ifjoin, ArrayList<String> memberid, String site, String itrdc, String schoolname, String clubname, Integer type) {
        this.clubid = clubid;
        this.id = id;
        this.name = name;
        this.begintime = begintime;
        this.endtime = endtime;
        this.ifjoin = ifjoin;
        this.memberid = memberid;
        this.site = site;
        this.itrdc = itrdc;
        this.schoolname = schoolname;
        this.clubname = clubname;
        this.type = type;
    }

    public String getSchoolname() {
        return schoolname;
    }

    public void setSchoolname(String schoolname) {
        this.schoolname = schoolname;
    }

    public String getClubname() {
        return clubname;
    }

    public void setClubname(String clubname) {
        this.clubname = clubname;
    }

    public String getClubid() {
        return clubid;
    }

    public void setClubid(String clubid) {
        this.clubid = clubid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBegintime() {
        return begintime;
    }

    public void setBegintime(String begintime) {
        this.begintime = begintime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public Integer getIfjoin() {
        return ifjoin;
    }

    public void setIfjoin(Integer ifjoin) {
        this.ifjoin = ifjoin;
    }

    public ArrayList<String> getMemberid() {
        return memberid;
    }

    public void setMemberid(ArrayList<String> memberid) {
        this.memberid = memberid;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public String getItrdc() {
        return itrdc;
    }

    public void setItrdc(String itrdc) {
        this.itrdc = itrdc;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Activity{" +
                "clubid='" + clubid + '\'' +
                ", id=" + id +
                ", name='" + name + '\'' +
                ", begintime='" + begintime + '\'' +
                ", endtime='" + endtime + '\'' +
                ", ifjoin=" + ifjoin +
                ", memberid=" + memberid +
                ", site='" + site + '\'' +
                ", itrdc='" + itrdc + '\'' +
                ", schoolname='" + schoolname + '\'' +
                ", clubname='" + clubname + '\'' +
                ", type=" + type +
                '}';
    }
}
