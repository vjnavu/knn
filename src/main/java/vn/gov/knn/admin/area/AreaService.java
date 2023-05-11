/*
  User: VTA
  Date: 8/18/2021 1:54 PM
*/
package vn.gov.knn.admin.area;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AreaService {
    @Autowired
    private AreaMapper areaMapper;
    public List<Area> getProvinceList(Area area){
        return areaMapper.getProvinceList(area);
    }
    public int countProvinceList(Area area){
        return areaMapper.countProvinceList(area);
    }
    public List<Area> getDistrictListByProSeq(Area area){
        return areaMapper.getDistrictListByProSeq(area);
    }
    public int countDistrictByProSeq(Area area){
        return areaMapper.countDistrictByProSeq(area);
    }
    public List<Area> getCommunesListByDisSeq(Area area){
        return  areaMapper.getCommunesListByDisSeq(area);
    }
    public int countCommunesByProSeq(Area area){
        return areaMapper.countCommunesByProSeq(area);
    }
}
