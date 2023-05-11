package vn.gov.knn.user.search;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Search extends Paging {
    private int seq;
    private String title_vn;
    private String title_en;
    private String text_vn;
    private String text_en;
    private String type;
    private Date reg_dt;
}
