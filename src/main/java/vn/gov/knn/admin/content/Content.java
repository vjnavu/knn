package vn.gov.knn.admin.content;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Content extends Paging {
    private int ctn_seq;
    private String ctn_title;
    private String ctn_text_vn;
    private String ctn_hyper_text_vn;
    private String ctn_text_en;
    private String ctn_hyper_text_en;
    private String ctn_display;
    private String ctn_delete;
    private int ctn_reg_adm;
    private Date ctn_reg_dt;
    private int ctn_mod_adm;
    private Date ctn_mod_dt;

    private boolean ctn_display_tf;
    private boolean ctn_delete_tf;
    private String ctn_reg_email;
    private String ctn_mod_email;
}
