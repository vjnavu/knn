package vn.gov.knn.admin.visitor;

import lombok.Data;

import java.util.Date;

@Data
public class Visitor {
    private Date vs_dt;
    private Date vs_start_dt;
    private Date vs_end_dt;
    private int vs_total;
}
