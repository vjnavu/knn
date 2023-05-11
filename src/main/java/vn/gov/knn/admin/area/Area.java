/*
  User: VTA
  Date: 8/18/2021 1:50 PM
*/
package vn.gov.knn.admin.area;

import vn.gov.knn.admin.support.Paging;

public class Area extends Paging {
    private int area_seq;
    private int area_foreign;
    private int area_order;
    private String area_type;
    private String area_name;
    private int area_under_count;

    public int getArea_seq() {
        return area_seq;
    }

    public void setArea_seq(int area_seq) {
        this.area_seq = area_seq;
    }

    public int getArea_foreign() {
        return area_foreign;
    }

    public void setArea_foreign(int area_foreign) {
        this.area_foreign = area_foreign;
    }

    public int getArea_order() {
        return area_order;
    }

    public void setArea_order(int area_order) {
        this.area_order = area_order;
    }

    public String getArea_type() {
        return area_type;
    }

    public void setArea_type(String area_type) {
        this.area_type = area_type;
    }

    public String getArea_name() {
        return area_name;
    }

    public void setArea_name(String area_name) {
        this.area_name = area_name;
    }

    public int getArea_under_count() {
        return area_under_count;
    }

    public void setArea_under_count(int area_under_count) {
        this.area_under_count = area_under_count;
    }
}
