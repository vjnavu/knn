package vn.gov.knn.admin.certificate.cert1;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.gov.knn.admin.certificate.cert2.Cert2Service;
import vn.gov.knn.admin.certificate.cert3.Cert3Service;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;

import java.util.ArrayList;
import java.util.List;

@Service
public class Cert1Service {
    @Autowired
    private Cert1Mapper cert1Mapper;
    @Autowired
    private Cert2Service cert2Service;
    @Autowired
    private Cert3Service cert3Service;
    @Autowired
    private FileService fileService;

    public List<Cert1> getListCert1(Cert1 cert1) {
        cert1.setOffset((cert1.getPage() - 1) * cert1.getSize());
        return cert1Mapper.getListCert1(cert1);
    }

    public int countCert1(Cert1 cert1) {
        return cert1Mapper.countCert1(cert1);
    }

    public int addCert1Post(Cert1 cert1, MultipartFile file) throws Exception {
        int savedFileSeq = 0;
        if (file != null) {
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/certificate/cert1/");
            fileService.saveFile(file, fileVO);
            savedFileSeq = fileVO.getFile_seq();
        }
        cert1.setCert1_icon(savedFileSeq);
        String seq = this.genSeq();
        cert1.setCert1_seq(seq);
        int saveCert1 = cert1Mapper.addCert1Post(cert1);
        while (saveCert1 <= 0) {
            cert1.setCert1_seq(this.genSeq());
            saveCert1 = cert1Mapper.addCert1Post(cert1);
        }
        return saveCert1;
    }

    private String genSeq() {
        String seq = "";
        Integer code = cert1Mapper.countSeq();
        if (code == 0) {
            seq = "SQ01";
        } else {
            String number = String.valueOf(code + 1);
            if (number.length() == 1) {
                seq = "SQ0" + number;
            } else {
                seq = "SQ" + number;
            }
        }
        return seq;
    }

    public List<Cert1> getAll() {
        return cert1Mapper.getAll();
    }

    public Cert1 getCert1BySeq(String cert1Seq) {
        return cert1Mapper.getCert1BySeq(cert1Seq);
    }

    public int deleteCert1(String cert1Seq) {

        int deleteCert2 = cert2Service.updateDelByCert1(cert1Seq);
        int deleteCert3 = cert3Service.updateDelByCert1(cert1Seq);
        if (deleteCert2 > 0 && deleteCert3 > 0) {
            return cert1Mapper.deleteCert1(cert1Seq);
        } else {
            return 0;
        }
    }

    public int updateCert1P(Cert1 cert1, MultipartFile file) throws Exception {
        Cert1 oldCert1 = this.getCert1BySeq(cert1.getCert1_seq());
        if (file != null && !file.isEmpty()) {
            boolean deleteOldFile = fileService.deleteFileBySeq(oldCert1.getCert1_icon());
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/certificate/cert1/");
            fileService.saveFile(file, fileVO);
            cert1.setCert1_icon(fileVO.getFile_seq());
        } else {
            cert1.setCert1_icon(oldCert1.getCert1_icon());
        }

        return cert1Mapper.updateCert1P(cert1);
    }

    public List<List<Cert1>> getCerByNumber(int number) {
        List<List<Cert1>> cert1s = new ArrayList<>();
        List<Cert1> cert1List = cert1Mapper.getAll();
        List<Cert1> tmp = new ArrayList<>();
        for (int i = 0; i < cert1List.size(); i++) {
            if (tmp.size() < 8) {
                if (i == cert1List.size() - 1) {
                    tmp.add(cert1List.get(i));
                    cert1s.add(tmp);
                } else {
                    tmp.add(cert1List.get(i));
                }
            } else {
                cert1s.add(tmp);
                tmp = new ArrayList<>();
            }
        }
        return cert1s;
    }


    public List<Cert1> getAllByStatus(Cert1 cert1) {
        return cert1Mapper.getAllByStatus(cert1);
    }

    public int countTotalCert1() {
        return cert1Mapper.countTotalCert1();
    }

    public int countActiveCert1() {
        return cert1Mapper.countActiveCert1();
    }
}
