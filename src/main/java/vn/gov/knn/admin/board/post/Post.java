package vn.gov.knn.admin.board.post;

import lombok.Data;
import vn.gov.knn.admin.file.FileVO;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;
import java.util.List;

@Data
public class Post extends Paging {
    private int post_seq;
    private int board_seq;
    private String post_title_vn;
    private String post_title_en;
    private String post_desc_vn;
    private String post_desc_en;
    private String post_text_vn;
    private String post_hyper_text_vn;
    private String post_text_en;
    private String post_hyper_text_en;
    private String post_video_url;
    private String post_display;
    private int post_view_cnt;
    private int post_thumbnail;
    private String post_delete;
    private int post_reg_adm;
    private Date post_reg_dt;
    private int post_mod_adm;
    private Date post_mod_dt;

    private String post_avatar_uuid;
    private String post_reg_email;
    private String file_name;
    private String board_name;
    private String board_type;
    private String regis_name;
    private Boolean check_new;
    private boolean post_display_tf;
    private List<FileVO> fileVOList;
    private List<Integer> deleteFileSeqList;

    //For Document Type Board
    private String post_doc_dt; //Ngày ban hành
}
