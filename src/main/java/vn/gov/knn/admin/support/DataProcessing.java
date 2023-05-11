package vn.gov.knn.admin.support;

import vn.gov.knn.admin.board.post.Post;
import vn.gov.knn.admin.certificate.cert1.Cert1;
import vn.gov.knn.admin.certificate.cert2.Cert2;
import vn.gov.knn.admin.certificate.cert3.Cert3;
import vn.gov.knn.admin.support.export.Excel;
import vn.gov.knn.admin.support.export.ObjectTransfer;

import javax.servlet.http.HttpServletRequest;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.concurrent.TimeUnit;

public class DataProcessing {
    static char[] LOWERCASE = "abcdefghijklmnopqrstuvwxyz".toCharArray();
    static char[] UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
    static char[] NUMBERS = "0123456789".toCharArray();
    static char[] ALL_CHARS =
            "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
                    .toCharArray();
    static Random rand = new SecureRandom();

    public static String randomString() {
        char[] password = new char[8];
        password[0] = LOWERCASE[rand.nextInt(LOWERCASE.length)];
        password[1] = UPPERCASE[rand.nextInt(UPPERCASE.length)];
        password[2] = NUMBERS[rand.nextInt(NUMBERS.length)];
        for (int i = 3; i < 8; i++) {
            password[i] = ALL_CHARS[rand.nextInt(ALL_CHARS.length)];
        }
        return new String(password);
    }

    public static String getClientIpAddr(HttpServletRequest request) {
        String remoteAddr = "";
        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }
        return remoteAddr;
    }

    public static Map<String, String> getRequestHeadersInMap(HttpServletRequest request) {

        Map<String, String> result = new HashMap<>();

        Enumeration headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String key = (String) headerNames.nextElement();
            String value = request.getHeader(key);
            result.put(key, value);
        }
        return result;
    }

    public static List<Post> ckeckNew(List<Post> posts) {
        Date currentDate = new Date();
        for (Post post : posts) {
            long getDiff = currentDate.getTime() - post.getPost_reg_dt().getTime();
            long getDaysDiff = TimeUnit.MILLISECONDS.toDays(getDiff);
            if (getDaysDiff < 5) post.setCheck_new(true);
            else post.setCheck_new(false);
        }
        return posts;
    }

    public static boolean isSameDay(Date date1, Date date2) {
        LocalDate localDate1 = date1.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();
        LocalDate localDate2 = date2.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();
        return localDate1.isEqual(localDate2);
    }

    public static List<ObjectTransfer> transferObjectToExcel1(List<Cert1> listCert, List<ObjectTransfer> objectTransfers) {
        for (Cert1 cert1 : listCert) {
            List<Excel> list = new ArrayList<>();
            Excel excel1 = new Excel();
            excel1.setName("CODE");
            excel1.setValue(cert1.getCert1_seq());
            Excel excel2 = new Excel();
            excel2.setName("NAME");
            excel2.setValue(cert1.getCert1_name());
            Excel excel3 = new Excel();
            excel3.setName("USE");
            excel3.setValue(cert1.getCert1_display());
            Excel excel4 = new Excel();
            excel4.setName("HGRD_CODE");
            excel4.setValue("0");
            list.add(excel1);
            list.add(excel2);
            list.add(excel3);
            list.add(excel4);
            ObjectTransfer objectTransfer = new ObjectTransfer();
            objectTransfer.setExcels(list);
            objectTransfers.add(objectTransfer);
        }
        return objectTransfers;
    }

    public static List<ObjectTransfer> transferObjectToExcel2(List<Cert2> listCert, List<ObjectTransfer> objectTransfers) {
        for (Cert2 cert2 : listCert) {
            List<Excel> list = new ArrayList<>();
            Excel excel1 = new Excel();
            excel1.setName("CODE");
            excel1.setValue(cert2.getCert2_seq());
            Excel excel2 = new Excel();
            excel2.setName("NAME");
            excel2.setValue(cert2.getCert2_name());
            Excel excel3 = new Excel();
            excel3.setName("USE");
            excel3.setValue(cert2.getCert2_display());
            Excel excel4 = new Excel();
            excel4.setName("HGRD_CODE");
            excel4.setValue(cert2.getCert1_seq());
            list.add(excel1);
            list.add(excel2);
            list.add(excel3);
            list.add(excel4);
            ObjectTransfer objectTransfer = new ObjectTransfer();
            objectTransfer.setExcels(list);
            objectTransfers.add(objectTransfer);
        }
        return objectTransfers;
    }

    public static List<ObjectTransfer> transferObjectToExcel3(List<Cert3> listCert, List<ObjectTransfer> objectTransfers) {
        for (Cert3 cert3 : listCert) {
            List<Excel> list = new ArrayList<>();
            Excel excel1 = new Excel();
            excel1.setName("CODE");
            excel1.setValue(cert3.getCert3_seq());
            Excel excel2 = new Excel();
            excel2.setName("NAME");
            excel2.setValue(cert3.getCert3_name());
            Excel excel3 = new Excel();
            excel3.setName("LV");
            excel3.setValue(cert3.getCert3_level());
            Excel excel4 = new Excel();
            excel4.setName("USE");
            excel4.setValue(cert3.getCert3_display());
            Excel excel5 = new Excel();
            excel5.setName("HGRD_CODE");
            excel5.setValue(cert3.getCert2_seq());
            list.add(excel1);
            list.add(excel2);
            list.add(excel3);
            list.add(excel4);
            list.add(excel5);
            ObjectTransfer objectTransfer = new ObjectTransfer();
            objectTransfer.setExcels(list);
            objectTransfers.add(objectTransfer);
        }
        return objectTransfers;
    }
}
