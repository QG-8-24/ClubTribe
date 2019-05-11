package clubtribe.pojo;

public class User {
    private Integer userid;
    private String username;
    private String useremail;
    private String password;
    private String cludids;


    public User() {
        super();
    }

    public User(Integer userid, String username, String useremail, String password, String cludids) {
        this.userid = userid;
        this.username = username;
        this.useremail = useremail;
        this.password = password;
        this.cludids = cludids;
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

    public String getCludids() {
        return cludids;
    }

    public void setCludids(String cludids) {
        this.cludids = cludids;
    }

    @Override
    public String toString() {
        return "User{" +
                "userid=" + userid +
                ", username='" + username + '\'' +
                ", useremail='" + useremail + '\'' +
                ", password='" + password + '\'' +
                ", cludids='" + cludids + '\'' +
                '}';
    }
}
