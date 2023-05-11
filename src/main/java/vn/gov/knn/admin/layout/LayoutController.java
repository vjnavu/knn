package vn.gov.knn.admin.layout;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.support.CurrentUser;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
public class LayoutController extends CurrentUser {
    @Autowired
    private LayoutService layoutService;

    @GetMapping(value = "/cms/layout")
    public String listLayout(
            Model model,
            @ModelAttribute("layoutSearch") Layout layoutSearch) {
        super.updateRoleSession();

        int quantilyLayout = layoutService.countLayout(new Layout());
        List<Layout> layoutList = layoutService.getAllLayout(layoutSearch);
        model.addAttribute("layoutList", layoutList);
        model.addAttribute("quantilyLayout", quantilyLayout);
        return "/vn/admin/layout/list";
    }

    @GetMapping(value = "/cms/layout/new")
    public String newLayout(
            Model model, @ModelAttribute("layoutForm") Layout layoutForm) {
        super.updateRoleSession();
        layoutForm.setLo_display_tf(true);
        model.addAttribute("formAction", "new");
        return "/vn/admin/layout/form";
    }

    @PostMapping(value = "/cms/layout/new")
    public String saveNewLayout(
            HttpServletRequest request,
            RedirectAttributes redirectAttributes,
            @ModelAttribute("layoutForm") Layout layoutForm,
            @RequestParam("lo_file") MultipartFile lo_file)
            throws Exception {
        Admin currentUser = (Admin) request.getSession().getAttribute("CurrentUser");
        layoutForm.setLo_reg_adm(currentUser.getAd_seq());
        layoutForm.setLo_reg_dt(new Date());
        if (layoutForm.isLo_target_blank_tf()) layoutForm.setLo_target_blank("Y");
        else layoutForm.setLo_target_blank("N");
        if (layoutForm.isLo_display_tf()) layoutForm.setLo_display("Y");
        else layoutForm.setLo_display("N");
        int saveResult = layoutService.saveNewLayout(layoutForm, lo_file);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm mới thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi chỉnh sửa");
        }
        return "redirect:/cms/layout";
    }

    @GetMapping(value = "/cms/layout/update/{loSeq}")
    public String getUpdateLayout(@PathVariable Integer loSeq, Model model) {
        super.updateRoleSession();
        Layout layoutForm = layoutService.getLayoutBySeq(loSeq);
        if (layoutForm.getLo_target_blank().equals("Y")) layoutForm.setLo_target_blank_tf(true);
        else layoutForm.setLo_target_blank_tf(false);
        if (layoutForm.getLo_display().equals("Y")) layoutForm.setLo_display_tf(true);
        else layoutForm.setLo_display_tf(false);
        model.addAttribute("layoutForm", layoutForm);
        model.addAttribute("formAction", "update");
        return "/vn/admin/layout/form";
    }

    @PostMapping(value = "/cms/layout/update")
    public String updateLayout(
            @ModelAttribute("layoutForm") Layout layoutForm,
            @RequestParam("lo_file") MultipartFile lo_file,
            RedirectAttributes redirectAttributes)
            throws Exception {
        Admin currentUser = (Admin) request.getSession().getAttribute("CurrentUser");
        layoutForm.setLo_mod_dt(new Date());
        layoutForm.setLo_mod_adm(currentUser.getAd_seq());
        if (layoutForm.isLo_target_blank_tf()) layoutForm.setLo_target_blank("Y");
        else layoutForm.setLo_target_blank("N");
        if (layoutForm.isLo_display_tf()) layoutForm.setLo_display("Y");
        else layoutForm.setLo_display("N");
        int result = layoutService.updateLayout(layoutForm, lo_file);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Chỉnh sửa thông tin layout thành công");
        } else {
            redirectAttributes.addFlashAttribute(
                    "errorMess", "Đã xảy ra lỗi khi chỉnh sửa thông tin layout");
        }
        return "redirect:/cms/layout";
    }

    @GetMapping(value = "/cms/layout/delete/{loSeq}")
    public String deleteOneLayout(@PathVariable int loSeq)
            throws IOException {
        super.updateRoleSession();
        layoutService.deleteLayout(loSeq);
        return "redirect:/cms/layout";
    }
}
