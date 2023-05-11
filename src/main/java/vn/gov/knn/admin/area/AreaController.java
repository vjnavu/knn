package vn.gov.knn.admin.area;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import java.util.ArrayList;
import java.util.List;

@Controller
public class AreaController extends CurrentUser {
    @Autowired
    private AreaService areaService;

    @GetMapping(value = "/{language}/cms/area/{target}/{areaSeq}")
    public String getAreaList(
            @PathVariable String language,
            @PathVariable String target,
            @PathVariable Integer areaSeq,
            Model model,
            @ModelAttribute("areaSearch") Area area) {
        super.updateRoleSession();
        List<Area> areaList = new ArrayList<>();
        int count = 0;
        if ("province".equals(target) && areaSeq != null) {
            areaList = areaService.getProvinceList(area);
            count = areaService.countProvinceList(area);
        } else if ("district".equals(target) && areaSeq != null) {
            area.setArea_foreign(areaSeq);
            areaList = areaService.getDistrictListByProSeq(area);
            count = areaService.countDistrictByProSeq(area);
        } else {
            area.setArea_foreign(areaSeq);
            areaList = areaService.getCommunesListByDisSeq(area);
            count = areaService.countCommunesByProSeq(area);
        }

        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(area.getPage(), area.getSize(), count));
        model.addAttribute("areaList", areaList);
        model.addAttribute("target", target + "/" + areaSeq);
        return language + "/admin/area";
    }
}
