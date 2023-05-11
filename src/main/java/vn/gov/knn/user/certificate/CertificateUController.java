package vn.gov.knn.user.certificate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.gov.knn.admin.agency.Agency;
import vn.gov.knn.admin.agency.AgencyService;
import vn.gov.knn.admin.certificate.cert1.Cert1;
import vn.gov.knn.admin.certificate.cert1.Cert1Service;
import vn.gov.knn.admin.certificate.cert2.Cert2;
import vn.gov.knn.admin.certificate.cert2.Cert2Service;
import vn.gov.knn.admin.certificate.cert3.Cert3;
import vn.gov.knn.admin.certificate.cert3.Cert3Service;
import vn.gov.knn.admin.code.vietnam.Vietnam;
import vn.gov.knn.admin.code.vietnam.VietnamService;
import vn.gov.knn.admin.support.Pagination;
import vn.gov.knn.user.common.CommonService;

import java.util.List;

@Controller
public class CertificateUController {
    @Autowired
    private CommonService commonService;

    @Autowired
    private Cert1Service cert1Service;

    @Autowired
    private Cert3Service cert3Service;

    @Autowired
    private AgencyService agencyService;

    @Autowired
    private Cert2Service cert2Service;

    @Autowired
    private VietnamService vietnamService;

    @GetMapping(value = "/certificate/category")
    public String getListCatCer(Model model,
                                @ModelAttribute(value = "cert1Search") Cert1 cert1) {
        commonService.sentInfoWeb(model);
        List<Cert1> cert1s = cert1Service.getAllByStatus(cert1);
        model.addAttribute("cert1s", cert1s);
        return "/vn/user/certificate/category";
    }

