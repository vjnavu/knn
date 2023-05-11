<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="breadcrumb-wrap">
    <div class="container">
        <ol class="breadcrumb">
            <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
            <c:if test="${breadcrumb != null}">
                <c:if test='<%=language.equals("vn")%>'>
                    <li><a
                            <c:if test="${activeMenu == breadcrumb.menuC1.mn_seq}">class="active"</c:if>
                            href="${breadcrumb.menuC1.mn_link}">${breadcrumb.menuC1.mn_name_vn}
                    </a></li>
                    <li><a
                            <c:if test="${activeMenu == breadcrumb.menuC2.mn_seq}">class="active"</c:if>
                            href="${breadcrumb.menuC2.mn_link}">${fn:toLowerCase(breadcrumb.menuC2.mn_name_vn)}
                    </a></li>
                    <li><a
                            <c:if test="${activeMenu == breadcrumb.menuC3.mn_seq}">class="active"</c:if>
                            href="${breadcrumb.menuC3.mn_link}">${fn:toLowerCase(breadcrumb.menuC3.mn_name_vn)}
                    </a></li>
                </c:if>
                <c:if test='<%=language.equals("en")%>'>
                    <li><a
                            <c:if test="${activeMenu == breadcrumb.menuC1.mn_seq}">class="active"</c:if>
                            href="${breadcrumb.menuC1.mn_link}">${breadcrumb.menuC1.mn_name_en}</a></li>
                    <li><a
                            <c:if test="${activeMenu == breadcrumb.menuC2.mn_seq}">class="active"</c:if>
                            href="${breadcrumb.menuC2.mn_link}">${fn:toLowerCase(breadcrumb.menuC2.mn_name_en)}</a></li>
                    <li><a
                            <c:if test="${activeMenu == breadcrumb.menuC3.mn_seq}">class="active"</c:if>
                            href="${breadcrumb.menuC3.mn_link}">${fn:toLowerCase(breadcrumb.menuC3.mn_name_en)}</a></li>
                </c:if>
            </c:if>
        </ol>
    </div>
</div>
