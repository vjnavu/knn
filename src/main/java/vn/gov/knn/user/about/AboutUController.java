package vn.gov.knn.user.about;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.gov.knn.user.common.CommonService;

@Controller
public class AboutUController {
    @Autowired
    private CommonService commonService;


    @GetMapping("/about/greeting")
    public String greeting(Model model) {
        commonService.sentInfoWeb(model);
        return "/vn/user/about/greeting";
    }

    @GetMapping("/about/location")
    public String location(Model model) {
        commonService.sentInfoWeb(model);
        return "/vn/user/about/location";
    }

    @GetMapping("/about/mandates")
    public String mandates(Model model) {
        commonService.sentInfoWeb(model);
        return "/vn/user/about/mandates";
    }

    @GetMapping("/about/structure")
    public String structure(Model model) {
        commonService.sentInfoWeb(model);
        return "/vn/user/about/structure";
    }
}
