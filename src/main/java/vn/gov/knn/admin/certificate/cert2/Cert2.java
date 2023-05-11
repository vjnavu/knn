package vn.gov.knn.admin.certificate.cert2;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Cert2 extends Paging {
    private String cert2_seq;
    private String cert1_seq;
    private String cert2_name;
    private int cert2_sort;
    private String cert2_display;
    private Date cert2_reg_dt;
    private Date cert2_mod_dt;
    private String cert2_delete;

    private boolean cert2_display_tf;
}
