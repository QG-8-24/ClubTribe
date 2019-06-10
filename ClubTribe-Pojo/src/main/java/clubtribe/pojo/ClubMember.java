package clubtribe.pojo;

/**
 * 社团成员类
 */
public class ClubMember {
    private String clubid;
    private String userid;
    private String username;
    private String sign;
    private String msign;
    private Integer ifadmin;

    public ClubMember() {
        super();
    }


    public ClubMember(String clubid, String userid, String username, String sign, String msign, Integer ifadmin) {
        this.clubid = clubid;
        this.userid = userid;
        this.username = username;
        this.sign = sign;
        this.msign = msign;
        this.ifadmin = ifadmin;
    }

    public Integer getIfadmin() {
        return ifadmin;
    }

    public void setIfadmin(Integer ifadmin) {
        this.ifadmin = ifadmin;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getClubid() {
        return clubid;
    }

    public void setClubid(String clubid) {
        this.clubid = clubid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getMsign() {
        return msign;
    }

    public void setMsign(String msign) {
        this.msign = msign;
    }

    @Override
    public String toString() {
        return "ClubMember{" +
                "clubid='" + clubid + '\'' +
                ", userid='" + userid + '\'' +
                ", username='" + username + '\'' +
                ", sign='" + sign + '\'' +
                ", msign='" + msign + '\'' +
                '}';
    }
}
