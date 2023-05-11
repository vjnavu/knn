<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/views/vn/user/include/breadcrumb.jsp" charEncoding="UTF-8"/>
<div class="body">
    <% String language = (String) request.getSession().getAttribute("language");
        if (language == null) {
            request.removeAttribute("language");
            request.setAttribute("language", "vn");
        }
    %>
    <div class="container">
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
            <div class="content qa">
                <div class="title-page">
                    <c:if test='<%=language.equals("vn")%>'>
                        ${breadcrumb.menuC3.mn_name_vn}
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        ${breadcrumb.menuC3.mn_name_en}
                    </c:if>
                </div>
                <hr>
                <div class="search-container multi-search">
                    <form:form action="/agency" modelAttribute="agencySearch" id="searchForm"
                               method="get">
                        <form:input type="hidden" class="form-control" path="page" id="page"/>
                        <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                        <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                        <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <sec:csrfInput />
                        <div class="custom-select" style="width:350px; margin-right: 5px;">
                            <label for="ag_addr1"></label>
                            <form:select path="ag_addr1">
                                <option value="0">
                                    <c:if test='<%=language.equals("vn")%>'>
                                        Phân loại khu vực
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        Area Classification
                                    </c:if>
                                </option>
                                <c:forEach items="${addr1s}" var="addr1">
                                    <option value="${addr1.addr1_seq}">${addr1.addr1_name}</option>
                                </c:forEach>
                            </form:select>
                        </div>
                        <label for="keyWord"></label>
                        <c:if test='<%=language.equals("vn")%>'>
                            <form:input path="keyWord" type="text" placeholder="Tên cơ quan"
                                        style="width: 70%;"/>
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <form:input path="keyWord" type="text" placeholder="Agency Name"
                                        style="width: 70%;"/>
                        </c:if>
                        <button  id="btnSearch" class="btn btn-primary bold">
                            <c:if test='<%=language.equals("vn")%>'>
                                Tìm kiếm
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Search
                            </c:if>
                        </button>
                    </form:form>
                </div>

                <div class="row header-qa">
                    <div class="total">
                        <c:if test='<%=language.equals("vn")%>'>
                            Tổng
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Total
                        </c:if>
                        : ${totalRow}
                    </div>
                    <div class="page">
                        <c:if test='<%=language.equals("vn")%>'>
                            Trang
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Page
                        </c:if>
                        : ${agencySearch.page} /${totalPage}
                    </div>
                </div>

                <table class="table" style="margin-bottom: 30px;">
                    <caption></caption>
                    <thead>
                    <tr>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Logo cơ quan
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Agency logo
                            </c:if>
                        </th>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Tên cơ quan
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Agency Name
                            </c:if>
                        </th>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Địa chỉ
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Address
                            </c:if>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${agencies}" var="agency">
                        <tr>
                            <td class="logo-img">
                                <img src="/jarvis/file/view/${agency.ag_logo_file_uuid}" alt="logo agency">
                            </td>
                            <td class="name"><a href="/agency/view/${agency.ag_seq}">${agency.ag_name_vn}</a></td>
                            <td class="address">${agency.ag_addr}, ${agency.addr3_name}, ${agency.addr2_name}, ${agency.addr1_name}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                ${paging.page}
            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>
<script>
    $(document).ready(function () {
        let url = window.location.href;
        if (url.includes("ag_addr1=")) {
            let string = url.slice(url.lastIndexOf("ag_addr1=") + 9, url.lastIndexOf("ag_addr1=") + 10);
            let ag_addr = $('#ag_addr1 option');
            ag_addr.each(function () {
                if ($(this).val() === string) {
                    $('.select-selected').text($(this).text())
                }
            })
        }

        if (<%=language.equals("en")%>) {
            $('.table tbody tr td:nth-child(3)').prepend('Address : ');
        } else {
            $('.table tbody tr td:nth-child(3)').prepend('Địa chỉ : ');
        }
    });

    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    });
</script>
</body>

</html>
