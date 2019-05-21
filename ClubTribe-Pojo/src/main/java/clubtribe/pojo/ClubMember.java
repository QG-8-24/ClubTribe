package clubtribe.pojo;

/**
 * 社团成员类
 */
public class ClubMember {
    private String clubid;
    private String userid;
    private String sign;
    private String msign;

    public ClubMember() {
        super();
    }

    public ClubMember(String clubid, String userid, String sign, String msign) {
        this.clubid = clubid;
        this.userid = userid;
        this.sign = sign;
        this.msign = msign;
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
                ", sign='" + sign + '\'' +
                ", msign='" + msign + '\'' +
                '}';
    }
}
