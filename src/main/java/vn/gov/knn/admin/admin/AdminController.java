package vn.gov.knn.admin.admin;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.agency.Agency;
import vn.gov.knn.admin.agency.AgencyService;
import vn.gov.knn.admin.log.signin.Login;
import vn.gov.knn.admin.log.signin.LoginService;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
public class AdminController extends CurrentUser {
    @Autowired
    private AdminService adminService;

    @Autowired
    private LoginService loginService;

    @Autowired
    private AgencyService agencyService;

    @GetMapping(value = "/cms/admin")
    public String getListAdmin(Model model, @ModelAttribute(value = "admin") Admin admin) {

        super.updateRoleSession();
        Admin adminForm = new Admin();
        model.addAttribute("adminForm", adminForm);
        List<Admin> adminList = adminService.getAdminList(admin);
        int totalAdmin = adminService.countTotalAdmin();
        int countSign = loginService.countSign(new Login());
        int activeMember = adminService.countActiveMember();

        int totalRow = adminService.countAdminPagin(admin);
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging",
                pagination.createPagingString(admin.getPage(), admin.getSize(), totalRow));
        model.addAttribute("adminList", adminList);
        model.addAttribute("countSign", countSign);
        model.addAttribute("totalAdmin", totalAdmin);
        model.addAttribute("activeMember", activeMember);
        List<Agency> agencyList = agencyService.getAllAgency();
        model.addAttribute("agencyList", agencyList);
        return "/vn/admin/admin/list";
    }

    @PostMapping(value = "/cms/admin/new")
    public String RegisterPost(
            @ModelAttribute("adminForm") Admin adminRegis,
            RedirectAttributes redirectAttributes,
            @RequestParam("ad_file") MultipartFile file)
            throws Exception {
        super.updateRoleSession();
        if (adminService.checkDupEmail(adminRegis.getAd_email())) {
            adminRegis.setAd_pw(BCrypt.hashpw(adminRegis.getAd_pw(), BCrypt.gensalt(12)));
            adminRegis.setAd_status("D");
            adminRegis.setAd_reg_dt(new Date());
            if (adminService.saveAdmin(adminRegis, file) > 0) {
                redirectAttributes.addFlashAttribute("successMess", "Yêu cầu tạo tài khoản thành công!");
                return "redirect:/cms/admin";
            } else {
                redirectAttributes.addFlashAttribute("errorMess", "Yêu cầu tạo tài khoản thất bại. Lỗi!");
                return "redirect:/cms/admin";
            }
        } else {
            redirectAttributes.addFlashAttribute(
                    "errorMess",
                    "Email này đã được đăng ký. Vui lòng thử lại bằng một email khác. Xin cảm ơn!");
            return "redirect:/cms/admin";
        }
    }

    @GetMapping(value = "/cms/admin/email/check")
    @ResponseBody
    public Boolean checkDupAdminEmail(
            @RequestParam(value = "email", required = true) String email) {
        return adminService.checkDupEmail(email);
    }

    @GetMapping(value = "/cms/admin/update")
    @ResponseBody
    public Admin getAdminByAdSeq(
            @RequestParam(value = "adminSeq", required = true) int adminSeq) {
        Admin admin = adminService.getAdminBySeq(adminSeq);
        return admin;
    }

    @PostMapping(value = "/cms/admin/update")
    public String updateAdmin(
            @ModelAttribute("adminForm") Admin admin,
            RedirectAttributes redirectAttributes) {
        return adminService.updateAdmin(redirectAttributes, admin);
    }

    @GetMapping(value = "/cms/admin/info")
    public String infoUser(Model model, HttpServletRequest request) {
        super.updateRoleSession();
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        Admin getInfoAdmin = adminService.getAdminBySeq(admin.getAd_seq());
        model.addAttribute("infoAdmin", getInfoAdmin);
        List<Agency> agencyList = agencyService.getAllAgency();
        model.addAttribute("agencyList", agencyList);
        return "/vn/admin/admin/info";
    }

    @PostMapping(value = "/cms/admin/info")
    public String updateInfoAdmin(
            @ModelAttribute("infoAdmin") Admin admin,
            RedirectAttributes redirectAttributes) {
        int updateResult = adminService.updateInfo(admin);
        if (updateResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Sửa thông tin admin thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi cập nhật thông tin admin");
        }
        return "redirect:/cms/admin/info";
    }

    @GetMapping(value = "/cms/admin/password/change")
    public String changePassword(Model model) {
        super.updateRoleSession();
        model.addAttribute("adminForm", new Admin());
        return "/vn/admin/admin/change-password";
    }

    @GetMapping(value = "/cms/admin/password/check")
    @ResponseBody
    public boolean testMatchPassword(@RequestParam(value = "currentPass") String currentPass) {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        admin.setAd_pw(currentPass);
        Admin adminCheck = adminService.checkPasswordByEmail(admin);
        if (adminCheck == null) return false;
        else return true;
    }

    @PostMapping(value = "/cms/admin/password/change")
    public String updateNewPass(
            @ModelAttribute(value = "adminForm") Admin adminForm,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        adminForm.setAd_seq(admin.getAd_seq());
        adminForm.setAd_pw(BCrypt.hashpw(adminForm.getAd_pw(), BCrypt.gensalt(12)));
        int updateResult = adminService.updatePassword(adminForm);
        if (updateResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật mật khẩu thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi cập nhật mật khẩu");
        }
        return "redirect:/cms/admin/password/change";
    }

    @GetMapping(value = "/cms/admin/delete/{adminSeq}")
    public String deleteOneAdmin(@PathVariable int adminSeq,
                                 RedirectAttributes redirectAttributes)
            throws IOException {
        super.updateRoleSession();
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        if (admin.getAd_seq() == adminSeq) {
            redirectAttributes.addFlashAttribute("errorMess", "Bạn không thể xóa tài khoản mà bạn đang đăng nhập");
        } else {
            int delResult = adminService.deleteAdmin(adminSeq);
            if (delResult > 0) {
                redirectAttributes.addFlashAttribute("successMess", "Xóa tài khoản thành công");
            } else {
                redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi xóa tài khoản");
            }
        }
        return "redirect:/cms/admin";
    }
}
