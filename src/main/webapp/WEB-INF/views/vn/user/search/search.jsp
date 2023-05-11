<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<style>
    .sub-nav span {
        margin-left: 10px;
    }

    .title-page {
        font-weight: 500;
    }
</style>
<body class="searchGen">
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>
<% String language = (String) request.getSession().getAttribute("language");
    if (language == null) {
        language = "vn";
        request.getSession().setAttribute("language", language);
    }
%>
<div class="breadcrumb-wrap">
    <div class="container">
        <ol class="breadcrumb">
            <c:if test='<%=language.equals("vn")%>'>
                <li><a href="/">Trang chủ</a></li>
                <li><span>Tìm kiếm</span></li>
            </c:if>
            <c:if test='<%=language.equals("en")%>'>
                <li><a href="/">Home</a></li>
                <li><span>Search</span></li>
            </c:if>
        </ol>
    </div>
</div>
<div class="body">
    <div class="container">
        <div class="row">
            <div class="lnb">
                <div class="menu-name">
                    <c:if test='<%=language.equals("vn")%>'>
                        Tìm kiếm
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        Search
                    </c:if>
                </div>
                <ul class="sub-nav">
                    <c:if test='<%=language.equals("vn")%>'>
                        <li id="all" class="active">
                            Tất cả <span>(${totalRow})</span>
                        </li>
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        <li id="all" class="active">
                            All <span>(${totalRow})</span>
                        </li>
                    </c:if>
                </ul>
                <ul class="sub-nav">
                    <c:if test='<%=language.equals("vn")%>'>
                        <li id="post">Bảng tin <span>(${totalRowP})</span></li>
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        <li id="post">Post <span>(${totalRowP})</span></li>
                    </c:if>
                </ul>
                <ul class="sub-nav">
                    <c:if test='<%=language.equals("vn")%>'>
                        <li id="content">Content <span>(${totalRowC})</span></li>
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        <li id="content">Content <span>(${totalRowC})</span></li>
                    </c:if>
                </ul>
            </div>
            <div class="content common">
                <div class="title-page">
                    <c:if test="${type eq 'all'}">
                        <c:if test='<%=language.equals("vn")%>'>
                            Có ${totalRow} kết quả tìm kiếm về "${keyWord}"
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            There are ${totalRow} search results for "${keyWord}"
                        </c:if>
                    </c:if>
                    <c:if test="${type eq 'post'}">
                        <c:if test='<%=language.equals("vn")%>'>
                            Có ${totalRowP} kết quả tìm kiếm về "${keyWord}"
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            There are ${totalRowP} search results for "${keyWord}"
                        </c:if>
                    </c:if>
                    <c:if test="${type eq 'content'}">
                        <c:if test='<%=language.equals("vn")%>'>
                            Có ${totalRowC} kết quả tìm kiếm về "${keyWord}"
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            There are ${totalRowC} search results for "${keyWord}"
                        </c:if>
                    </c:if>
                    <input type="text" hidden id="saveKey" value="${keyWord}"/>
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
                        :
                        <c:if test="${type eq 'all'}">
                            ${totalRow}
                        </c:if>
                        <c:if test="${type eq 'post'}">
                            ${totalRowP}
                        </c:if>
                        <c:if test="${type eq 'content'}">
                            ${totalRowC}
                        </c:if>
                    </div>
                    <div class="page">
                        <c:if test='<%=language.equals("vn")%>'>
                            Trang
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Page
                        </c:if>
                        : ${page} /${totalPage}
                    </div>
                </div>

                <table class="tableItem">
                    <caption></caption>
                    <colgroup>
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${result}" var="item">
                        <tr>
                            <td>
                                <ul>
                                    <li class="title">
                                        <c:if test="${item.type eq 'P'}">
                                        <a href="/post/view/${item.seq}"></c:if>
                                            <c:if test="${item.type eq 'C'}">
                                            <a href="/news/content/${item.seq}"></c:if>
                                                <c:if test='<%=language.equals("vn")%>'>
                                                    ${item.title_vn}
                                                </c:if>
                                                <c:if test='<%=language.equals("en")%>'>
                                                    <c:if test="${item.title_en eq '' or item.title_en eq null}">
                                                        ${item.title_vn}
                                                    </c:if>
                                                    <c:if test="${item.title_en != '' or item.title_en eq not null}">
                                                        ${item.title_en}
                                                    </c:if>
                                                </c:if>
                                            </a>
                                    </li>
                                    <li class="content">
                                        <c:if test='<%=language.equals("vn")%>'>
                                            ${item.text_vn}
                                        </c:if>
                                        <c:if test='<%=language.equals("en")%>'>
                                            <c:if test="${item.text_en eq '' or item.text_en eq null}">
                                                ${item.text_vn}
                                            </c:if>
                                            <c:if test="${item.text_en != '' or item.text_en eq not null}">
                                                ${item.text_en}
                                            </c:if>
                                        </c:if>
                                    </li>
                                </ul>
                            </td>
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
        <c:if test="${type eq 'all'}">
        $('.searchGen .pagination').addClass('all');
        $('#all').addClass('active');
        $('#post').removeClass('active');
        $('#content').removeClass('active');

        $('.searchGen .pagination.all>a').click(function () {
            $('#keyGen').val($('#saveKey').val());
            $('#pageGen').val($(this).attr("data-num"));
            $('#genSearchForm').attr('action', '/search')
            $('#genSearchForm').submit();
        });
        </c:if>

        <c:if test="${type eq 'post'}">
        $('.searchGen .pagination').addClass('post');
        $('#post').addClass('active');
        $('#all').removeClass('active');
        $('#content').removeClass('active');

        $('.searchGen .pagination.post>a').click(function () {
            $('#keyGen').val($('#saveKey').val());
            $('#pageGen').val($(this).attr("data-num"));
            $('#genSearchForm').attr('action', '/search/post')
            $('#genSearchForm').submit();
        });
        </c:if>

        <c:if test="${type eq 'content'}">
        $('.searchGen .pagination').addClass('content');
        $('#content').addClass('active');
        $('#all').removeClass('active');
        $('#post').removeClass('active');

        $('.searchGen .pagination.content>a').click(function () {
            $('#keyGen').val($('#saveKey').val());
            $('#pageGen').val($(this).attr("data-num"));
            $('#genSearchForm').attr('action', '/search/content')
            $('#genSearchForm').submit();
        });
        </c:if>

        $('#all').click(function () {
            $('#keyGen').val($('#saveKey').val());
            $('#pageGen').val(1);
            $('#genSearchForm').attr('action', '/search')
            $('#genSearchForm').submit();
        });

        $('#post').click(function () {
            $('#keyGen').val($('#saveKey').val());
            $('#pageGen').val(1);
            $('#genSearchForm').attr('action', '/search/post')
            $('#genSearchForm').submit();
        });

        $('#content').click(function () {
            $('#keyGen').val($('#saveKey').val());
            $('#pageGen').val(1);
            $('#genSearchForm').attr('action', '/search/content')
            $('#genSearchForm').submit();
        });

        let key = $('#saveKey').val();
        $('.tableItem .title a:contains(' + key + ')', document.body).each(function () {
            $(this).html($(this).html().replace(
                new RegExp(key, 'g'), '<span style="color:red">' + key + '</span>'
            ));
        });

        $('.tableItem .content:contains(' + key + ')', document.body).each(function () {
            $(this).html($(this).html().replace(
                new RegExp(key, 'g'), '<span style="color:red">' + key + '</span>'
            ));
        });
    })
</script>
</body>
</html>