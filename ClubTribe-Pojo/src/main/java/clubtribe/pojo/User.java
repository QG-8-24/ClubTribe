package clubtribe.pojo;

public class User {
    private Integer userid;
    private String username;
    private String useremail;
    private String password;
    private String clubids;

    public User(Integer userid, String username, String useremail, String password, String clubids) {
        this.userid = userid;
        this.username = username;
        this.useremail = useremail;
        this.password = password;
        this.clubids = clubids;
    }

    public User() {
        super();
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUseremail() {
        return useremail;
    }

    public void setUseremail(String useremail) {
        this.useremail = useremail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getClubids() {
        return clubids;
    }

    public void setClubids(String clubids) {
        this.clubids = clubids;
    }

    @Override
    public String toString() {
        return "User{" +
                "userid=" + userid +
                ", username='" + username + '\'' +
                ", useremail='" + useremail + '\'' +
                ", password='" + password + '\'' +
                ", clubids='" + clubids + '\'' +
                '}';
    }
}
