package clubtribe.services;

import java.io.IOException;
import java.util.Map;

public interface UserServices_TYC {


    String userLogin(String username, String password);

    Integer userRegister(Map<String, String> usermap);

    String findPassword(String username);

    Integer findSchoolId(String schoolname, String schooladress);

    Integer auditRequest(String url, Map<String, String> map) throws IOException;

    Integer findclubId(String schoolname, String clubname);

    Integer auditRequest2(String url, Map<String, String> map) throws IOException;
}
