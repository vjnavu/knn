<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer>
    <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
    <p>
        <c:if test='<%=language.equals("vn")%>'>
            Bản quyền
        </c:if>
        <c:if test='<%=language.equals("en")%>'>
            Copyright
        </c:if>© <span id="year"></span> - ${config.config_site_title}</p>
    <p>
        <c:if test='<%=language.equals("vn")%>'>Giấy phép thiết lập Website trên internet số 53/GP-TTĐT ngày 02/10/2014</c:if>
        <c:if test='<%=language.equals("en")%>'>License to set up Website on the internet No. 53/GP-TTĐT dated October 2, 2014</c:if>
    </p>
    <p>
        <c:if test='<%=language.equals("vn")%>'>
            Địa chỉ
        </c:if>
        <c:if test='<%=language.equals("en")%>'>
            Address
        </c:if>: ${config.config_addr}</p>
    <p>
        <c:if test='<%=language.equals("vn")%>'>
            Điện thoại
        </c:if>
        <c:if test='<%=language.equals("en")%>'>
            Phone number
        </c:if>: ${config.config_phone} - Fax: ${config.config_fax}</p>
    <p>Email: ${config.config_email} - Website: ${config.config_home_url}</p>
    <p>
        <c:if test='<%=language.equals("vn")%>'>
            Hệ thống là sản phẩm của dự án ODA hợp tác giữa Hàn Quốc và Việt Nam, được Cơ quan chính phủ Hàn Quốc - HRDK tài trợ.
        </c:if>
        <c:if test='<%=language.equals("en")%>'>
            This system is created with the support of Korean government - HRDK, as part of ODA projects between Korea and
            Vietnam.
        </c:if>
    </p>
    <p>
        <span>
            <c:if test='<%=language.equals("vn")%>'>
                Tổng
            </c:if>
            <c:if test='<%=language.equals("en")%>'>
                Total
            </c:if>:
        </span>
        <span class="mr-15">${visitors}</span>
        <span>
            <c:if test='<%=language.equals("vn")%>'>
                Hôm nay
            </c:if>
            <c:if test='<%=language.equals("en")%>'>
                Today
            </c:if>:
        </span>
        <span>${visitor}</span>
    </p>
</footer>
<script>
    document.getElementById("year").innerHTML = new Date().getFullYear();
</script>
