package vn.gov.knn.admin.menu;

import lombok.Data;

import java.util.Date;

@Data
public class Menu {
    private int mn_seq;
    private String mn_name_vn;
    private String mn_name_en;
    private String mn_link;
    private int mn_sort;
    private String mn_target_blank;
    private String mn_display_vn;
    private String mn_display_en;
    private int mn_top;
    private Date mn_reg_dt;
    private Date mn_mod_dt;

    private boolean mn_target_blank_tf;
    private boolean mn_display_vn_tf;
    private boolean mn_display_en_tf;
}
