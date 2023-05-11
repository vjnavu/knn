package vn.gov.knn.admin.album;

import lombok.Data;
import vn.gov.knn.admin.file.FileVO;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;
import java.util.List;

@Data
public class Album extends Paging {
    private int album_seq;
    private String album_name;
    private String album_img;
    private int exam_seq;
    private Date album_regis;
    private Date album_mod_dt;

    private String exam_name;
    private List<FileVO> album;
}
