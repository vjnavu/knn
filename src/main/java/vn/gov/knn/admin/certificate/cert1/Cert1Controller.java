package vn.gov.knn.admin.certificate.cert1;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.certificate.cert2.Cert2;
import vn.gov.knn.admin.certificate.cert2.Cert2Service;
import vn.gov.knn.admin.certificate.cert3.Cert3;
import vn.gov.knn.admin.certificate.cert3.Cert3Service;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.DataProcessing;
import vn.gov.knn.admin.support.Pagination;
import vn.gov.knn.admin.support.export.Excel;
import vn.gov.knn.admin.support.export.ExcelExporter;
import vn.gov.knn.admin.support.export.ObjectTransfer;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class Cert1Controller extends CurrentUser {
    @Autowired
    private Cert1Service cert1Service;
    @Autowired
    private Cert2Service cert2Service;

    @Autowired
    private Cert3Service cert3Service;

    @GetMapping(value = "/cms/certificate")
    public String getCatCertificate(Model model, @ModelAttribute(value = "catSearch") Cert1 catSearch) {
        super.updateRoleSession();
        Map<Cert1, List<Cert2>> cats = new LinkedHashMap<>();
        catSearch.setSize(3);
        List<Cert1> cert1s = cert1Service.getListCert1(catSearch);
        for (Cert1 c1 : cert1s) {
            Cert2 search = new Cert2();
            search.setCert1_seq(c1.getCert1_seq());
            search.setKeyWord(catSearch.getKeyWord());
            List<Cert2> cert2s = cert2Service.getListCert2ByCert1(search);
            if (cert2s.size() == 0) {
                search.setKeyWord("");
                cert2s = cert2Service.getListCert2ByCert1(search);
            }
            cats.put(c1, cert2s);
        }
        int totalRow = cert1Service.countCert1(catSearch);
        int totalCert1 = cert1Service.countTotalCert1();
        int activeCert1 = cert1Service.countActiveCert1();
        int totalCert2 = cert2Service.countTotalCert2();
        int activeCert2 = cert2Service.countActiveCert2();
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(catSearch.getPage(), catSearch.getSize(), totalRow));
        model.addAttribute("cats", cats);
        model.addAttribute("totalCert1", totalCert1);
        model.addAttribute("activeCert1", activeCert1);
        model.addAttribute("totalCert2", totalCert2);
        model.addAttribute("activeCert2", activeCert2);
        return "/vn/admin/certificate/category/list";
    }

    @GetMapping(value = "/cms/certificate/new")
    public String addCert1Get(Model model) {
        super.updateRoleSession();
        Cert1 cert1 = new Cert1();
        cert1.setCert1_display_tf(true);
        model.addAttribute("cert1", cert1);
        model.addAttribute("action", "new");
        return "/vn/admin/certificate/category/form-cert1";
    }

    @PostMapping(value = "/cms/certificate/new")
    public String addCert1Post(@ModelAttribute("cert1") Cert1 cert1,
                               RedirectAttributes redirectAttributes,
                               @RequestParam(value = "avatar") MultipartFile file) throws Exception {
        if (cert1.isCert1_display_tf()) cert1.setCert1_display("Y");
        else cert1.setCert1_display("N");
        cert1.setCert1_reg_dt(new Date());
        int saveResult = cert1Service.addCert1Post(cert1, file);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm mới thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/certificate";
    }

    @GetMapping(value = "/cms/certificate/delete/cert1/{cert1Seq}")
    public String deleteCert1(@PathVariable String cert1Seq,
                              RedirectAttributes redirectAttributes) {
        super.updateRoleSession();
        int delResult = cert1Service.deleteCert1(cert1Seq);
        if (delResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Xóa thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi xóa");
        }
        return "redirect:/cms/certificate";
    }

    @GetMapping(value = "/cms/certificate/update/cert1/{pageOld}/{cert1Seq}")
    public String updateCert1G(@PathVariable String cert1Seq,
                               Model model,
                               @PathVariable String pageOld) {
        super.updateRoleSession();
        Cert1 cert1 = cert1Service.getCert1BySeq(cert1Seq);
        if (cert1.getCert1_display().equals("Y")) cert1.setCert1_display_tf(true);
        else cert1.setCert1_display_tf(false);
        model.addAttribute("cert1", cert1);
        model.addAttribute("action", "update");
        model.addAttribute("pageOld", pageOld);
        return "/vn/admin/certificate/category/form-cert1";
    }

    @PostMapping(value = "/cms/certificate/update/{pageOld}")
    public String updateCert1P(@ModelAttribute(value = "Cert1") Cert1 cert1,
                               @RequestParam(value = "avatar") MultipartFile file,
                               RedirectAttributes redirectAttributes,
                               @PathVariable String pageOld
    ) throws Exception {
        if (cert1.isCert1_display_tf()) cert1.setCert1_display("Y");
        else cert1.setCert1_display("N");
        cert1.setCert1_mod_dt(new Date());
        int updateResult = cert1Service.updateCert1P(cert1, file);
        if (updateResult > 0) {
            redirectAttributes.addFlashAttribute(
                    "successMess", "Chỉnh sửa hành công");
        } else {
            redirectAttributes.addFlashAttribute(
                    "errorMess", "Đã xảy ra lỗi khi chỉnh sửa");
        }
        if (pageOld.equals("category")) {
            return "redirect:/cms/certificate";
        } else {
            return "redirect:/cms/certificate/detail";
        }
    }

    @GetMapping("/cms/certificate/export")
    public void exportExcel(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());

        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=certificate" + currentDateTime + ".xlsx";
        response.setHeader(headerKey, headerValue);
        List<String> names = new ArrayList<>();
        names.add("1000");
        names.add("1001");
        names.add("1002");
        List<Cert1> cert1s = cert1Service.getAll();
        List<Cert2> cert2s = cert2Service.getAll();
        List<Cert3> cert3s = cert3Service.getAll();
        ObjectTransfer objectTransfer = new ObjectTransfer();
        ObjectTransfer objectTransfer1 = new ObjectTransfer();
        ObjectTransfer objectTransfer2 = new ObjectTransfer();
        Excel excel1 = new Excel();
        excel1.setName("CODE");
        Excel excel2 = new Excel();
        excel2.setName("NAME");
        Excel excel3 = new Excel();
        excel3.setName("USE");
        Excel excel4 = new Excel();
        excel4.setName("HGRD_CODE");

        Excel excel5 = new Excel();
        excel5.setName("CODE");
        Excel excel6 = new Excel();
        excel6.setName("NAME");
        Excel excel9 = new Excel();
        excel9.setName("LV");
        Excel excel7 = new Excel();
        excel7.setName("USE");
        Excel excel8 = new Excel();
        excel8.setName("HGRD_CODE");
        List<Excel> excels = new ArrayList<>();
        List<Excel> excels1 = new ArrayList<>();
        excels.add(excel1);
        excels.add(excel2);
        excels.add(excel3);
        excels.add(excel4);
        excels1.add(excel5);
        excels1.add(excel6);
        excels1.add(excel9);
        excels1.add(excel7);
        excels1.add(excel8);
        objectTransfer.setExcels(excels);
        objectTransfer1.setExcels(excels);
        objectTransfer2.setExcels(excels1);
        List<ObjectTransfer> excelHeader = new ArrayList<>();
        excelHeader.add(objectTransfer);
        excelHeader.add(objectTransfer1);
        excelHeader.add(objectTransfer2);

        List<ObjectTransfer> objectTransfers1 = new ArrayList<>();
        List<ObjectTransfer> objectTransfers2 = new ArrayList<>();
        List<ObjectTransfer> objectTransfers3 = new ArrayList<>();
        objectTransfers1 = DataProcessing.transferObjectToExcel1(cert1s, objectTransfers1);
        objectTransfers2 = DataProcessing.transferObjectToExcel2(cert2s, objectTransfers2);
        objectTransfers3 = DataProcessing.transferObjectToExcel3(cert3s, objectTransfers3);
        ExcelExporter excelExporter = new ExcelExporter();
        List<List<ObjectTransfer>> lists = new ArrayList<>();
        lists.add(objectTransfers1);
        lists.add(objectTransfers2);
        lists.add(objectTransfers3);
        excelExporter.export(response, names, excelHeader, lists);
    }

}
