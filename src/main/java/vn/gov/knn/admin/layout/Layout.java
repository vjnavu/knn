package vn.gov.knn.admin.layout;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Layout extends Paging {
    private int lo_seq;
    private String lo_type;
    private String lo_title;
    private String lo_descr;
    private String lo_link;
    private String lo_target_blank;
    private String lo_display;
    private int lo_sort;
    private int lo_img;
    private int lo_reg_adm;
    private Date lo_reg_dt;
    private int lo_mod_adm;
    private Date lo_mod_dt;

    private String lo_img_file_uuid;
    private boolean lo_target_blank_tf;
    private boolean lo_display_tf;
}
