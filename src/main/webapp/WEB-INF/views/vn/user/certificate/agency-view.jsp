<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>

<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/views/vn/user/include/breadcrumb.jsp" charEncoding="UTF-8"/>
<div class="body">
    <div class="container">
        <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
        <div class="row">
            <div class="lnb">
                <div class="menu-name">
                    <c:if test='<%=language.equals("vn")%>'>
                        ${breadcrumb.menuC2.mn_name_vn}
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        ${breadcrumb.menuC2.mn_name_en}
                    </c:if>
                </div>
                <ul class="sub-nav">
                    <c:if test="${not empty menuSub}">
                        <c:forEach items="${menuSub}" var="sub">
                            <c:if test='<%=language.equals("vn")%>'>
                                <c:if test="${sub.mn_display_vn eq 'Y'}">
                                    <li
                                            <c:if test="${activeMenu == sub.mn_seq}">class="active"</c:if>
                                    ><a href="${sub.mn_link}">${sub.mn_name_vn}</a></li>
                                </c:if>
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                <c:if test="${sub.mn_display_en eq 'Y'}">
                                    <li
                                            <c:if test="${activeMenu == sub.mn_seq}">class="active"</c:if>
                                    ><a href="${sub.mn_link}">${sub.mn_name_en}</a></li>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
            <div class="content" style="min-height: 533px">
                <div class="title-page">
                    <c:if test='<%=language.equals("vn")%>'>
                        ${breadcrumb.menuC3.mn_name_vn}
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        ${breadcrumb.menuC3.mn_name_en}
                    </c:if>
                </div>
                <hr>
                <div class="cer-detail">
                    <h1>
                        <c:if test='<%=language.equals("vn")%>'>
                            ${agency.ag_name_vn}
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            ${agency.ag_name_en}
                        </c:if>
                    </h1>
                    <ul>
                        <li>
                            <div>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Địa chỉ
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Address
                                </c:if>
                                :
                                <span>${agency.ag_addr}, ${agency.addr3_name}, ${agency.addr2_name}, ${agency.addr1_name}</span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Số điện thoại
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Phone number
                                </c:if>
                                : <span>${agency.ag_phone}</span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Địa chỉ trang web
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Website
                                </c:if>
                                : <span><a href="${agency.ag_web}" target="_blank">${agency.ag_web}</a></span>
                            </div>
                        </li>
                        <c:if test="${agency.ag_fax != null and agency.ag_fax != ''}">
                            <li>
                                <div>
                                    Fax : <span>${agency.ag_fax}</span>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${agency.ag_email != null and agency.ag_email != ''}">
                            <li>
                                <div>
                                    Email : <span>${agency.ag_email}</span>
                                </div>
                            </li>
                        </c:if>

                        ${agency.ag_memo}
                    </ul>
                </div>
                <a href="/agency" class="btn btn-primary"
                   style="float: right; margin-bottom: 100px;">
                    <c:if test='<%=language.equals("vn")%>'>
                        Danh sách
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        List
                    </c:if>
                </a>
            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>
</body>

</html>
