package vn.gov.knn.admin.board.qa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class QAController extends CurrentUser {
    @Autowired
    private QAService qaService;

    @GetMapping(value = "/cms/qa")
    public String getQA(@ModelAttribute(value = "qa") QA qa,
                        Model model) {
        super.updateRoleSession();
        List<QA> qas = qaService.getListQa(qa);
        int totalRow = qaService.countQA(qa);
        int totalQa = qaService.countTotalQA();
        int nonReply = qaService.countNonReply();
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(qa.getPage(), qa.getSize(), totalRow));
        model.addAttribute("qas", qas);
        model.addAttribute("totalQa", totalQa);
        model.addAttribute("nonReply", nonReply);
        return "/vn/admin/board/qa/list";
    }

    @GetMapping(value = "/cms/qa/update/{qaSeq}")
    public String updateQAG(@PathVariable int qaSeq,
                            Model model) {
        QA qa = qaService.getQABySeq(qaSeq);
        model.addAttribute("qa", qa);
        return "/vn/admin/board/qa/form";
    }

    @PostMapping(value = "/cms/qa/update")
    public String updateQAP(@ModelAttribute(value = "qa") QA qa,
                            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        qa.setQa_answer_adm(admin.getAd_seq());
        qa.setQa_answer_dt(new Date());
        int saveResult = qaService.updateQA(qa);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/qa";
    }
}
