package vn.gov.knn.admin.support;

import lombok.Data;

@Data
public class ApiResponse {
    private int resCode;
    private String resMess;
    private String resDetail;
}
