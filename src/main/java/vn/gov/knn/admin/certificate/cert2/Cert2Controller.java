package vn.gov.knn.admin.certificate.cert2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.certificate.cert1.Cert1;
import vn.gov.knn.admin.certificate.cert1.Cert1Service;
import vn.gov.knn.admin.support.CurrentUser;

import java.util.Date;
import java.util.List;

@Controller
public class Cert2Controller extends CurrentUser {
    @Autowired
    private Cert1Service cert1Service;
    @Autowired
    private Cert2Service cert2Service;

    @GetMapping(value = "/cms/certificate/cert1/new/{cert1Seq}")
    public String addCert2G(@PathVariable String cert1Seq,
                            Model model) {
        super.updateRoleSession();
        Cert2 cert2 = new Cert2();
        cert2.setCert1_seq(cert1Seq);
        Cert1 cert1 = cert1Service.getCert1BySeq(cert1Seq);
        List<Cert1> cert1s = cert1Service.getAll();
        cert2.setCert2_display_tf(true);
        model.addAttribute("cert2", cert2);
        model.addAttribute("cert1s", cert1s);
        model.addAttribute("name", cert1.getCert1_name());
        model.addAttribute("action", "new");
        return "/vn/admin/certificate/category/form-cert2";
    }

    @PostMapping(value = "/cms/certificate/cert1/new")
    public String addCert2P(@ModelAttribute(value = "cert2") Cert2 cert2,
                            RedirectAttributes redirectAttributes) {
        if (cert2.isCert2_display_tf()) cert2.setCert2_display("Y");
        else cert2.setCert2_display("N");
        cert2.setCert2_reg_dt(new Date());
        int saveResult = cert2Service.addCert2P(cert2);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm mới thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/certificate";
    }

    @GetMapping(value = "/cms/certificate/cert2/get")
    @ResponseBody
    public List<Cert2> getCert2ByCert1(@RequestParam(name = "cert1Seq") String cert1Seq) {
        Cert2 cert2 = new Cert2();
        cert2.setCert1_seq(cert1Seq);
        return cert2Service.getListCert2ByCert1(cert2);
    }

    @GetMapping(value = "/cms/certificate/delete/cert2/{cert2Seq}")
    public String deleteCert2(@PathVariable String cert2Seq,
                              RedirectAttributes redirectAttributes) {
        super.updateRoleSession();
        int delResult = cert2Service.deleteCert2(cert2Seq);
        if (delResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Xóa thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi xóa");
        }
        return "redirect:/cms/certificate";
    }

    @GetMapping(value = "/cms/certificate/cert2/update/{cert2Seq}")
    public String updateCert2G(@PathVariable String cert2Seq,
                               Model model) {
        super.updateRoleSession();
        List<Cert1> cert1s = cert1Service.getAll();
        Cert2 cert2 = cert2Service.getCert2BySeq(cert2Seq);
        if (cert2.getCert2_display().equals("Y")) cert2.setCert2_display_tf(true);
        else cert2.setCert2_display_tf(false);
        model.addAttribute("cert1s", cert1s);
        model.addAttribute("cert2", cert2);
        return "/vn/admin/certificate/category/Uform-cert2";
    }

    @PostMapping(value = "/cms/certificate/cert2/update")
    public String updateCert2P(@ModelAttribute(value = "cert2") Cert2 cert2,
                               RedirectAttributes redirectAttributes) {
        if (cert2.isCert2_display_tf()) cert2.setCert2_display("Y");
        else cert2.setCert2_display("N");
        cert2.setCert2_mod_dt(new Date());
        int updateResult = cert2Service.UpdateCert2(cert2);
        if (updateResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi Cập nhật");
        }
        return "redirect:/cms/certificate";
    }
}
