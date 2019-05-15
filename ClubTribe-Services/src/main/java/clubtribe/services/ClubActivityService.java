package clubtribe.services;

import java.util.List;

public interface ClubActivityService {
    String queryClubidsByUserid(String userid);

    List<String> queryClubsByClubid(String clubid);
}
