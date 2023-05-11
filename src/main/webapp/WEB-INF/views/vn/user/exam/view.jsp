<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<style>
    .news-detail .main .slides img {
        margin: auto auto 42px auto;
        display: block;
        width: 840px;
        height: 500px;
        object-fit: contain;
    }

    .row-action {
        justify-content: space-around;
    }

    .row-action .action {
        margin: 10px 0;
    }

    .desc {
        margin-top: 30px;
    }

    .title-album {
        font-weight: 600;
        margin-bottom: 10px;
        margin-top: 20px;
    }

    .news-detail .main img {
        width: 240px;
    }

    a.disable {
        color: #000;
        cursor: default;
        pointer-events: none;
        background: #ddd;
    }
</style>
<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/views/vn/user/include/breadcrumb.jsp" charEncoding="UTF-8"/>
<div class="body">
    <div class="container">
        <div class="row">
            <div class="lnb">
                <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
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
            <div class="content">
                <div class="title-page">
                    <c:if test='<%=language.equals("vn")%>'>
                        ${breadcrumb.menuC3.mn_name_vn}
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        ${breadcrumb.menuC3.mn_name_en}
                    </c:if>
                </div>
                <hr>
                <div class="news-detail">
                    <div class="header">
                        <div class="title">${exam.exam_name}</div>
                        <div class="row">
                            <span class="date">
                                <c:if test='<%=language.equals("vn")%>'>
                                    <span>Ngày đăng: </span>
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    <span>Date: </span>
                                </c:if>
                               <fmt:formatDate value="${exam.exam_regis}"
                                               pattern="dd-MM-yyyy"/>
                            </span>
                        </div>
                    </div>
                    <div class="main">

                        <ul class="noti">
                            <li class="name">
                                <c:if test='<%=language.equals("vn")%>'>
                                    <span>Địa điểm thi: </span>
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    <span>Location: </span>
                                </c:if>
                                ${exam.exam_place}
                            </li>
                            <li class="time">
                                <c:if test='<%=language.equals("vn")%>'>
                                    <span>Thời gian: </span>
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    <span>Date: </span>
                                </c:if>
                                <fmt:formatDate value="${exam.exam_start_dt}"
                                                pattern="dd-MM-yyyy"/> ~ <fmt:formatDate
                                    value="${exam.exam_end_dt}"
                                    pattern="dd-MM-yyyy"/>
                            </li>
                        </ul>

                        <div class="row row-action">
                            <div class="action">
                                <a href="/jarvis/file/download/${exam.exam_candi_uuid}" class="btn btn-primary"
                                   style="padding: 5px 30px; border-radius: 0;" id="file-download">
                                    <c:if test='<%=language.equals("vn")%>'>Danh sách thí sinh</c:if>
                                    <c:if test='<%=language.equals("en")%>'>List of candidates</c:if>
                                </a>
                            </div>
                            <div class="action">
                                <a href="/exam/view/cer/${examSeq}" class="btn btn-primary"
                                   style="padding: 5px 30px; border-radius: 0;">
                                    <c:if test='<%=language.equals("vn")%>'>Nghề tổ chức thi</c:if>
                                    <c:if test='<%=language.equals("en")%>'>Organization examination skill</c:if>
                                </a>
                            </div>
                            <div class="action">
                                <a href="/exam/view/can/${examSeq}" class="btn btn-primary"
                                   style="padding: 5px 30px; border-radius: 0;">
                                    <c:if test='<%=language.equals("vn")%>'>Kết quả kỳ thi</c:if>
                                    <c:if test='<%=language.equals("en")%>'>Examination result</c:if>
                                </a>
                            </div>
                        </div>
                        <div class="desc">
                            ${exam.exam_desc}
                        </div>
                        <h1 class="title-album">
                            <c:if test='<%=language.equals("vn")%>'>
                                Thư viện ảnh
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Album
                            </c:if>
                        </h1>
                        <ul class="album">
                            <c:forEach items="${albums}" var="album">
                                <li class="album-image">
                                    <a>
                                        <c:forEach items="${album.album}" end="0" var="item">
                                            <img src="/jarvis/file/view/${item.file_uuid}" alt="Album thumbnail">
                                        </c:forEach>
                                        <p>${album.album_name}</p>
                                    </a>
                                    <div class="album-content">
                                        <i class="icon icon-close"></i>
                                        <div class="count"></div>
                                        <i class="next-btn icon-next"></i>
                                        <p class="title-album-element">${album.album_name}</p>
                                        <c:forEach items="${album.album}" var="items">
                                            <img src="/jarvis/file/view/${items.file_uuid}" class="album-element"
                                                 alt="Album element">
                                        </c:forEach>
                                        <i class="prev-btn icon-prev"></i>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <a href="/exam/${fn:toLowerCase(exam.exam_type)}" class="btn btn-primary"
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

<script>
    $(document).ready(function () {
        <c:if test="${exam.exam_candi_uuid == null}">
        $('.action > a#file-download').addClass('disable');
        </c:if>

        $('.album-image > a').on('click', function () {
            $(this).parent().find('.album-content').addClass('active');
            $('.album-content').find('img:first').addClass('active');
        });

        $('.next-btn').on('click', function () {
            let currentImg = $(this).parent().find('.album-element.active');
            let nextImg = currentImg.next('.album-element');
            if (nextImg.length) {
                currentImg.removeClass('active');
                nextImg.addClass('active');
            }
        });

        $('.prev-btn').on('click', function () {
            let currentImg = $(this).parent().find('.album-element.active');
            let prevImg = currentImg.prev('.album-element');
            if (prevImg.length) {
                currentImg.removeClass('active');
                prevImg.addClass('active');
            }
        });

        $('.icon-close').on('click', function () {
            $(this).parent().removeClass('active');
            $(this).parent().find('.album-element').removeClass('active');
        });
    });
</script>

</body>
</html>
