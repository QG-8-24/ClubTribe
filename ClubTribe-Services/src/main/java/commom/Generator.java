package commom;

import clubtribe.dao.UserMapper_TYC;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 工具类
 */
public class Generator {
    @Autowired
    private UserMapper_TYC userMapperTYC;

    /**
     * 生成9位随机数字
     * @return
     */
    public String gRanId()
    {
        String id=String.valueOf((int)(Math.random()*900000000+100000000));
        return id;
    }
}
