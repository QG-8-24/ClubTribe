public class ClubMember {
    private Integer mid;
    private String dsign;
    private int msign;

    public ClubMember() {
        super();
    }

    public ClubMember(Integer mid, String dsign, int msign) {
        this.mid = mid;
        this.dsign = dsign;
        this.msign = msign;
    }

    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    public String getDsign() {
        return dsign;
    }

    public void setDsign(String dsign) {
        this.dsign = dsign;
    }

    public int getMsign() {
        return msign;
    }

    public void setMsign(int msign) {
        this.msign = msign;
    }

    @Override
    public String toString() {
        return "ClubMember{" +
                "mid=" + mid +
                ", dsign='" + dsign + '\'' +
                ", msign=" + msign +
                '}';
    }
}
