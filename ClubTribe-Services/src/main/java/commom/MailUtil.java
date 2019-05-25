package commom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

/**
 * 邮件工具类
 */
public class MailUtil {
    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    private SimpleMailMessage simpleMailMessage;

    public JavaMailSender getMailSender() {
        return mailSender;
    }

    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public SimpleMailMessage getSimpleMailMessage() {
        return simpleMailMessage;
    }

    public void setSimpleMailMessage(SimpleMailMessage simpleMailMessage) {
        this.simpleMailMessage = simpleMailMessage;
    }

    /**
     * 发送邮件：
     * recipient：收件人
     * subject：主题
     * content：内容
     * @param recipient
     * @param subject
     * @param content
     * @return
     */
    public Integer send(String recipient,String subject,String content){
        System.out.println("r:"+recipient);
        simpleMailMessage.setTo(recipient);
        simpleMailMessage.setSubject(subject);
        simpleMailMessage.setText(content);
        mailSender.send(simpleMailMessage);
        return 1;
    }
}
