package vn.gov.knn.admin.certificate.cert1;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Cert1 extends Paging {
    private String cert1_seq;
    private String cert1_name;
    private int cert1_icon;
    private int cert1_sort;
    private String cert1_display;
    private Date cert1_reg_dt;
    private Date cert1_mod_dt;
    private String cert1_delete;

    private int cert3_quantity;
    private boolean cert1_display_tf;
    private String cert1_icon_uuid;
}
