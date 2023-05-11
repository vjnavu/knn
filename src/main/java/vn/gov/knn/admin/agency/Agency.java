package vn.gov.knn.admin.agency;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

@Data
public class Agency extends Paging {
    private int ag_seq;
    private String ag_name_vn;
    private String ag_name_en;
    private int ag_addr1;
    private int ag_addr2;
    private int ag_addr3;
    private String ag_addr;
    private int ag_logo;
    private String ag_web;
    private String ag_email;
    private String ag_phone;
    private String ag_fax;
    private String ag_acti;
    private String ag_memo;

    private String addr1_name;
    private String addr2_name;
    private String addr3_name;
    private String ag_logo_file_uuid;
    private boolean ag_acti_tf;
}
