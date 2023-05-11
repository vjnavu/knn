/*
  User: VTA
  Date: 8/14/2021 11:26 AM
*/
package vn.gov.knn.admin.code.vietnam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VietnamService {
    @Autowired
    private VietnamMapper vietnamMapper;

    public List<Vietnam> getProvinceList(Vietnam vietnam){return vietnamMapper.getProvinceList(vietnam);}
    public List<Vietnam> getDistrictListByProSeq(Integer proSeq){return vietnamMapper.getDistrictListByProSeq(proSeq);}
    public List<Vietnam> getCommunesListByProSeq(Integer disSeq){return vietnamMapper.getCommunesListByProSeq(disSeq);}
}
