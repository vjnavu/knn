package vn.gov.knn.admin.file;

import lombok.Data;

import java.util.Date;

@Data
public class FileVO {
    private int file_seq;
    private String target_dir;
    private String file_uuid;
    private String file_name;
    private String file_ext;
    private String file_type;
    private String file_path;
    private int file_size;
    private Date file_reg_dtm;
    private int post_seq;
}
