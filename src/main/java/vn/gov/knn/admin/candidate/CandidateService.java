package vn.gov.knn.admin.candidate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;

import java.io.IOException;
import java.util.List;

@Service
public class CandidateService {
    @Autowired
    CandidateMapper candidateMapper;

    @Autowired
    FileService fileService;

    public List<Candidate> getListCandidate(Candidate candidate) {
        return candidateMapper.getListCandidate(candidate);
    }

    public int countCandidate(Candidate candidate) {
        return candidateMapper.countCandidate(candidate);
    }

    public int saveNewCandidate(Candidate candidate, MultipartFile file) throws Exception {
        int saveFile = 0;
        if (file != null && !file.isEmpty()) {
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/candidate/");
            fileService.saveFile(file, fileVO);
            saveFile = fileVO.getFile_seq();
        }
        candidate.setCdd_avatar(saveFile);
        return candidateMapper.saveNewCandidate(candidate);
    }

    public Candidate getCandidateBySeq(int cddSeq) {
        return candidateMapper.getCandidateBySeq(cddSeq);
    }

    public int updateSave(Candidate candidate, MultipartFile file) throws Exception {
        Candidate candidateOld = candidateMapper.getCandidateBySeq(candidate.getCdd_seq());
        if (!file.isEmpty() && file != null) {
            fileService.deleteFileBySeq(candidateOld.getCdd_avatar());
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/candidate/");
            fileService.saveFile(file, fileVO);
            int saveFile = fileVO.getFile_seq();
            candidate.setCdd_avatar(saveFile);
        } else {
            candidate.setCdd_avatar(candidateOld.getCdd_avatar());
        }
        return candidateMapper.updateCandidate(candidate);
    }

    public int deleteCandidate(int candidateSeq) throws IOException {
        Candidate candidate = this.getCandidateBySeq(candidateSeq);
        if (candidate.getCdd_avatar() != 0) fileService.deleteFileBySeq(candidate.getCdd_avatar());
        return candidateMapper.deleteCandidate(candidateSeq);
    }

    public List<Candidate> getCddByExam(Candidate candidate) {
        return candidateMapper.getCddByExam(candidate);
    }

    public int countAllCandidate(Candidate candidate) {
        return candidateMapper.countAllCandidate(candidate);
    }
}
