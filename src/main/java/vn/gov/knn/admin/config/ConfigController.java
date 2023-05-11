package vn.gov.knn.admin.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.support.CurrentUser;

@Controller
public class ConfigController extends CurrentUser {
    @Autowired
    private ConfigService configService;

    @GetMapping(value = "/cms/config")
    public String ConfigWebsite(Model model) {
        super.updateRoleSession();
        Config config = configService.getConfig();
        model.addAttribute("config", config);
        return "vn/admin/config/config";
    }

    @PostMapping(value = "/cms/config/update")
    public String updateConfig(@ModelAttribute("config") Config config,
                               RedirectAttributes redirectAttributes,
                               @RequestParam("config_file") MultipartFile configFile
    ) throws Exception {
        int saveResult = configService.updateConfig(config, configFile);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi cập nhật thông tin");
        }
        return "redirect:/cms/config";
    }
}