    @GetMapping(value = "/certificate/detail/list/{catSeq}")
    public String getListCerByCat(@PathVariable String catSeq, @ModelAttribute(value = "catSearch") Cert3 catSearch,
                                  Model model) {
        commonService.sentInfoWeb(model);
        catSearch.setCert1_seq(catSeq);
        List<Cert1> cert1s = cert1Service.getAll();
        List<Cert2> cert2s = cert2Service.getAllCert2ByCert1(catSeq);
        List<Cert3> cert3s = cert3Service.getListCert3(catSearch);
        int totalRow = cert3Service.countCert3(catSearch);
        int totalPage = 0;
        if (totalRow % 10 == 0) {
            totalPage = (int) totalRow / 10;
        } else {
            totalPage = (int) totalRow / 10 + 1;
        }
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(catSearch.getPage(), catSearch.getSize(), totalRow));
        model.addAttribute("cert3s", cert3s);
        model.addAttribute("cert1s", cert1s);
        model.addAttribute("cert2s", cert2s);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("activeCert1", catSeq);
        model.addAttribute("action", "/certificate/detail/list/" + catSeq);
        return "/vn/user/certificate/detail-list";
    }

    @GetMapping(value = "/certificate/category/list/{catSeq}")
    public String getListCertificate(@PathVariable String catSeq, @ModelAttribute(value = "catSearch") Cert3 catSearch,
                                  Model model) {
        commonService.sentInfoWeb(model);
        catSearch.setCert1_seq(catSeq);
        List<Cert1> cert1s = cert1Service.getAll();
        List<Cert2> cert2s = cert2Service.getAllCert2ByCert1(catSeq);
        List<Cert3> cert3s = cert3Service.getListCert3(catSearch);
        int totalRow = cert3Service.countCert3(catSearch);
        int totalPage = 0;
        if (totalRow % 10 == 0) {
            totalPage = (int) totalRow / 10;
        } else {
            totalPage = (int) totalRow / 10 + 1;
        }
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(catSearch.getPage(), catSearch.getSize(), totalRow));
        model.addAttribute("cert3s", cert3s);
        model.addAttribute("cert1s", cert1s);
        model.addAttribute("cert2s", cert2s);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("activeCert1", catSeq);
        model.addAttribute("action", "/certificate/detail/list/" + catSeq);
        return "/vn/user/certificate/detail-list";
    }

    @GetMapping(value = "/certificate/detail")

    public String getListCer(Model model, @ModelAttribute(value = "catSearch") Cert3 catSearch) {
        commonService.sentInfoWeb(model);
//        Map<Cert1, List<Cert3>> cats = new LinkedHashMap<>();
//        Cert1 searchC1 = new Cert1();
//        searchC1.setCert1_seq(catSearch.getCert1_seq());
//        List<Cert1> cert1s = cert1Service.getListCert1(catSearch);
//        int totalRow = 0;
//        Cert3 searchC2 = new Cert3();
//        for (Cert1 c1 : cert1s) {
//            Cert2 search = new Cert2();
//            search.setCert1_seq(c1.getCert1_seq());
//            search.setCert2_seq(catSearch.getCert2_tmp());
//            List<Cert2> cert2s = cert2Service.getListCert2ByCert1(search);
//            if (cert2s.size() == 0) {
//                cats.put(c1, new ArrayList<>());
//            } else {
//                List<Cert3> cert3s = new ArrayList<>();
//                for (Cert2 c2 : cert2s) {
//                    searchC2.setCert2_seq(c2.getCert2_seq());
//                    searchC2.setKeyWord(catSearch.getKeyWord());
//                    List<Cert3> tmp = cert3Service.getListByCert2Seq(searchC2);
//                    totalRow += tmp.size();
//                    cert3s.addAll(tmp);
//                }
//                cats.put(c1, cert3s);
//            }
//        }
//        model.addAttribute("cats", cats);
//        Pagination pagination = new Pagination();
//        model.addAttribute(
//                "paging", pagination.createPagingString(catSearch.getPage(), catSearch.getSize(), totalRow));
        List<Cert1> cert1s = cert1Service.getAll();
        List<Cert2> cert2s = cert2Service.getAll();
        List<Cert3> cert3s = cert3Service.getListCert3(catSearch);
        int totalRow = cert3Service.countCert3(catSearch);
        int totalPage = 0;
        if (totalRow % 10 == 0) {
            totalPage = (int) totalRow / 10;
        } else {
            totalPage = (int) totalRow / 10 + 1;
        }
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(catSearch.getPage(), catSearch.getSize(), totalRow));
        model.addAttribute("cert3s", cert3s);
        model.addAttribute("cert1s", cert1s);
        model.addAttribute("cert2s", cert2s);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("totalRow", totalRow);
        return "/vn/user/certificate/detail-list";
    }

    @GetMapping(value = "/agency")
    public String getAgencyList(Model model,
                                @ModelAttribute(value = "agencySearch") Agency agency) {
        commonService.sentInfoWeb(model);
        List<Vietnam> addr1s = vietnamService.getProvinceList(new Vietnam());
        agency.setAg_acti("Y");
        List<Agency> agencies = agencyService.getAgencyList(agency);
        int totalRow = agencyService.countAgency(agency);
        int totalPage = 0;
        if (totalRow % 10 == 0) {
            totalPage = (int) totalRow / 10;
        } else {
            totalPage = (int) totalRow / 10 + 1;
        }
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(agency.getPage(), agency.getSize(), totalRow));
        model.addAttribute("agencies", agencies);
        model.addAttribute("addr1s", addr1s);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("totalPage", totalPage);
        return "/vn/user/certificate/agency-list";
    }

    @PostMapping(value = "/certificate/cert2/{cert1Seq}")
    @ResponseBody
    public List<Cert2> getCert2ByCert1(@PathVariable String cert1Seq) {
        List<Cert2> cert2s = cert2Service.getAllCert2ByCert1(cert1Seq);
        return cert2s;
    }

    @GetMapping(value = "/certificate/detail/view/{cert3Seq}")
    public String viewCertificate(@PathVariable String cert3Seq, Model model) {
        commonService.sentInfoWeb(model);
        Cert3 cert3 = cert3Service.getCert3BySeq(cert3Seq);
        model.addAttribute("cert3", cert3);
        return "/vn/user/certificate/view-info";
    }

    @GetMapping(value = "/agency/view/{agencySeq}")
    public String viewAgency(@PathVariable int agencySeq,
                             Model model) {
        commonService.sentInfoWeb(model);
        Agency agency = agencyService.getAgencyBySeq(agencySeq);
        model.addAttribute("agency", agency);
        return "/vn/user/certificate/agency-view";
    }
}
