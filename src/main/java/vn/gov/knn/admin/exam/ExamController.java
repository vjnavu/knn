package vn.gov.knn.admin.exam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.album.AlbumService;
import vn.gov.knn.admin.certificate.cert2.Cert2;
import vn.gov.knn.admin.certificate.cert2.Cert2Service;
import vn.gov.knn.admin.config.Config;
import vn.gov.knn.admin.config.ConfigService;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class ExamController extends CurrentUser {
    @Autowired
    private ExamService examService;
    @Autowired
    private Cert2Service cert2Service;
    @Autowired
    private FileService fileService;
    @Autowired
    private ConfigService configService;

    @Autowired
    private AlbumService albumService;

    @GetMapping(value = "/cms/exam")
    public String getExamList(@ModelAttribute(value = "examSearch") Exam exam,
                              Model model) {
        super.updateRoleSession();
        List<Exam> exams = examService.getListExam(exam);

        int totalRow = examService.countExam(exam);
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(exam.getPage(), exam.getSize(), totalRow));
        model.addAttribute("exams", exams);
        return "/vn/admin/exam/list";
    }

    @GetMapping(value = "/cms/exam/new")
    public String newExam(Model model) {
        List<Cert2> cert2s = cert2Service.getAll();
        this.getFilterWordAndFileExt(model);
        Exam exam = new Exam();
        exam.setExam_display_tf(true);
        model.addAttribute("exam", exam);
        model.addAttribute("cert2s", cert2s);
        model.addAttribute("action", "new");
        return "/vn/admin/exam/form";
    }

    @PostMapping("/cms/exam/new")
    public String saveNewExam(@ModelAttribute(value = "exam") Exam exam,
                              @RequestParam(name = "lo_file") MultipartFile avatar,
                              @RequestParam(name = "cdd_file") MultipartFile file,
                              RedirectAttributes redirectAttributes
    ) throws Exception {
        if (exam.getExam_display_tf()) exam.setExam_display("Y");
        else exam.setExam_display("N");
        exam.setExam_regis(new Date());
        if (avatar != null && !avatar.getOriginalFilename().equals("")) {
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/exam/avatar/");
            fileService.saveFile(avatar, fileVO);
            exam.setExam_logo(fileVO.getFile_seq());
        }
        if (file != null && !file.getOriginalFilename().equals("")) {
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/exam/attachment/");
            fileService.saveFile(file, fileVO);
            exam.setExam_candi(fileVO.getFile_seq());
        }

        int saveExam = examService.saveNewExam(exam);
        if (saveExam > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm kỳ thi thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi thêm kỳ thi");
        }
        return "redirect:/cms/exam";
    }

    @GetMapping("/cms/exam/delete/{examSeq}")
    public String delExam(@PathVariable int examSeq,
                          RedirectAttributes redirectAttributes) throws IOException {
        int delExam = examService.deleteExam(examSeq);
        if (delExam > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Xóa kỳ thi thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi xóa kỳ thi");
        }
        return "redirect:/cms/exam";
    }

    @GetMapping("/cms/exam/update/{examSeq}")
    public String updateExam(@PathVariable int examSeq,
                             Model model) {
        Exam exam = examService.getExamBySeq(examSeq);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String start_date = formatter.format(exam.getExam_start_dt());
        String end_date = formatter.format(exam.getExam_end_dt());
        exam.setStart_date(start_date);
        exam.setEnd_date(end_date);
        if (exam.getExam_display().equals("Y")) exam.setExam_display_tf(true);
        else exam.setExam_display_tf(false);
        List<Cert2> cert2s = cert2Service.getAll();
        if (exam.getExam_cert() != "" && exam.getExam_cert() != null) {
            String name = "";
            for (Cert2 cert2 : cert2s) {
                if (exam.getExam_cert().contains(cert2.getCert2_seq())) {
                    name = name + cert2.getCert2_name() + ",";
                }
            }
            if (!name.equals("")) {
                name = name.substring(0, name.length() - 1);
            }
            exam.setExam_cert_name(name);
        }

        model.addAttribute("exam", exam);
        model.addAttribute("cert2s", cert2s);
        model.addAttribute("action", "update");
        return "/vn/admin/exam/form";
    }

    @PostMapping("/cms/exam/update")
    public String updateExamSave(@ModelAttribute("exam") Exam exam,
                                 @RequestParam(name = "lo_file") MultipartFile avatar,
                                 @RequestParam(name = "cdd_file") MultipartFile file,
                                 RedirectAttributes redirectAttributes) throws Exception {
        Exam examOld = examService.getExamBySeq(exam.getExam_seq());
        if (avatar != null && !avatar.getOriginalFilename().equals("")) {
            fileService.deleteFileBySeq(examOld.getExam_logo());
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/exam/avatar/");
            fileService.saveFile(avatar, fileVO);
            exam.setExam_logo(fileVO.getFile_seq());
        } else {
            exam.setExam_logo(examOld.getExam_logo());
        }
        if (file != null && !file.getOriginalFilename().equals("")) {
            fileService.deleteFileBySeq(examOld.getExam_candi());
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/exam/attachment/");
            fileService.saveFile(file, fileVO);
            exam.setExam_candi(fileVO.getFile_seq());
        } else {
            exam.setExam_candi(examOld.getExam_candi());
        }

        if (exam.getExam_display_tf()) exam.setExam_display("Y");
        else exam.setExam_display("N");
        exam.setExam_mod_dt(new Date());
        int saveExam = examService.updateExam(exam);
        if (saveExam > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật kỳ thi thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi cập nhật kỳ thi");
        }
        return "redirect:/cms/exam";
    }

    private void getFilterWordAndFileExt(Model model) {
        Config setting = configService.getConfig();
        String wordFilter = setting.getConfig_block_word();
        if (wordFilter != null) {
            String[] arrFilter = wordFilter.split(",");
            model.addAttribute("wordFilter", arrFilter);
        }
    }
}
