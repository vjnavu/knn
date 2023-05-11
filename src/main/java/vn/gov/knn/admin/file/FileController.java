package vn.gov.knn.admin.file;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Paths;

@Controller
public class FileController {
    @Autowired
    private FileService fileService;

    @GetMapping(value = "/jarvis/file/{method}/{fileUuid}")
    public void downloadFileByUuid(HttpServletResponse response, @PathVariable String method, @PathVariable String fileUuid) throws Exception {
        FileVO fileVO = fileService.getFileByUuid(fileUuid);
        if (fileVO != null) {
            String filePath = fileVO.getFile_path();
            String fileName = fileVO.getFile_name();
            String sourceFile = Paths.get(filePath, fileUuid).normalize().toString();
            if ("download".equalsIgnoreCase(method) || "view".equalsIgnoreCase(method)) {
                MimetypesFileTypeMap mimetypesFileTypeMap = new MimetypesFileTypeMap();
                String mimeType = mimetypesFileTypeMap.getContentType(fileName);
                response.setContentType(mimeType);
                if ("download".equalsIgnoreCase(method)) {
                    String docName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
                    response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");
                }
                OutputStream out = response.getOutputStream();
                try (FileInputStream fis = new FileInputStream(sourceFile)) {
                    FileCopyUtils.copy(fis, out);
                } catch (FileNotFoundException e) {
                    System.err.println("File not found :" + fileName);
                } finally {
                    out.flush();
                }
            }
        }

    }
}
