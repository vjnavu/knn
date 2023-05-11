package vn.gov.knn.admin.candidate;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Candidate extends Paging {
    private int cdd_seq;
    private int exam_seq;
    private String cert2_seq;
    private int cdd_avatar;
    private String cdd_name;
    private String cdd_gender;
    private String cdd_position;
    private Date cdd_birthday;
    private String cdd_office;
    private String cdd_organize;
    private String cdd_exam_address;
    private String cdd_posi_organize;
    private float cdd_score;
    private int cdd_score_cis;
    private String cdd_award;
    private String exam_name;
    private String cdd_logo_uuid;
    private String cert2_name;
    private String birthday_tf;
}
