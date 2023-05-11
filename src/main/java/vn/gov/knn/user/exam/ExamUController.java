package vn.gov.knn.user.exam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import vn.gov.knn.admin.album.Album;
import vn.gov.knn.admin.album.AlbumService;
import vn.gov.knn.admin.candidate.Candidate;
import vn.gov.knn.admin.candidate.CandidateService;
import vn.gov.knn.admin.certificate.cert2.Cert2;
import vn.gov.knn.admin.certificate.cert2.Cert2Service;
import vn.gov.knn.admin.exam.Exam;
import vn.gov.knn.admin.exam.ExamService;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;
import vn.gov.knn.admin.support.Pagination;
import vn.gov.knn.user.common.CommonService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class ExamUController {
    @Autowired
    private CommonService commonService;

    @Autowired
    private ExamService examService;

    @Autowired
    private FileService fileService;

    @Autowired
    private Cert2Service cert2Service;

    @Autowired
    private CandidateService candidateService;

    @Autowired
    private AlbumService albumService;

    @GetMapping(value = "/exam/{examType}")
    public String getExamList(Model model, @ModelAttribute(value = "examSearch") Exam exam,
                              @PathVariable String examType) {
        commonService.sentInfoWeb(model);
        exam.setExam_type(examType);
        List<Exam> exams = examService.getListExamByExamType(exam);
        int totalRow = examService.countExam(exam);
        int totalPage = 0;
        if (totalRow % 10 == 0) totalPage = (int) totalRow / 10;
        else totalPage = (int) totalRow / 10 + 1;
        Pagination pagination = new Pagination();

        model.addAttribute("paging", pagination.createPagingString(exam.getPage(), exam.getSize(), totalRow));
        model.addAttribute("exams", exams);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("examType", examType);

        return "/vn/user/exam/list";
    }

    @GetMapping(value = "/exam/view/{examSeq}")
    public String getExamView(Model model, @PathVariable int examSeq) {
        commonService.sentInfoWeb(model);
        Exam exam = examService.getExamBySeq(examSeq);
        List<Album> albums = albumService.getAlbumsByExamSeq(examSeq);

        if (albums.size() > 0) {
            for (Album album : albums) {
                List<FileVO> files = new ArrayList<>();
                if (album.getAlbum_img().length() > 0) {
                    int[] img = Arrays.stream(album.getAlbum_img().split(",")).mapToInt(Integer::parseInt).toArray();
                    if (img != null && img.length > 0) {
                        for (int i : img) {
                            FileVO fileVO = fileService.getUUIDFileBySeq(i);
                            files.add(fileVO);
                        }
                    }
                }
                album.setAlbum(files);
            }
        }

        model.addAttribute("albums", albums);
        model.addAttribute("exam", exam);
        return "/vn/user/exam/view";
    }

    @GetMapping(value = "/exam/view/cer/{examSeq}")
    public String getCerByExam(Model model, @PathVariable int examSeq) {
        commonService.sentInfoWeb(model);
        Exam exam = examService.getExamBySeq(examSeq);
        List<Cert2> cert2s = new ArrayList<>();
        if (exam.getExam_cert().contains(",")) {
            String[] certArr = exam.getExam_cert().split(",");
            for (String s : certArr) {
                cert2s.add(cert2Service.getCert2BySeq(s));
            }
        } else {
            cert2s.add(cert2Service.getCert2BySeq(exam.getExam_cert()));
        }

        model.addAttribute("exam", exam);
        model.addAttribute("cert2s", cert2s);
        return "/vn/user/exam/cer";
    }

    @GetMapping(value = "/exam/view/can/{examSeq}")
    public String getCddByExam(Model model,
                               @PathVariable int examSeq,
                               @ModelAttribute(value = "cddSearch") Candidate candidate) {
        commonService.sentInfoWeb(model);
        candidate.setExam_seq(examSeq);
        List<Candidate> candidates = candidateService.getCddByExam(candidate);
        Exam exam = examService.getExamBySeq(examSeq);
        Pagination pagination = new Pagination();
        int totalRow = candidateService.countCandidate(candidate);

        model.addAttribute("paging", pagination.createPagingString(candidate.getPage(), candidate.getSize(), totalRow));
        model.addAttribute("exam", exam);
        model.addAttribute("candidates", candidates);
        return "/vn/user/exam/cdd";
    }

}
