/*
  User: VTA
  Date: 8/18/2021 1:53 PM
*/
package vn.gov.knn.admin.area;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AreaMapper {
    List<Area> getProvinceList(Area area);
    int countProvinceList(Area area);
    List<Area> getDistrictListByProSeq(Area area);
    int countDistrictByProSeq(Area area);
    List<Area> getCommunesListByDisSeq(Area disSeq);
    int countCommunesByProSeq(Area area);
}
