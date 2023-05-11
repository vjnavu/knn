package vn.gov.knn.admin.exam;

import lombok.Data;
import vn.gov.knn.admin.album.Album;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;
import java.util.List;

@Data
public class Exam extends Paging {
    private int exam_seq;
    private String exam_name;/* tên kỳ thi*/
    private String exam_type;/*loại kỳ thi: Kỳ thi quốc gia = VN, Kỳ thi quốc tế = IN*/
    private int exam_logo;/*Logo kỳ thi*/
    private String exam_desc;/*mô tả*/
    private String exam_place;/*địa điểm thi*/
    private Date exam_start_dt;/*từ ngày*/
    private Date exam_end_dt;/*đến ngày*/
    private String exam_cert;/*Cert2_seq. Thêm đc nhiều cấp (Ví dụ: SQ0101, SQ0102, ...)*/
    private int exam_candi;/*file danh sách thí sinh dự thi*/
    private String exam_display;
    private Date exam_regis;
    private Date exam_mod_dt;

    /*addtribute tranfer data*/
    private String exam_logo_uuid;
    private String exam_candi_uuid;
    private String candi_name;
    private String start_date;
    private String end_date;
    private String exam_cert_name;
    private Boolean exam_display_tf;
    //    private String album_name;
    private List<Album> album;
}

