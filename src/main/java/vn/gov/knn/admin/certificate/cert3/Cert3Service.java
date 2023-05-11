package vn.gov.knn.admin.certificate.cert3;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Cert3Service {
    @Autowired
    private Cert3Mapper cert3Mapper;

    public int addCert3P(Cert3 cert3) {
        String seq = this.genSeq(cert3.getCert2_seq());
        cert3.setCert3_seq(seq);
        int saveCert3 = cert3Mapper.addCert3P(cert3);
        while (saveCert3 <= 0) {
            cert3.setCert3_seq(this.genSeq(cert3.getCert2_seq()));
            saveCert3 = cert3Mapper.addCert3P(cert3);
        }
        return saveCert3;
    }

    public String genSeq(String cert2Seq) {
        String seq = cert2Seq;
        Integer code = cert3Mapper.countByCert2(cert2Seq);
        if (code == 0) {
            seq = seq + "01";
        } else {
            String number = String.valueOf(code + 1);
            if (number.length() == 1) {
                seq = seq + "0" + number;
            } else {
                seq = seq + number;
            }
        }
        return seq;
    }

    public List<Cert3> getListByCert2Seq(Cert3 search) {
        return cert3Mapper.getListByCert2Seq(search);
    }

    public int updateDelByCert1(String cert1Seq) {
        List<Cert3> cert3s = cert3Mapper.getListByCert1Seq(cert1Seq);
        if (cert3s.size() > 0) {
            return cert3Mapper.updateDelByCert1(cert1Seq);
        } else {
            return 1;
        }
    }

    public int updateDelByCert2(String cert2Seq) {
        Cert3 cert3 = new Cert3();
        cert3.setCert2_seq(cert2Seq);
        List<Cert3> cert3s = cert3Mapper.getListByCert2Seq(cert3);
        if (cert3s.size() > 0) {
            return cert3Mapper.updateDelByCert2(cert2Seq);
        } else {
            return 1;
        }
    }

    public int updateDelBySeq(String cert3Seq) {
        return cert3Mapper.updateDelBySeq(cert3Seq);
    }

    public Cert3 getCert3BySeq(String cert3Seq) {
        return cert3Mapper.getCert3BySeq(cert3Seq);
    }

    public int UpdateCert3(Cert3 cert3) {
        return cert3Mapper.UpdateCert3(cert3);
    }

    public int countTotalCert3() {
        return cert3Mapper.countTotalCert3();
    }

    public int countActiveCert3() {
        return cert3Mapper.countActiveCert3();
    }

    public List<Cert3> getListCert3(Cert3 catSearch) {
        return cert3Mapper.getListCert3(catSearch);
    }

    public int countCert3(Cert3 catSearch) {
        return cert3Mapper.countCert3(catSearch);
    }

    public List<Cert3> getAll() {
        return cert3Mapper.getAll();
    }
}
