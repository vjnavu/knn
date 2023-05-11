package vn.gov.knn.admin.candidate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.certificate.cert2.Cert2;
import vn.gov.knn.admin.certificate.cert2.Cert2Service;
import vn.gov.knn.admin.exam.Exam;
import vn.gov.knn.admin.exam.ExamService;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class CandidateController extends CurrentUser {
    @Autowired
    private CandidateService candidateService;

    @Autowired
    private ExamService examService;

    @Autowired
    private Cert2Service cert2Service;

    @GetMapping(value = "/cms/candidate")
    public String getCandidate(@ModelAttribute(value = "candidateSearch") Candidate candidate,
                               Model model) {
        super.updateRoleSession();
        List<Candidate> candidates = candidateService.getListCandidate(candidate);
        int countCandidate = candidateService.countAllCandidate(candidate);
        Pagination pagination = new Pagination();
        model.addAttribute("paging", pagination.createPagingString(candidate.getPage(), candidate.getSize(), countCandidate));
        model.addAttribute("candidates", candidates);
        return "/vn/admin/candidate/list";
    }

    @GetMapping(value = "/cms/candidate/new")
    public String newCandidate(Model model) {
        super.updateRoleSession();
        List<Exam> exams = examService.getAllExam();
        model.addAttribute("candidateForm", new Candidate());
        model.addAttribute("formAction", "new");
        model.addAttribute("exams", exams);
        return "/vn/admin/candidate/form";
    }

    @PostMapping(value = "/cms/candidate/new")
    public String saveCandidate(
            RedirectAttributes redirectAttributes,
            @ModelAttribute("candidateForm") Candidate candidateForm,
            @RequestParam(value = "avatar") MultipartFile file,
            @RequestParam(value = "birthday") String cdd_birthday
    )
            throws Exception {
        Date regDateConvert = new SimpleDateFormat("yyyy-MM-dd").parse(cdd_birthday);
        candidateForm.setCdd_birthday(regDateConvert);
        int saveResult = candidateService.saveNewCandidate(candidateForm, file);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm thí sinh mới thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi chỉnh sửa");
        }
        return "redirect:/cms/candidate";
    }

    @GetMapping(value = "/cms/candidate/delete/{candidateSeq}")
    public String deleteCandidate(@PathVariable int candidateSeq,
                                  RedirectAttributes redirectAttributes) throws IOException {
        int deleteCandidate = candidateService.deleteCandidate(candidateSeq);
        if (deleteCandidate > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Xoá thí sinh thành công");
        } else redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi xoá thí sinh");

        return "redirect:/cms/candidate";
    }

    @GetMapping("/cms/candidate/cert2s")
    @ResponseBody
    public List<Cert2> getListByExam(@RequestParam(value = "exam_seq") int exam_seq) {
        List<Cert2> cert2s = new ArrayList<>();
        Exam exam = examService.getExamBySeq(exam_seq);
        String certString = exam.getExam_cert();
        String arrCert[] = certString.split(",");
        if (arrCert.length > 0) {
            for (int i = 0; i < arrCert.length; i++) {
                cert2s.add(cert2Service.getCert2BySeq(arrCert[i]));
            }
        }
        return cert2s;
    }

    @GetMapping(value = "/cms/candidate/update/{cddSeq}")
    public String updateCandidate(@PathVariable int cddSeq,
                                  Model model) {
        Candidate candidate = candidateService.getCandidateBySeq(cddSeq);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String birthday = formatter.format(candidate.getCdd_birthday());
        candidate.setBirthday_tf(birthday);
        List<Exam> exams = examService.getAllExam();
        List<Cert2> cert2s = cert2Service.getCert2ByExam(candidate.getExam_seq());


        model.addAttribute("candidateForm", candidate);
        model.addAttribute("exams", exams);
        model.addAttribute("formAction", "update");
        model.addAttribute("cert2s", cert2s);
        return "/vn/admin/candidate/form";
    }

    @PostMapping(value = "/cms/candidate/update")
    public String updateSave(@ModelAttribute(value = "candidateForm") Candidate candidate,
                             @RequestParam(value = "avatar") MultipartFile file,
                             @RequestParam(value = "birthday") String cdd_birthday,
                             RedirectAttributes redirectAttributes
    ) throws Exception {
        Date regDateConvert = new SimpleDateFormat("yyyy-MM-dd").parse(cdd_birthday);
        candidate.setCdd_birthday(regDateConvert);
        int updateResult = candidateService.updateSave(candidate, file);
        if (updateResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi cập nhật");
        }
        return "redirect:/cms/candidate";
    }
}
