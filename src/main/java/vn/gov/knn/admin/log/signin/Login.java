package vn.gov.knn.admin.log.signin;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Login extends Paging {
    private int login_adm;
    private Date login_dt;
    private String login_ip;
    private String login_browser;
    private String login_os;

    private String login_adm_email;
    private String login_adm_name;
    private String login_date_format;
    private int login_adm_role;
}
