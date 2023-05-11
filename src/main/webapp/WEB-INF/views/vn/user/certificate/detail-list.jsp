<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                    <c:if test="${action != null && action != ''}">
                        <form:form action="${action}"
                                   modelAttribute="catSearch" id="searchForm"
                                   method="get">
                            <form:input type="hidden" class="form-control" path="page" id="page"/>
                            <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                            <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                            <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <sec:csrfInput />
                            <div class="custom-select" id="cert1" style="width:35%;">
                                <label for="cert1_seq"></label>
                                <form:select path="cert1_seq" id="cert1_seq">
                                    <option value="">
                                        <c:if test='<%=language.equals("vn")%>'>
                                            Phân loại chứng chỉ cấp 1
                                        </c:if>
                                        <c:if test='<%=language.equals("en")%>'>
                                            Classification of certificates level 1
                                        </c:if>
                                    </option>
                                    <c:forEach items="${cert1s}" var="cert1">
                                        <option
                                                <c:if test="${activeCert1 != '' && activeCert1 == cert1.cert1_seq}">
                                                    selected
                                                </c:if>
                                                value="${cert1.cert1_seq}">${cert1.cert1_name}
                                        </option>
                                    </c:forEach>
                                </form:select>
                            </div>
                            <div class="custom-select" id="cert2" style="width:35%; margin: 0 5px">
                                <label for="cert2_seq"></label>
                                <form:select path="cert2_seq" id="cert2_seq">
                                    <option value="">
                                        <c:if test='<%=language.equals("vn")%>'>
                                            Phân loại chứng chỉ cấp 2
                                        </c:if>
                                        <c:if test='<%=language.equals("en")%>'>
                                            Classification of certificates level 2
                                        </c:if>
                                    </option>
                                    <c:forEach items="${cert2s}" var="cert2">
                                        <option value="${cert2.cert2_seq}">${cert2.cert2_name}</option>
                                    </c:forEach>
                                </form:select>
                            </div>
                            <label for="keyWord"></label>
                            <c:if test='<%=language.equals("vn")%>'>
                                <form:input path="keyWord" type="text" placeholder="Tên chứng chỉ"
                                            cssStyle="width: 195px;"/>
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                <form:input path="keyWord" type="text" placeholder="Certificate Name"
                                            cssStyle="width: 195px;"/>
                            </c:if>
                            <button  id="btnSearch" class="btn btn-primary bold" style="width: 13%; padding:10px 0px;">
                                <c:if test='<%=language.equals("vn")%>'>
                                    Tìm kiếm
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Search
                                </c:if>
                            </button>
                        </form:form>
                    </c:if>
                    <c:if test="${action == null || action == ''}">
                        <form:form action="/certificate/detail"
                                   modelAttribute="catSearch" id="searchForm"
                                   method="get">
                            <form:input type="hidden" class="form-control" path="page" id="page"/>
                            <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                            <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                            <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <sec:csrfInput />
                            <div class="custom-select" id="cert1" style="width:35%;">
                                <label for="cert1_seq"></label>
                                <form:select path="cert1_seq" id="cert1_seq">
                                    <option value="">
                                        <c:if test='<%=language.equals("vn")%>'>
                                            Phân loại chứng chỉ cấp 1
                                        </c:if>
                                        <c:if test='<%=language.equals("en")%>'>
                                            Classification of certificates level 1
                                        </c:if>
                                    </option>
                                    <c:forEach items="${cert1s}" var="cert1">
                                        <option
                                                <c:if test="${activeCert1 != '' && activeCert1 == cert1.cert1_seq}">
                                                    selected
                                                </c:if>
                                                value="${cert1.cert1_seq}">${cert1.cert1_name}
                                        </option>
                                    </c:forEach>
                                </form:select>
                            </div>
                            <div class="custom-select" id="cert2" style="width:35%; margin: 0 5px">
                                <label for="cert2_seq"></label>
                                <form:select path="cert2_seq" id="cert2_seq">
                                    <option value="">
                                        <c:if test='<%=language.equals("vn")%>'>
                                            Phân loại chứng chỉ cấp 2
                                        </c:if>
                                        <c:if test='<%=language.equals("en")%>'>
                                            Classification of certificates level 2
                                        </c:if>
                                    </option>
                                    <c:forEach items="${cert2s}" var="cert2">
                                        <option value="${cert2.cert2_seq}">${cert2.cert2_name}</option>
                                    </c:forEach>
                                </form:select>
                            </div>
                            <label for="keyWord"></label>
                            <c:if test='<%=language.equals("vn")%>'>
                                <form:input path="keyWord" type="text" placeholder="Tên chứng chỉ"
                                            cssStyle="width: 20%;"/>
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                <form:input path="keyWord" type="text" placeholder="Certificate Name"
                                            cssStyle="width: 20%;"/>
                            </c:if>
                            <button  id="btnSearch" class="btn btn-primary bold" style="width: 13%; padding:10px 0px;">
                                <c:if test='<%=language.equals("vn")%>'>
                                    Tìm kiếm
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Search
                                </c:if>
                            </button>
                        </form:form>
                    </c:if>

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
                        : ${catSearch.page} /${totalPage}
                    </div>
                </div>

                <table class="table noRes" style="margin-bottom: 30px;">
                    <caption></caption>
                    <colgroup>
                        <col style="width: 10%;">
                        <col style="width: 35%;">
                        <col style="width: 35%;">
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Số thứ tự
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                No.
                            </c:if>
                        </th>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Danh mục
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Category
                            </c:if>
                        </th>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Tên chứng chỉ
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Certificate Name
                            </c:if>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${cert3s}" var="cert3" varStatus="loop">
                        <tr>
                            <td class="text-center">${(catSearch.page - 1) * catSearch.size + loop.index +1}</td>
                            <td class="tdTitle">${cert3.cert1_name} > ${cert3.cert2_name}</td>
                            <td class="tdContent"><a
                                    href="/certificate/detail/view/${cert3.cert3_seq}">${cert3.cert3_name}</a></td>
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
        if (url.includes("cert2_seq=")) {
            let string = url.slice(url.lastIndexOf("cert2_seq=") + 10, url.lastIndexOf("cert2_seq=") + 16);
            let cert2 = $('#cert2 option');
            cert2.each(function () {
                if ($(this).val() === string) {
                    $('#cert2 .select-selected').text($(this).text())
                }
            })
        }
    });

    $('#btnSearch').click(function () {
        $('#page').val('1');
        $('#searchForm').submit();
    });
    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    });
    $('#cert1 .select-items').click(function () {
        let cert1_seq = $('#cert1_seq').val();
        $('#searchForm').attr('action', '/certificate/detail/list/' + cert1_seq);
        $.ajax({
            url: '/certificate/cert2/' + cert1_seq,
            type: 'POST',
            success: function (data) {
                if (data) {
                    $('#cert2_seq option:not(:first)').remove();
                    $('#cert2 .select-items').empty();
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $('#cert2_seq').append($('<option/>', {
                                value: data[i]["cert2_seq"],
                                text: data[i]["cert2_name"]
                            }));
                            $('#cert2 .select-items').append($('<div onclick="chooseCert2(' + "'" + data[i]['cert2_name'] + "'" + ')">' + data[i]["cert2_name"] + '</div>', {}));
                        }
                    }
                }
            }
        })
    });

    function chooseCert2(cert2Name) {
        $('#cert2 .select-selected').text(cert2Name);
        $('#cert2 option').filter(function () {
            return $(this).text() == cert2Name;
        }).prop('selected', true);
    }

</script>
</body>
</html>
