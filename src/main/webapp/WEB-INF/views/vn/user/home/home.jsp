<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>

<div class="body homepage">
    <c:if test="${errorMess != null}">
        <div class="alert alert-error show">
            <i class="icon icon-error"></i>
                ${errorMess}
            <button type="button" class="btn btn-close">
                x
            </button>
        </div>
    </c:if>
    <div class="head">
        <div class="container">
            <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
            <form:form action="/" id="searchForm"
                       method="get">
                <sec:csrfInput />
            </form:form>
            <div class="row flex-center">
                <div class="slide-container">

                    <c:forEach items="${mvs}" var="item" varStatus="loop">
                        <div class="slides" id="${loop.index}">
                            <a href="${item.lo_link}"
                                    <c:if test="${item.lo_target_blank eq 'Y'}">
                                        target="_blank"
                                    </c:if>
                                    <c:if test="${item.lo_target_blank eq 'N'}">
                                        target="_parent"
                                    </c:if>
                            >
                                <img src="/jarvis/file/view/${item.lo_img_file_uuid}" alt="Slide image">
                                <h2>${item.lo_title}
                                    ${item.lo_descr}
                                </h2>
                            </a>
                        </div>
                    </c:forEach>
                    <%-- 2022/06/29 slide change delete
                    <span class="btn-change" id="next" style="display: none;"></span>
                    <span class="btn-change" id="prev" style="display: none;"></span>
                    <div class="change-img">
                        <c:forEach items="${mvs}" var="item" varStatus="loop">
                            <span class="dot active" idx="${loop.index}"></span>
                        </c:forEach>
                    </div>
                    --%>
                </div>
                <div class="new-news">
                    <div class="header">
                        <c:if test='<%=language.equals("vn")%>'>
                            <h1>Tin mới</h1>
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <h1>News</h1>
                        </c:if>
                        <a href="/news/board/1"><i class="icon icon-plus" style="font-size: 0">Tin Moi</i></a>
                    </div>
                    <div class="body">
                        <c:forEach items="${posts}" var="post">
                            <a href="/post/view/${post.post_seq}">
                                <div class="card">
                                    <c:if test="${post.check_new == true}">
                                        <i class="icon-new"></i>
                                    </c:if>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        <div class="card-title">${post.post_title_vn}</div>
                                        <div class="card-content">
                                                ${post.post_desc_vn}
                                        </div>
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        <div class="card-title">
                                            <c:if test="${post.post_title_en == ''}">
                                                ${post.post_title_vn}
                                            </c:if>
                                            <c:if test="${post.post_title_en != ''}">
                                                ${post.post_title_en}
                                            </c:if>
                                        </div>
                                        <div class="card-content">
                                            <c:if test="${post.post_desc_en == ''}">
                                                ${post.post_desc_vn}
                                            </c:if>
                                            <c:if test="${post.post_desc_en != ''}">
                                                ${post.post_desc_en}
                                            </c:if>
                                        </div>
                                    </c:if>
                                    <div class="card-date"><fmt:formatDate value="${post.post_reg_dt}"
                                                                           pattern="dd-MM-yyyy"/></div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="cer-list">
                    <div class="header">
                        <c:if test='<%=language.equals("vn")%>'>
                            <h1>Danh mục chứng chỉ</h1>
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <h1>Certificate Category</h1>
                        </c:if>
                        <div class="row">
                            <a class="prev"></a>
                            <a class="next"></a>
                            <a href="/certificate/category" style="font-size: 0">1<i class="icon icon-plus"></i></a>
                        </div>
                    </div>
                    <div class="body">
                        <div class="slideshow-container type1">
                            <c:forEach items="${cert1s}" var="cert1">
                                <c:forEach items="${cert1}" var="certSub">
                                    <div>
                                        <a class="a-link" href="/certificate/category/list/${certSub.cert1_seq}">
                                            <div class="cer-item">
                                                <img src="/jarvis/file/view/${certSub.cert1_icon_uuid}"
                                                     alt="Icon certificate">
                                                <h1>${certSub.cert1_name}</h1>
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="body-1">
        <div class="container">
            <div class="row">
                <div class="col-6">
                    <div class="header">
                        <c:if test='<%=language.equals("vn")%>'>
                            <h1>Tổ chức đánh giá</h1>
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <h1>Agency</h1>
                        </c:if>
                        <div>
                            <a href="/agency" style="font-size: 0">1<i class="icon icon-plus bgColor"></i></a>
                        </div>
                    </div>
                    <div class="row maxWidth1">
                        <c:forEach items="${agencies}" var="agency">
                            <a href="/agency/view/${agency.ag_seq}">
                                <div class="cer-item">
                                    <img src="/jarvis/file/view/${agency.ag_logo_file_uuid}" class="logo-agency"
                                         alt="logo agency">
                                </div>
                                <c:if test='<%=language.equals("vn")%>'>
                                    <h1 class="title-agency">${agency.ag_name_vn}</h1>
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    <h1 class="title-agency">${agency.ag_name_en}</h1>
                                </c:if>
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-6">
                    <div class="header">
                        <c:if test='<%=language.equals("vn")%>'>
                            <h1>Tin tức cơ quan</h1>
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <h1>Agency News</h1>
                        </c:if>
                        <div>
                            <a href="/events" style="font-size: 0">1<i class="icon icon-plus bgColor"></i></a>
                        </div>
                    </div>
                    <div class="row maxWidth1">
                        <c:forEach items="${videos}" var="video">
                            <a href="/post/view/${video.post_seq}">
                                <div class="news-item video-type">
                                    <c:if test="${video.post_avatar_uuid == null}">
                                        <img class="thumbnail-default"
                                             src="${video.post_video_url}"
                                             alt="Thumbnail video">
                                    </c:if>
                                    <c:if test="${video.post_avatar_uuid != null}">
                                        <img src="/jarvis/file/view/${video.post_avatar_uuid}" alt="Thumbnail video">
                                    </c:if>
                                </div>
                            </a>
                        </c:forEach>
                        <c:forEach items="${events}" var="event">
                            <a href="javascript:void(0)">
                                <div class="news-item">
                                    <img src="/jarvis/file/view/${event.album[0].file_uuid}" alt="Thumbnail news">
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="body-2">
        <div class="container">
            <div class="row">
                <div class="col-6">
                    <c:if test='<%=language.equals("vn")%>'>
                        <div class="header"><h1>Phát triển kỹ năng nghề</h1></div>
                        <div class="row maxWidth1">
                            <a href="#">
                                <div class="cer-item">
                                    <div class="icon-wrap">
                                        <div class="ptknn icon1"></div>
                                        <h1>Ủy ban công nghệ doanh nghiệp</h1>
                                    </div>
                                </div>
                            </a>

                            <a href="#">
                                <div class="cer-item">
                                    <div class="icon-wrap">
                                        <div class="ptknn icon2"></div>
                                        <h1>Tiêu chuẩn kỹ năng nghề</h1>
                                    </div>
                                </div>
                            </a>

                            <a href="#">
                                <div class="cer-item">
                                    <div class="icon-wrap">
                                        <div class="ptknn icon3"></div>
                                        <h1>Trình độ kỹ thuật nghề cần thiết</h1>
                                    </div>
                                </div>
                            </a>
                            <a href="#">
                                <div class="cer-item">
                                    <div class="icon-wrap">
                                        <div class="ptknn icon4"></div>
                                        <h1>Thống kê trình độ kỹ thuật nghề</h1>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        <div class="header"><h1>Professional skill development</h1></div>
                        <div class="row maxWidth1">
                            <a href="#">
                                <div class="cer-item">
                                    <div class="icon-wrap">
                                        <div class="ptknn icon1"></div>
                                        <h1>Corporate Technology Committee</h1>
                                    </div>
                                </div>
                            </a>

                            <a href="#">
                                <div class="cer-item">
                                    <div class="icon-wrap">
                                        <div class="ptknn icon2"></div>
                                        <h1>Vocational skill standard</h1>
                                    </div>
                                </div>
                            </a>

                            <a href="#">
                                <div class="cer-item">
                                    <div class="icon-wrap">
                                        <div class="ptknn icon3"></div>
                                        <h1>Required level of occupational skill</h1>
                                    </div>
                                </div>
                            </a>
                            <a href="#">
                                <div class="cer-item">
                                    <div class="icon-wrap">
                                        <div class="ptknn icon4"></div>
                                        <h1>Vocational skill level statistics</h1>
                                    </div>
                                </div>
                            </a>
                        </div>

                    </c:if>
                </div>
                <div class="col-6">
                    <div class="header">
                        <c:if test='<%=language.equals("vn")%>'>
                            <h1>Thông báo</h1>
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <h1>Notification</h1>
                        </c:if>
                    </div>
                    <div class="row maxWidth1">
                        <%-- change start //  changer : choi gyeong won , plus div className : card-wrap, type-differ --%>
                        <a href="/exam/view/${examVn.exam_seq}">
                            <div class="card">
                                <div class="card-wrap type-differ">
                                    <div class="card-title">${examVn.exam_name}</div>
                                    <div class="card-content">
                                        ${examVn.exam_desc}
                                    </div>
                                    <div class="card-date">
                                        <fmt:formatDate value="${examVn.exam_start_dt}"
                                                        pattern="dd/MM/yyyy"/> - <fmt:formatDate
                                            value="${examVn.exam_end_dt}"
                                            pattern="dd/MM/yyyy"/></div>
                                </div>
                            </div>
                        </a>
                        <a href="/exam/view/${examIn.exam_seq}">
                            <div class="card">
                                <div class="card-wrap type-differ">
                                    <div class="card-title">${examIn.exam_name}</div>
                                    <div class="card-content">
                                        ${examIn.exam_desc}
                                    </div>
                                    <div class="card-date">
                                        <fmt:formatDate value="${examIn.exam_start_dt}"
                                                        pattern="dd/MM/yyyy"/> - <fmt:formatDate
                                            value="${examIn.exam_end_dt}"
                                            pattern="dd/MM/yyyy"/></div>
                                </div>
                            </div>
                        </a>
                        <a href="/news/content/10">
                            <div class="card" style="text-align: center;">
                                <div class="card-wrap">
                                    <div class="icon icon-marking"
                                         style="justify-content: center; margin-bottom: 10px;"></div>
                                    <div class="card-title">THẺ ĐÁNH GIÁ VIÊN</div>
                                    <div class="card-content" style="font-size: 12px;">Danh mục thẻ</div>
                                </div>
                            </div>
                        </a>
                        <a href="/news/board/12">
                            <div class="card" style="text-align: center;">
                                <div class="card-wrap">
                                    <div class="icon icon-legal-document"
                                         style="justify-content: center; margin-bottom: 10px;"></div>
                                    <div class="card-title">TÀI LIỆU</div>
                                    <div class="card-content" style="font-size: 12px;">Quy định pháp luật</div>
                                </div>
                            </div>
                        </a>
                        <%--   change end // date : 2022.06.30 --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="slideshow-container type2">
            <c:forEach items="${collabs}" var="collab">
                <c:forEach items="${collab}" var="clb">
                    <div class="slide-item-width">
                        <a href="${clb.lo_link}"
                                <c:if test="${clb.lo_target_blank eq 'Y'}">
                                    target="_blank"
                                </c:if>
                                <c:if test="${clb.lo_target_blank eq 'N'}">
                                    target="_parent"
                                </c:if>
                        >
                            <img src="/jarvis/file/view/${clb.lo_img_file_uuid}" alt="Logo collaboration">
                        </a>
                    </div>
                </c:forEach>
            </c:forEach>
            <!-- Next and previous buttons -->
        </div>
    </div>
    <div class="sub-banner">
        <div class="container">
            <div class="row f-between">
                <div class="autoSlide">
                    <ul>
                        <c:forEach items="${concerns}" var="concern">
                            <li>
                                <a href="${concern.lo_link}"
                                        <c:if test="${concern.lo_target_blank eq 'Y'}">
                                            target="_blank"
                                        </c:if>
                                        <c:if test="${concern.lo_target_blank eq 'N'}">
                                            target="_parent"
                                        </c:if>
                                   style="display: inline-block">
                                    <img src="/jarvis/file/view/${concern.lo_img_file_uuid}" alt="${concern.lo_descr}">
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/home/home-script.jsp" charEncoding="UTF-8"/>

<script>
    $(document).ready(() => {
        $('.thumbnail-default').each(function () {
            var text = this.src;
            if (text.includes('youtube.com')) {
                var urlId = text.slice(text.indexOf('=') + 1, text.length);
                var thumbnail = text.replace(text, 'https://img.youtube.com/vi/' + urlId + '/hqdefault.jpg');
                this.src = thumbnail;
            }
        });
        setTimeout(() => {
            $('.alert').removeClass('show');
        }, 4000);
    });
</script>
</body>
</html>