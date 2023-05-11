<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
<style>
    .table th:nth-child(1) {
        width: 10%;
    }

    table th:nth-child(2) {
        width: auto;
    }

    table th:nth-child(3) {
        width: 15%;
    }

    table th:nth-child(4) {
        width: 15%;
    }

    @media screen and (max-width: 767px) {
        .table-basic tbody tr td:nth-child(1):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Số Thứ Tự: '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'No.: '</c:if>;
            font-weight: bold;
        }

        .table-basic tbody tr td:nth-child(2):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Tiêu Đề: '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Title: '</c:if>;
            font-weight: bold;
        }

        .table-basic tbody tr td:nth-child(3):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Tệp Đính Kèm: '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Attachments: '</c:if>;
            font-weight: bold;
        }

        .table-basic tbody tr td:nth-child(4):before {;
        <c:if test='<%=language.equals("vn")%>'> content: 'Ngày Đăng Ký: '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Date: '</c:if>;
            font-weight: bold;
        }
    }
</style>
<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/views/vn/user/include/breadcrumb.jsp" charEncoding="UTF-8"/>
<div class="body">
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
                <div class="row header-qa">
                    <div class="total">
                        <c:if test='<%=language.equals("vn")%>'>
                            Tổng
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Total
                        </c:if>
                        : ${totalRow}</div>
                    <div class="page">
                        <c:if test='<%=language.equals("vn")%>'>
                            Trang
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Page
                        </c:if>
                        : ${postSearch.page} /${totalPage}
                    </div>
                </div>

                <table class="table table-basic" style="margin-bottom: 30px;">
                    <caption></caption>
                    <thead>
                    <tr>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Số thứ tự
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                No
                            </c:if>
                        </th>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Tiêu đề
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Title
                            </c:if>
                        </th>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Tệp đính kèm
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Attachments
                            </c:if>
                        </th>
                        <th scope="col">
                            <c:if test='<%=language.equals("vn")%>'>
                                Ngày đăng ký
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Date
                            </c:if>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${posts}" var="post" varStatus="loop">
                        <tr>
                            <td class="text-center">${(postSearch.page - 1) * postSearch.size + loop.index +1}</td>
                            <td class="tdTitle"><a href="/news/basic/view/${post.post_seq}">
                                <c:if test='<%=language.equals("vn")%>'>
                                    ${post.post_title_vn}
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    <c:if test="${post.post_title_en} == ''">
                                        ${post.post_title_vn}
                                    </c:if>
                                    <c:if test="${post.post_title_en} != ''">
                                        ${post.post_title_en}
                                    </c:if>
                                </c:if>
                            </a>
                            </td>
                            <td class="tdIcon">
                                <c:if test="${post.fileVOList.size() > 0}">
                                    <c:forEach items="${post.fileVOList}" var="file">
                                        <a href="/jarvis/file/download/${file.file_uuid}" class="icon icon-file ">
                                            <span class="type-name icon-${file.file_ext}">${file.file_ext}</span>
                                        </a>
                                        <div class="tooltip">${file.file_name}</div>
                                    </c:forEach>
                                </c:if>
                            </td>
                            <td class="date text-center"><fmt:formatDate value="${post.post_reg_dt}"
                                                                         pattern="dd-MM-yyyy"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="search-container">
                    <form:form action="/news/board/${boardSeq}" modelAttribute="postSearch" id="searchForm"
                               method="get">
                        <form:input type="hidden" class="form-control" path="page" id="page"/>
                        <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                        <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                        <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <sec:csrfInput />
                        <label for="keyWord"></label>
                        <c:if test='<%=language.equals("vn")%>'>
                            <form:input path="keyWord" type="text" placeholder="Vui lòng nhập từ khóa tìm kiếm" />
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <form:input path="keyWord" type="text" placeholder="Please enter your search term"
                                        />
                        </c:if>
                        <button id="btnSearch" class="btn btn-primary bold" style="width: 150px;">
                            <c:if test='<%=language.equals("vn")%>'>
                                Tìm kiếm
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Search
                            </c:if>
                        </button>
                    </form:form>
                </div>
                ${paging.page}
            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>
<script>
    $('#btnSearch').click(function () {
        $('#page').val('1');
        $('#searchForm').submit();
    });
    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    });

    var icon = $('.tdIcon .icon');

    icon.hover(function () {
        $(this).parent().find('.tooltip').addClass('active');
    });

    icon.mouseleave(function () {
        $('.tooltip').removeClass('active');
    });
</script>
</body>
</html>
