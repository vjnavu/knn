package vn.gov.knn.admin.certificate.cert3;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.certificate.cert1.Cert1;
import vn.gov.knn.admin.certificate.cert1.Cert1Service;
import vn.gov.knn.admin.certificate.cert2.Cert2;
import vn.gov.knn.admin.certificate.cert2.Cert2Service;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import java.util.*;

@Controller
public class Cert3Controller extends CurrentUser {
    @Autowired
    private Cert1Service cert1Service;
    @Autowired
    private Cert2Service cert2Service;
    @Autowired
    private Cert3Service cert3Service;

    @GetMapping(value = "/cms/certificate/cert2/new/{cert2Seq}")
    public String addCert2G(@PathVariable String cert2Seq,
                            Model model) {
        super.updateRoleSession();
        Cert3 cert3 = new Cert3();
        cert3.setCert2_seq(cert2Seq);
        Cert2 cert2 = cert2Service.getCert2BySeq(cert2Seq);
        cert3.setCert1_seq(cert2.getCert1_seq());
        Cert1 cert1 = cert1Service.getCert1BySeq(cert2.getCert1_seq());
        cert3.setCert3_display_tf(true);
        model.addAttribute("nameCer1", cert1.getCert1_name());
        model.addAttribute("nameCer2", cert2.getCert2_name());
        model.addAttribute("cert3", cert3);
        model.addAttribute("action", "new");
        return "/vn/admin/certificate/category/form-cert3";
    }

    @PostMapping(value = "/cms/certificate/cert2/new")
    public String addCert2P(@ModelAttribute(value = "cert3") Cert3 cert3,
                            RedirectAttributes redirectAttributes) {
        if (cert3.isCert3_display_tf()) cert3.setCert3_display("Y");
        else cert3.setCert3_display("N");
        cert3.setCert3_reg_dt(new Date());

        if(cert3.getCert3_level().equals("")){
            cert3.setCert3_level(null);
        }

        int saveResult = cert3Service.addCert3P(cert3);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm mới thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/certificate/detail";
    }

    @GetMapping(value = "/cms/certificate/detail")
    public String getListCertificate(@ModelAttribute(value = "catSearch") Cert1 catSearch, Model model) {
        super.updateRoleSession();
        Map<Cert1, List<Cert3>> cats = new LinkedHashMap<>();
        catSearch.setSize(3);
        List<Cert1> cert1s = cert1Service.getListCert1(catSearch);
        for (Cert1 c1 : cert1s) {
            Cert2 search = new Cert2();
            search.setCert1_seq(c1.getCert1_seq());
            List<Cert2> cert2s = cert2Service.getListCert2ByCert1(search);
            if (cert2s.size() == 0) {
                cats.put(c1, new ArrayList<>());
            } else {
                List<Cert3> cert3s = new ArrayList<>();
                for (Cert2 c2 : cert2s) {
                    Cert3 searchC2 = new Cert3();
                    searchC2.setCert2_seq(c2.getCert2_seq());
                    searchC2.setKeyWord(catSearch.getKeyWord());
                    List<Cert3> tmp = cert3Service.getListByCert2Seq(searchC2);
                    cert3s.addAll(tmp);
                }
                cats.put(c1, cert3s);
            }
        }
        int totalRow = cert1Service.countCert1(catSearch);
        int totalCert3 = cert3Service.countTotalCert3();
        int activeCert3 = cert3Service.countActiveCert3();
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(catSearch.getPage(), catSearch.getSize(), totalRow));
        model.addAttribute("cats", cats);
        model.addAttribute("totalCert3", totalCert3);
        model.addAttribute("activeCert3", activeCert3);
        return "/vn/admin/certificate/detail/list";
    }

    @GetMapping(value = "/cms/certificate/cert3/new")
    public String addCert3G(Model model) {
        super.updateRoleSession();
        List<Cert1> cert1s = cert1Service.getAll();
        model.addAttribute("cert1s", cert1s);
        Cert3 cert3 = new Cert3();
        cert3.setCert3_display_tf(true);
        model.addAttribute("cert3", cert3);
        model.addAttribute("action", "new");
        return "/vn/admin/certificate/detail/form";
    }

    @PostMapping(value = "/cms/certificate/cert3/new")
    public String addCert3(RedirectAttributes redirectAttributes, @ModelAttribute("cert3") Cert3 cert3) {
        int saveResult = cert3Service.addCert3P(cert3);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm mới thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/certificate/detail";
    }

    @GetMapping(value = "/cms/certificate/delete/cert3/{cert3Seq}")
    public String deleteCert3(@PathVariable String cert3Seq,
                              RedirectAttributes redirectAttributes) {
        super.updateRoleSession();
        int delResult = cert3Service.updateDelBySeq(cert3Seq);
        if (delResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Xóa thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi xóa");
        }
        return "redirect:/cms/certificate/detail";
    }

    @GetMapping(value = "/cms/certificate/cert3/update/{cert3Seq}")
    public String updateCert3G(@PathVariable String cert3Seq,
                               Model model) {
        super.updateRoleSession();
        Cert3 cert3 = cert3Service.getCert3BySeq(cert3Seq);
        if (cert3.getCert3_display().equals("Y")) cert3.setCert3_display_tf(true);
        else cert3.setCert3_display_tf(false);
        List<Cert1> cert1s = cert1Service.getAll();
        Cert2 cert2 = new Cert2();
        cert2.setCert1_seq(cert3.getCert1_seq());
        List<Cert2> cert2s = cert2Service.getListCert2ByCert1(cert2);
        model.addAttribute("cert3", cert3);
        model.addAttribute("cert1s", cert1s);
        model.addAttribute("cert2s", cert2s);
        model.addAttribute("action", "update");
        return "/vn/admin/certificate/detail/form";
    }

    @PostMapping(value = "/cms/certificate/cert3/update")
    public String updateCert3P(@ModelAttribute(value = "cert3") Cert3 cert3,
                               RedirectAttributes redirectAttributes) {
        if (cert3.isCert3_display_tf()) cert3.setCert3_display("Y");
        else cert3.setCert3_display("N");
        cert3.setCert3_mod_dt(new Date());
        int updateResult = cert3Service.UpdateCert3(cert3);
        if (updateResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi Cập nhật");
        }
        return "redirect:/cms/certificate/detail";
    }
}
