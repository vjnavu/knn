package vn.gov.knn.admin.certificate.cert3;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface Cert3Mapper {
    Integer countByCert2(String cert2Seq);

    int addCert3P(Cert3 cert3);

    List<Cert3> getListByCert2Seq(Cert3 cert3);

    int updateDelByCert1(String cert1Seq);

    int updateDelByCert2(String cert2Seq);

    int updateDelBySeq(String cert3Seq);

    List<Cert3> getListByCert1Seq(String cert1Seq);

    Cert3 getCert3BySeq(String cert3Seq);

    int UpdateCert3(Cert3 cert3);

    int countTotalCert3();

    int countActiveCert3();

    List<Cert3> getListCert3(Cert3 catSearch);

    int countCert3(Cert3 catSearch);

    List<Cert3> getAll();
}
