package vn.gov.knn.admin.certificate.cert2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.gov.knn.admin.certificate.cert3.Cert3Service;
import vn.gov.knn.admin.exam.Exam;
import vn.gov.knn.admin.exam.ExamService;

import java.util.ArrayList;
import java.util.List;

@Service
public class Cert2Service {
    @Autowired
    private Cert2Mapper cert2Mapper;
    @Autowired
    private Cert3Service cert3Service;

    @Autowired
    private ExamService examService;

    public List<Cert2> getListCert2ByCert1(Cert2 cert2) {
        return cert2Mapper.getListCert2ByCert1(cert2);
    }

    public int addCert2P(Cert2 cert2) {
        String seq = this.genSeq(cert2.getCert1_seq());
        cert2.setCert2_seq(seq);
        int saveCert2 = cert2Mapper.addCert2P(cert2);
        while (saveCert2 <= 0) {
            cert2.setCert2_seq(this.genSeq(cert2.getCert1_seq()));
            saveCert2 = cert2Mapper.addCert2P(cert2);
        }
        return saveCert2;
    }

    public String genSeq(String cert1Seq) {
        String seq = cert1Seq;
        Integer code = cert2Mapper.countByCert1(cert1Seq);
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

    public Cert2 getCert2BySeq(String cert1Seq) {
        return cert2Mapper.getCert2BySeq(cert1Seq);
    }

    public List<Cert2> getListCert2(Cert2 certificate) {
        certificate.setOffset((certificate.getPage() - 1) * certificate.getSize());
        return cert2Mapper.getListCert2(certificate);
    }

    public int countCert2(Cert2 cert2) {
        return cert2Mapper.countCert2(cert2);
    }

    public int updateDelByCert1(String cert1Seq) {
        Cert2 cert2 = new Cert2();
        cert2.setCert1_seq(cert1Seq);
        List<Cert2> cert2s = cert2Mapper.getListCert2ByCert1(cert2);
        if (cert2s.size() > 0) {
            return cert2Mapper.updateDelByCert1(cert1Seq);
        } else {
            return 1;
        }
    }

    public int deleteCert2(String cert2Seq) {
        int deleteCert3 = cert3Service.updateDelByCert2(cert2Seq);
        if (deleteCert3 > 0) return cert2Mapper.updateDelBySeq(cert2Seq);
        else return 0;
    }

    public int UpdateCert2(Cert2 cert2) {
        return cert2Mapper.UpdateCert2(cert2);
    }

    public int countTotalCert2() {
        return cert2Mapper.countTotalCert2();
    }

    public int countActiveCert2() {
        return cert2Mapper.countActiveCert2();
    }

    public List<Cert2> getAll() {
        return cert2Mapper.getAll();
    }

    public List<Cert2> getAllCert2ByCert1(String cert1Seq) {
        return cert2Mapper.getAllCert2ByCert1(cert1Seq);
    }

    public List<Cert2> getCert2ByExam(int exam_seq) {
        List<Cert2> cert2s = new ArrayList<>();
        Exam exam = examService.getExamBySeq(exam_seq);
        if (exam != null) {
            String certStr = exam.getExam_cert();
            if (certStr.length() > 0) {
                if (certStr.contains(",")) {
                    String certAr[] = certStr.split(",");
                    for (String s : certAr) {
                        Cert2 tmp = cert2Mapper.getCert2BySeq(s);
                        cert2s.add(tmp);
                    }
                    return cert2s;
                } else {
                    cert2s.add(cert2Mapper.getCert2BySeq(certStr));
                    return cert2s;
                }
            } else return null;
        } else {
            return null;
        }
    }
}
