package vn.gov.knn.admin.admin;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Admin extends Paging {
    private int ad_seq;
    private String ad_email;
    private String ad_pw;
    private String ad_name;
    private String ad_phone;
    private String ad_status;
    private int ad_role;
    private String ad_memo;
    private Date ad_reg_dt;
    private Date ad_mod_dt;
    private Date ad_last_login;
    private int ad_login_fail;
    private int ad_agency_seq;
    private int ad_profile_picture;

    private String ad_avatar_uuid;

}
