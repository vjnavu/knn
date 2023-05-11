package vn.gov.knn.admin.certificate.cert3;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Cert3 extends Paging {
    private String cert3_seq;
    private String cert1_seq;
    private String cert2_seq;
    private String cert3_name;
    private String cert3_desc;
    private int cert3_sort;
    private String cert3_level;
    private String cert3_display;
    private Date cert3_reg_dt;
    private Date cert3_mod_dt;
    private String cert3_delete;

    private boolean cert3_display_tf;
    private String cert2_name;
    private String cert1_name;
}
