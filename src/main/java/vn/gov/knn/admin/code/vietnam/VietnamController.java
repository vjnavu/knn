/*
  User: VTA
  Date: 8/14/2021 11:26 AM
*/
package vn.gov.knn.admin.code.vietnam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class VietnamController {
    @Autowired
    private VietnamService vietnamService;

    @GetMapping(value = "/cms/vietnam/districtList")
    @ResponseBody
    public List<Vietnam> getDistrictList(@RequestParam("proSeq") Integer proSeq) {
        List<Vietnam> getDistrictList = vietnamService.getDistrictListByProSeq(proSeq);
        return getDistrictList;
    }

    @GetMapping(value = "/cms/vietnam/communestList")
    @ResponseBody
    public List<Vietnam> getCommunestList(@RequestParam("disSeq") Integer disSeq) {
        List<Vietnam> getCommunestList = vietnamService.getCommunesListByProSeq(disSeq);
        return getCommunestList;
    }

}
