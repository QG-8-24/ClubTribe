package clubtribe.pojo;

/**
 * @author MQ
 * 社团集合类
 */
public class Clubs {
    private Integer schoolid;
    private String clubsid;
    private String clubname;
    private Integer perid;
    private String adminid;

    public Clubs() {
        super();
    }

    public Clubs(Integer schoolid, String clubsid, String clubname, Integer perid, String adminid) {
        this.schoolid = schoolid;
        this.clubsid = clubsid;
        this.clubname = clubname;
        this.perid = perid;
        this.adminid = adminid;
    }

    public Integer getSchoolid() {
        return schoolid;
    }

    public void setSchoolid(Integer schoolid) {
        this.schoolid = schoolid;
    }

    public String getClubsid() {
        return clubsid;
    }

    public void setClubsid(String clubsid) {
        this.clubsid = clubsid;
    }

    public String getClubname() {
        return clubname;
    }

    public void setClubname(String clubname) {
        this.clubname = clubname;
    }

    public Integer getPerid() {
        return perid;
    }

    public void setPerid(Integer perid) {
        this.perid = perid;
    }

    public String getAdminid() {
        return adminid;
    }

    public void setAdminid(String adminid) {
        this.adminid = adminid;
    }

    @Override
    public String toString() {
        return "Clubs{" +
                "schoolid=" + schoolid +
                ", clubsid='" + clubsid + '\'' +
                ", clubname='" + clubname + '\'' +
                ", perid=" + perid +
                ", adminid='" + adminid + '\'' +
                '}';
    }
}
