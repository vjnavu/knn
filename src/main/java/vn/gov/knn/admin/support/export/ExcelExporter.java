package vn.gov.knn.admin.support.export;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ExcelExporter {
    private XSSFWorkbook workbook;
    private XSSFSheet sheet;
    private XSSFSheet sheet1;

    public ExcelExporter() {
        try{
            workbook = new XSSFWorkbook();
        }catch (Exception e){
            System.out.printf("Failed to create new XSSFWorkbook");
        }

    }

    /*Tạo định dạng bảng tên cột*/
    private void writeHeaderLine(List<String> names, List<ObjectTransfer> objectHeader, List<List<ObjectTransfer>> lists) {
        for (int z = 0; z < names.size(); z++) {
            sheet = workbook.createSheet(names.get(z));
            Row row = sheet.createRow(0);
            XSSFFont font = workbook.createFont();
            font.setBold(true);
            font.setFontHeight(16);
            CellStyle headerCellStyle = sheet.getWorkbook().createCellStyle();
            headerCellStyle.setFillForegroundColor(IndexedColors.RED.index);
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerCellStyle.setFont(font);
            for (int i = 0; i < objectHeader.get(z).excels.size(); i++) {
                if (objectHeader.get(z).excels.get(i) != null) {
                    createCell(row, i, objectHeader.get(z).excels.get(i).getName(), headerCellStyle);
                }
            }
            writeDataLines(lists.get(z));
        }

    }

    private void createCell(Row row, int columnCount, Object value, CellStyle style) {
        sheet.autoSizeColumn(columnCount);
        Cell cell = row.createCell(columnCount);
        if (value instanceof Integer) {
            cell.setCellValue((Integer) value);
        } else if (value instanceof Boolean) {
            cell.setCellValue((Boolean) value);
        } else {
            cell.setCellValue((String) value);
        }
        cell.setCellStyle(style);
    }

    /*Viết dữ liệu map với từng trường*/
    private void writeDataLines(List<ObjectTransfer> objectTransfers) {
        int rowCount = 1;

        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setFontHeight(14);
        style.setFont(font);

        for (ObjectTransfer ofs : objectTransfers) {
            Row row = sheet.createRow(rowCount++);
            int columnCount = 0;
            for (Excel excel : ofs.excels) {
                if (excel != null) {
                    createCell(row, columnCount++, excel.getValue(), style);
                }
            }

        }
    }

    public void export(HttpServletResponse response, List<String> names, List<ObjectTransfer> objectHeader, List<List<ObjectTransfer>> lists) throws IOException {
        writeHeaderLine(names, objectHeader, lists);
        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }
}
