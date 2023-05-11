package vn.gov.knn.admin.certificate.cert2;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface Cert2Mapper {
    List<Cert2> getListCert2ByCert1(Cert2 cert2);

    int addCert2P(Cert2 cert2);

    Integer countByCert1(String cert1Seq);

    Cert2 getCert2BySeq(String cert1Seq);

    List<Cert2> getListCert2(Cert2 cert2);

    int countCert2(Cert2 cert2);

    int updateDelByCert1(String cert1Seq);

    int updateDelBySeq(String cert1Seq);

    int UpdateCert2(Cert2 cert2);

    int countTotalCert2();

    int countActiveCert2();

    List<Cert2> getAll();

    List<Cert2> getAllCert2ByCert1(String cert1Seq);
}
