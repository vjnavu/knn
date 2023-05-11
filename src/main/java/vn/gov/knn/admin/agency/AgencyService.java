package vn.gov.knn.admin.agency;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;

import java.util.List;

@Service
public class AgencyService {
    @Autowired
    private AgencyMapper agencyMapper;
    @Autowired
    private FileService fileService;

    public List<Agency> getAgencyList(Agency agency) {
        return agencyMapper.getAgencyList(agency);
    }

    public int countAgency(Agency agency) {
        return agencyMapper.countAgency(agency);
    }

    public List<Agency> getAllAgency() {
        return agencyMapper.getAllAgency();
    }


    public int saveNewAgency(Agency agency, MultipartFile file) throws Exception {
        int saveFile = 0;
        if (file != null && !file.isEmpty()) {
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/agency/");
            fileService.saveFile(file, fileVO);
            saveFile = fileVO.getFile_seq();
        }
        agency.setAg_logo(saveFile);
        return agencyMapper.saveNewAgency(agency);
    }

    public Agency getAgencyBySeq(Integer agSeq) {
        return agencyMapper.getAgencyBySeq(agSeq);
    }

    public int updateAgency(Agency agency, MultipartFile file) throws Exception {
        Agency getOldAgency = this.getAgencyBySeq(agency.getAg_seq());
        if (file != null && !file.isEmpty()) {
            boolean deleteOldFile = fileService.deleteFileBySeq(getOldAgency.getAg_logo());
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/agency/");
            fileService.saveFile(file, fileVO);
            agency.setAg_logo(fileVO.getFile_seq());
        } else {
            agency.setAg_logo(getOldAgency.getAg_logo());
        }
        return agencyMapper.updateAgency(agency);
    }

    public int deleteAgency(Integer agSeq) throws Exception {
        Agency getAgencyInfo = this.getAgencyBySeq(agSeq);
        fileService.deleteFileBySeq(getAgencyInfo.getAg_logo());
        return agencyMapper.deleteAgency(agSeq);
    }

    public List<Agency> getAgencyByLimit(int limit) {
        return agencyMapper.getAgencyByLimit(limit);
    }

    public int countTotalAgency() {
        return agencyMapper.countTotalAgency();
    }

    public int countActiveAgency() {
        return agencyMapper.countActiveAgency();
    }
}
