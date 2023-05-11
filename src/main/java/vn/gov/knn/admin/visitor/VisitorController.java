package vn.gov.knn.admin.visitor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class VisitorController {
    @Autowired
    private VisitorService visitorService;

    @GetMapping(value="/cms/visitor/chart")
    @ResponseBody
    public List<Visitor> getVisitorList(@RequestParam("start_dt") String start_dt, @RequestParam("end_dt") String end_dt) throws ParseException {
        Visitor visitor = new Visitor();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        if(start_dt != null && start_dt != ""){
            Date startDate = df.parse(start_dt);
            visitor.setVs_start_dt(startDate);
        }
        if(end_dt != null && end_dt != ""){
            Date endDate = df.parse(end_dt);
            visitor.setVs_end_dt(endDate);
        }
        List<Visitor> visitorChart = visitorService.getVisitorList(visitor);
        return visitorChart;
    }
}
