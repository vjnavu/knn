package vn.gov.knn.admin.code;

import lombok.Data;

import java.util.Date;

@Data
public class Code {
    private int code_seq;
    private String code_id;
    private String code_name;
    private int code_top1;
    private int code_top2;
    private Date code_reg_dt;
    private Date code_mod_dt;
    private String code_use_yn;
    private String code_desc;
}
