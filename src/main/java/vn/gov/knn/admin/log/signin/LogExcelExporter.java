package vn.gov.knn.admin.log.signin;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class LogExcelExporter {
    private XSSFWorkbook workbook;
    private XSSFSheet sheet;

    private List<Login> listLogs;

    public LogExcelExporter(List<Login> listLogs) {
        this.listLogs = listLogs;
        try{
            workbook = new XSSFWorkbook();
        }catch (Exception e){
            System.out.printf("Failed to create new XSSFWorkbook");
        }

    }


    private void writeHeaderLine() {
        sheet = workbook.createSheet("LOG");

        Row row = sheet.createRow(0);

        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setBold(true);
        font.setFontHeight(16);
        style.setFont(font);

        createCell(row, 0, "PHÂN LOẠI", style);
        createCell(row, 1, "TÊN", style);
        createCell(row, 2, "EMAIL", style);
        createCell(row, 3, "NGÀY ĐĂNG NHẬP", style);
        createCell(row, 4, "ĐỊA CHỈ IP", style);
        createCell(row, 5, "TRÌNH DUYỆT", style);
        createCell(row, 6, "HỆ ĐIỀU HÀNH", style);

    }

    private void createCell(Row row, int columnCount, Object value, CellStyle style) {
        sheet.autoSizeColumn(columnCount);
        Cell cell = row.createCell(columnCount);
        if (value instanceof Integer) {
            cell.setCellValue((Integer) value);
        } else if (value instanceof Boolean) {
            cell.setCellValue((Boolean) value);
        }else {
            cell.setCellValue((String) value);
        }
        cell.setCellStyle(style);
    }

    private void writeDataLines() {
        int rowCount = 1;

        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setFontHeight(14);
        style.setFont(font);

        for (Login login : listLogs) {
            Row row = sheet.createRow(rowCount++);
            int columnCount = 0;
            String type = "";
            if(login.getLogin_adm_role()==1){
                type = "ADMIN";
            } else if (login.getLogin_adm_role()==2) {
                type = "DSD";
            } else if (login.getLogin_adm_role()==3) {
                type = "NSAO";
            } else{
                type = "Chưa phân quyền";
            }
            createCell(row, columnCount++, type, style);
            createCell(row, columnCount++, login.getLogin_adm_name(), style);
            createCell(row, columnCount++, login.getLogin_adm_email(), style);
            createCell(row, columnCount++, login.getLogin_date_format(), style);
            createCell(row, columnCount++, login.getLogin_ip(), style);
            createCell(row, columnCount++, login.getLogin_browser(), style);
            createCell(row, columnCount++, login.getLogin_os(), style);

        }
    }

    public void export(HttpServletResponse response) throws IOException {
        writeHeaderLine();
        writeDataLines();

        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();

        outputStream.close();

    }
}
