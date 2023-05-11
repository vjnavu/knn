<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        request.getSession().setAttribute("language","vn");
        language = "vn";
    }
%>
<style>
    .tableQA a:hover {
        color: #2e9ad0;
    }

    .des-question {
        border-top: none !important;
        display: none;
        animation: growDown 300ms ease-in-out forwards;
        background: #ebebeb;
    }

    @keyframes growDown {
        0% {
            transform: scaleY(0)
        }

        80% {
            transform: scaleY(1.1)
        }

        100% {
            transform: scaleY(1)
        }
    }

    .des-question.active {
        display: table-row;
    }

    .des-question td {
        border-top: 0 !important;
        padding-top: 10px !important;
        padding-bottom: 0 !important;
    }

    .des-question .icon-q {
        display: inline-block;
        /*position: relative;*/
        bottom: 5px;
    }

    .des-question td:first-child {
        text-align: center;
    }

    .des-question td:nth-child(2) div {
        color: #666;
        margin-bottom: 15px;
        font-weight: 600;
        font-size: 14px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        padding-right: 5px;
    }

    .qa .tableQA {
        border-bottom: 1px solid #ddd;
    }

    @media screen and (max-width: 380px) {
        .table.tableQA colgroup col:last-child {
            width: 30% !important;
        }
    }

    .type-wp .password-wp {
        display: none;
    }

    .type-wp .password-wp.active {
        display: block;
    }

    .type-wp .password-wp {
        margin-top: 10px;
    }

    .type-wp .password-wp input {
        width: 300px;
        height: 40px;
        padding: 14px 20px;
        border: var(--border-color) 1px solid;
        color: #666;
        font-size: 15px;
        font-weight: 600;
        border-radius: 5px;
    }

    .icon {
        display: inline-block;
        margin-right: 10px;
    }

    /*    popup */
    .overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.7);
        transition: opacity .2s;
        visibility: hidden;
        opacity: 0;
    }

    .overlay:target {
        visibility: visible;
        opacity: 1;
    }

    .popup {
        margin: 412px auto;
        padding: 20px;
        background: #fff;
        border-radius: 5px;
        width: 30%;
        position: relative;
        transition: all .2s ease-in-out;
    }

    .popup .close {
        position: absolute;
        top: 20px;
        right: 30px;
        transition: all .2s;
        font-size: 30px;
        font-weight: bold;
        text-decoration: none;
        color: #333;
    }

    .popup .close:hover {
        color: var(--main-color);
    }

    .popup .content-popup {
        max-height: 30%;
        overflow: auto;
    }

    .popup h2 {
        font-size: 20px;
        margin-top: 0;
        color: #333;
        margin-bottom: 20px;
    }

    .popup .content-popup input {
        width: 340px;
        height: 40px;
        padding: 14px 20px;
        color: #666;
        font-size: 15px;
        font-weight: 600;
        border: var(--border-color) 1px solid;
        border-radius: 5px;
        margin-right: 5px;
    }

    @media screen and (max-width: 767px) {
        .content.qa .tableQA tr:not(.active) td:nth-child(1):before {
            <c:if test='<%=language.equals("vn")%>'> content: 'Số thứ tự : '</c:if>;
            <c:if test='<%=language.equals("en")%>'> content: 'No : '</c:if>;
            font-weight: bold;
        }

        .content.qa .tableQA tr:not(.active) td:nth-child(2):before {
            <c:if test='<%=language.equals("vn")%>'> content: 'Người đăng : '</c:if>;
            <c:if test='<%=language.equals("en")%>'> content: 'Posted By : '</c:if>;
            font-weight: bold;
        }

        .content.qa .tableQA tr:not(.active) td:nth-child(3):before {
            <c:if test='<%=language.equals("vn")%>'> content: 'Tiêu đề : '</c:if>;
            <c:if test='<%=language.equals("en")%>'> content: 'Title : '</c:if>;
            font-weight: bold;
        }

        .content.qa .tableQA tr:not(.active) td:nth-child(4):before {
            <c:if test='<%=language.equals("vn")%>'> content: 'Ngày soạn thảo : '</c:if>;
            <c:if test='<%=language.equals("en")%>'> content: 'Date : '</c:if>;
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
                <c:if test="${successMess != null}">
                    <div class="alert alert-success show">
                        <i class="icon icon-success"></i>
                            ${successMess}
                        <button type="button" class="btn btn-close">
                            x
                        </button>
                    </div>
                </c:if>
                <c:if test="${errorMess != null}">
                    <div class="alert alert-error show">
                        <i class="icon icon-error"></i>
                            ${errorMess}
                        <button type="button" class="btn btn-close">
                            x
                        </button>
                    </div>
                </c:if>

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
                        : ${qaSearch.page} /${totalPage}</div>
                </div>

                <table class="table tableQA">
                    <caption></caption>
                    <colgroup>
                        <col style="width: 10%;">
                        <col style="width: 20%;">
                        <col>
                        <col style="width: 15%;">
                    </colgroup>
                    <thead>
                    <tr>
                        <c:if test='<%=language.equals("vn")%>'>
                            <th scope="col">Số thứ tự</th>
                            <th scope="col">Người đăng</th>
                            <th scope="col">Tiêu đề</th>
                            <th scope="col">Ngày soạn thảo</th>
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <th scope="col">No.</th>
                            <th scope="col">Posted By</th>
                            <th scope="col">Title</th>
                            <th scope="col">Date</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${qas}" var="qa" varStatus="loop">
                        <tr class="title-question">
                            <td class="text-center">${(qaSearch.page - 1) * qaSearch.size + loop.index +1}</td>
                            <td>${qa.qa_email}</td>
                            <td class="tdTitle rowQ">
                                <c:if test="${qa.qa_type == 'pub'}">
                                    <a href="/news/qa/view/${qa.qa_seq}">
                                        <span>${qa.qa_title}</span>
                                    </a>
                                </c:if>
                                <c:if test="${qa.qa_type == 'pri'}">
                                    <a href="#popup">
                                        <input type="hidden" class="qa-private" value="${qa.qa_seq}"/>
                                        <span><i class="icon icon-private"></i>${qa.qa_title}</span>
                                    </a>
                                </c:if>
                            </td>
                            <td class="text-center"><fmt:formatDate value="${qa.qa_question_dt}"
                                                                    pattern="dd-MM-yyyy"/></td>
                        </tr>
                        <c:if test="${qa.qa_type == 'pub'}">
                            <tr class="des-question">
                                <td>
                                    <i class="icon icon-q"></i>
                                </td>
                                <td colspan="3">
                                    <div>${qa.qa_question}</div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="row" style="justify-content: flex-end;">
                    <a href="/news/qa/question" class="btn btn-primary">
                        <c:if test='<%=language.equals("vn")%>'>
                            Đặt câu hỏi
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Make a question
                        </c:if>
                    </a>
                </div>

                <div class="search-container">
                    <form:form action="/news/qa/questions" modelAttribute="qaSearch" id="searchForm"
                               method="get">
                        <form:input type="hidden" class="form-control" path="page" id="page"/>
                        <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                        <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                        <label for="keyWord"></label>
                        <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <sec:csrfInput />
                        <c:if test='<%=language.equals("vn")%>'>
                            <form:input path="keyWord" type="text" placeholder="Vui lòng nhập cụm từ tìm kiếm của bạn"
                                        />
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <form:input path="keyWord" type="text" placeholder="Please enter your search term"
                                        />
                        </c:if>
                        <button id="btnSearch" class="btn btn-primary bold">
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
<div id="popup" class="overlay">
    <div class="popup">
        <a href="#" class="close">&times;</a>
        <h2>Mật khẩu</h2>
        <div class="content-popup">
            <input type="password" path="qa-password" id="qa-password">
            <button class="btn" id="btnPassword">Gửi</button>
        </div>
    </div>
</div>
<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>
<script>
    let seq = '';
    $('.tdTitle').on('click', function () {
        seq = $(this).find('.qa-private').val();
    });

    $('#btnPassword').on('click', function () {
        let qaPassword = $('#qa-password').val();

        if (qaPassword != null) {
            $.ajax({
                url: '/news/qa/questions/private',
                type: 'POST',
                data: {
                    'password': qaPassword,
                    'seq': seq
                },
                success: function (data) {
                    if (data === '0') {
                        alert('Sai mật khẩu');
                    } else {
                        window.location.href = '/news/qa/private/' +data
                    }
                },
                error: function () {
                }
            });
        } else {
            alert('Password không hợp lệ');
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

    $('.tableQA a').hover(function () {
        $('.des-question').removeClass('active');
        $(this).parent().parent().next().addClass('active');
    })

    $('.btn-close').click(function () {
        $(this).parent().removeClass('show');
    });

    setTimeout(() => {
        $('.alert').removeClass('show');
    }, 4000);
</script>
</body>
</html>
