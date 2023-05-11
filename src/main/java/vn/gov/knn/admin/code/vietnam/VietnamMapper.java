
package vn.gov.knn.admin.code.vietnam;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface VietnamMapper {
    List<Vietnam> getProvinceList(Vietnam vietnam);

    List<Vietnam> getDistrictListByProSeq(Integer proSeq);

    List<Vietnam> getCommunesListByProSeq(Integer disSeq);
}
