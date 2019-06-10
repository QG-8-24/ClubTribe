package clubtribe.pojo;

/**
 * @author MQ
 * 社团集合类
 */
public class Club {
    private Integer schoolid;
    private String clubid;
    private String clubname;
    private Integer perid;
    private String adminid;
    private String msgboard;
    private String notice;
    private String msg;
    private String album;
    private String sharefile;
    private String itrdc;

    public Club() {
        super();
    }

    public Club(Integer schoolid, String clubid, String clubname, Integer perid, String adminid, String msgboard, String notice, String msg, String album, String sharefile, String itrdc) {
        this.schoolid = schoolid;
        this.clubid = clubid;
        this.clubname = clubname;
        this.perid = perid;
        this.adminid = adminid;
        this.msgboard = msgboard;
        this.notice = notice;
        this.msg = msg;
        this.album = album;
        this.sharefile = sharefile;
        this.itrdc = itrdc;
    }

    public String getItrdc() {
        return itrdc;
    }

    public void setItrdc(String itrdc) {
        this.itrdc = itrdc;
    }

    public Integer getSchoolid() {
        return schoolid;
    }

    public void setSchoolid(Integer schoolid) {
        this.schoolid = schoolid;
    }

    public String getClubid() {
        return clubid;
    }

    public void setClubid(String clubid) {
        this.clubid = clubid;
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

    public String getMsgboard() {
        return msgboard;
    }

    public void setMsgboard(String msgboard) {
        this.msgboard = msgboard;
    }

    public String getNotice() {
        return notice;
    }

    public void setNotice(String notice) {
        this.notice = notice;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getAlbum() {
        return album;
    }

    public void setAlbum(String album) {
        this.album = album;
    }

    public String getSharefile() {
        return sharefile;
    }

    public void setSharefile(String sharefile) {
        this.sharefile = sharefile;
    }
}
