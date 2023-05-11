package vn.gov.knn.admin.certificate.cert1;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface Cert1Mapper {
    List<Cert1> getListCert1(Cert1 cert1);

    int countCert1(Cert1 cert1);

    int countAll();
    int countSeq();

    int addCert1Post(Cert1 cert1);

    List<Cert1> getAll();

    Cert1 getCert1BySeq(String seq);

    int deleteCert1(String cert1Seq);

    int updateCert1P(Cert1 cert1);

    List<Cert1> getAllByStatus(Cert1 cert1);

    int countTotalCert1();

    int countActiveCert1();

}
