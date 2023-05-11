package vn.gov.knn.admin.log.signin;

import com.opencsv.CSVWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.gov.knn.admin.admin.AdminService;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
public class LoginController extends CurrentUser {

    @Autowired
    private LoginService loginService;

    @Autowired
    private AdminService adminService;

    @GetMapping(value = "/cms/login")
    public String getListLogSig(Model model, @ModelAttribute("signSearch") Login logSigin) {
        super.updateRoleSession();

        List<Login> listLogin = loginService.getListSignin(logSigin);
        model.addAttribute("listSign", listLogin);

        int countAdmin = adminService.countAdmin();
        model.addAttribute("countAdmin", countAdmin);

        int totalRow = loginService.countSign(logSigin);
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(logSigin.getPage(), logSigin.getSize(), totalRow));
        return "/vn/admin/log/signin/list";
    }
    @GetMapping("/cms/login/export")
    public void exportExcelXLSX(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());

        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=LoginHistory.xlsx";
        response.setHeader(headerKey, headerValue);
        List<Login> list = loginService.getAll();
        LogExcelExporter logExcelExporter = new LogExcelExporter(list);
        logExcelExporter.export(response);
    }


    @GetMapping("/cms/sign-in/CSV")
    public void exportExcelCSV(HttpServletResponse response) throws IOException {
        String outputFileName = "C:\\test\\" + ".csv";
        File reportFile = new File(outputFileName);
        FileWriter outputfile = null;
        try {
            outputfile = new FileWriter(reportFile);
            CSVWriter writer = new CSVWriter(outputfile);
            List<String[]> data = new ArrayList<String[]>();
            List<Login> list = loginService.getAll();
            data.add(new String[] { "IP", "Name", "OS"});
            for (Login st : list) {
                data.add(new String[] {st.getLogin_ip(),
                        st.getLogin_adm_name(),
                        st.getLogin_os()});
            }
                writer.writeAll(data);
                try{
                    writer.close();
                }catch (Exception e){
                    System.out.printf("Failed to close CSVWriter");
                }
            }
        catch (IOException e) {
            System.out.printf("Failed to export login history to CSV");
            }
            // Download section
            String mimeType = "text/csv";
            response.setContentType(mimeType);
            String reportFileName = "report.csv";
            response.setHeader("Content-Disposition", String.format("attachment; filename=\""+reportFileName+"\""));
            response.setContentLength((int) reportFile.length());
            InputStream inputStream = new BufferedInputStream(new FileInputStream(reportFile));

            FileCopyUtils.copy(inputStream, response.getOutputStream());
            response.flushBuffer();
    }

    @GetMapping("/cms/login/api/excel")
    @ResponseBody
    public ResponseEntity<List<List<Login>>> exportExcel(){
        List<Login> list = loginService.getAll();
        return new ResponseEntity<>(Arrays.asList(list),HttpStatus.OK);
    }
}
