package vn.gov.knn.admin.agency;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.code.vietnam.Vietnam;
import vn.gov.knn.admin.code.vietnam.VietnamService;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class AgencyController extends CurrentUser {
    @Autowired
    private AgencyService agencyService;

    @Autowired
    private VietnamService vietnamService;

    @GetMapping(value = "/cms/agency")
    public String getAgencyList(@ModelAttribute("agencySearch") Agency agency, Model model) {
        super.updateRoleSession();
        List<Agency> agencyList = agencyService.getAgencyList(agency);
        int countAgency = agencyService.countAgency(agency);
        int totalAgency = agencyService.countTotalAgency();
        int activeAgency = agencyService.countActiveAgency();
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(agency.getPage(), agency.getSize(), countAgency));
        model.addAttribute("agencyList", agencyList);
        model.addAttribute("totalAgency", totalAgency);
        model.addAttribute("activeAgency", activeAgency);
        return "/vn/admin/agency/list";
    }

    @GetMapping(value = "/cms/agency/new")
    public String newAgency(Model model) {
        super.updateRoleSession();
        List<Vietnam> provinceList = vietnamService.getProvinceList(new Vietnam());
        Agency agencyForm = new Agency();
        agencyForm.setAg_acti_tf(true);
        model.addAttribute("agencyForm", agencyForm);
        model.addAttribute("formAction", "new");
        model.addAttribute("provinceList", provinceList);
        return "/vn/admin/agency/form";
    }

    @PostMapping(value = "/cms/agency/new")
    public String saveAgency(
            RedirectAttributes redirectAttributes,
            @ModelAttribute("agencyForm") Agency agencyForm,
            @RequestParam("ag_logo_file") MultipartFile file)
            throws Exception {
        if (agencyForm.isAg_acti_tf()) agencyForm.setAg_acti("Y");
        else agencyForm.setAg_acti("N");
        int saveResult = agencyService.saveNewAgency(agencyForm, file);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm mới thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi chỉnh sửa");
        }
        return "redirect:/cms/agency";
    }

    @GetMapping(value = "/cms/agency/update/{agencySeq}")
    public String getUpdateAgency(@PathVariable int agencySeq, Model model) {
        super.updateRoleSession();
        Agency agencyForm = agencyService.getAgencyBySeq(agencySeq);
        if (agencyForm.getAg_acti().equals("Y")) agencyForm.setAg_acti_tf(true);
        else agencyForm.setAg_acti_tf(false);
        List<Vietnam> provinceList = vietnamService.getProvinceList(new Vietnam());
        List<Vietnam> districtList =
                vietnamService.getDistrictListByProSeq(agencyForm.getAg_addr1());
        List<Vietnam> communesList =
                vietnamService.getCommunesListByProSeq(agencyForm.getAg_addr2());
        model.addAttribute("provinceList", provinceList);
        model.addAttribute("districtList", districtList);
        model.addAttribute("communesList", communesList);
        model.addAttribute("agencyForm", agencyForm);
        model.addAttribute("formAction", "update");
        return "/vn/admin/agency/form";
    }

    @PostMapping(value = "/cms/agency/update")
    public String updateAgency(
            @ModelAttribute("agencyForm") Agency agencyForm,
            @RequestParam("ag_logo_file") MultipartFile file,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request)
            throws Exception {
        if (agencyForm.isAg_acti_tf()) agencyForm.setAg_acti("Y");
        else agencyForm.setAg_acti("N");
        int upResult = agencyService.updateAgency(agencyForm, file);
        if (upResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        Admin currentUser = (Admin) request.getSession().getAttribute("CurrentUser");
        if (currentUser.getAd_role() != 1 && currentUser.getAd_role() != 2) {
            return "redirect:/cms/agency/update/" + currentUser.getAd_agency_seq();
        } else {
            return "redirect:/cms/agency";
        }
    }

    @GetMapping("/cms/agency/delete/{agencySeq}")
    public String deleteAgency(@PathVariable int agencySeq, RedirectAttributes redirectAttributes)
            throws Exception {
        super.updateRoleSession();
        int delResult = agencyService.deleteAgency(agencySeq);
        if (delResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "xóa thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/agency";
    }
}
