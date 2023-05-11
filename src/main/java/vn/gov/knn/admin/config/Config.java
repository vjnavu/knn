package vn.gov.knn.admin.config;

import lombok.Data;

@Data
public class Config {
    private int config_logo;
    private String config_site_title;
    private String config_home_url;
    private String config_admin_url;
    private String config_email;
    private String config_phone;
    private String config_fax;
    private String config_addr;
    private String config_block_word;

    private String config_logo_uuid;
}
