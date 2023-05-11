package vn.gov.knn.admin.role;

import lombok.Data;

@Data
public class Role {
    private int role_seq;
    private int role_top;
    private String role_name;
    private String role_url;
    private int role_sort;
    private String role_admin_yn;
    private String role_dsd_yn;
    private String role_nsao_yn;
    private String role_icon;

    private String role_name_top;
    private int role_save;
}
