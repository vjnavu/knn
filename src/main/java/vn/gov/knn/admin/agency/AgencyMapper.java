package vn.gov.knn.admin.agency;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AgencyMapper {
    List<Agency> getAgencyList(Agency agency);

    int countAgency(Agency agency);

    int saveNewAgency(Agency agency);

    Agency getAgencyBySeq(Integer agSeq);

    int updateAgency(Agency agency);

    int deleteAgency(Integer agSeq);

    List<Agency> getAllAgency();

    List<Agency> getAgencyByLimit(int limit);

    int countTotalAgency();

    int countActiveAgency();
}
