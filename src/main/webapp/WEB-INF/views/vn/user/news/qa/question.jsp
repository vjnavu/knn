<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<style>
    input, textarea {
        padding: 5px 10px;
    }

    .password-wp {
        display: none !important;
    }

    .password-wp.active {
        display: table !important;
    }

    .password-wp dd p {
        opacity: 50%;
        font-size: 14px;
        margin-top: 10px;
    }
</style>
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
                <div class="alert alert-error">
                    <i class="icon icon-error"></i>
                    <p id="text-error"></p>
                    <button type="button" class="btn btn-close">
                        x
                    </button>
                </div>

                <form:form method="post" modelAttribute="qa" action="/news/qa/question/${action}" id="formQuestion">
                    <c:if test="${action == 'update'}">
                        <form:input path="qa_seq" type="hidden"/>
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
                    <div class="table-qa">
                        <dl>
                            <dt>Email <small>*</small></dt>
                            <dd>
                                <label for="qa_email"></label>
                                <form:input path="qa_email" id="qa_email" type="text"/>
                            </dd>
                        </dl>
                        <dl>
                            <dt>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Tiêu đề
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Title
                                </c:if><small>*</small></dt>
                            <dd>
                                <label for="qa_title"></label>
                                <form:input path="qa_title" type="text" id="qa_title"/>
                            </dd>
                        </dl>
                        <c:if test="${action == 'new'}">
                            <dl>
                                <dt>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        Loại câu hỏi
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        Type of Questions
                                    </c:if>
                                    <small>*</small>
                                </dt>
                                <dd>
                                    <label for="qa_type"></label>
                                    <div class="custom-select" style="width: 130px;">
                                        <select name="qa_type" id="qa_type">
                                            <c:if test='<%=language.equals("vn")%>'>
                                                <option value="pub">Công khai</option>
                                                <option value="pub">Công khai</option>
                                                <option value="pri">Riêng tư</option>
                                            </c:if>
                                            <c:if test='<%=language.equals("en")%>'>
                                                <option value="pub">Public</option>
                                                <option value="pub">Public</option>
                                                <option value="pri">Private</option>
                                            </c:if>
                                        </select>
                                    </div>
                                </dd>
                            </dl>
                            <dl class="password-wp">
                                <dt>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        Mật khẩu
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        Password
                                    </c:if>
                                    <small>*</small>
                                </dt>
                                <dd>
                                    <label for="qa_password"></label>
                                    <form:input path="qa_password" id="qa_password" type="password"/>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        <p>Sử dụng mật khẩu để xem, sửa hoặc xoá câu hỏi riêng tư</p>
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        <p>Use a password to view, edit or delete private questions</p>
                                    </c:if>
                                </dd>
                            </dl>
                        </c:if>
                        <dl>
                            <dt>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Nội dung câu hỏi
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Content Questions
                                </c:if>
                                <small>*</small></dt>
                            <dd>
                                <label for="qa_question"></label>
                                <form:textarea path="qa_question" id="qa_question" cols="30" rows="10"/></dd>
                        </dl>
                    </div>

                    <div class="row" style="justify-content: center; margin-bottom: 100px;">
                        <a class="btn btn-primary" id="postQuestion" style="margin-right: 5px;">
                            <c:if test='<%=language.equals("vn")%>'>
                                Đăng câu hỏi
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Post
                            </c:if>
                        </a>
                        <a href="/news/qa/questions" class="btn btn-dark">
                            <c:if test='<%=language.equals("vn")%>'>
                                Hủy
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Cancel
                            </c:if>
                        </a>
                    </div>
                </form:form>
                <div>
                    <c:if test="${not empty wordFilter}">
                        <c:forEach items="${wordFilter}" var="word"><p class="word" hidden>${word}</p></c:forEach>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>

<script>
    $(document).ready(function () {
        $('.select-items').on('click', function () {
            if ($('#qa_type').val() === ('pri')) {
                $('.password-wp').addClass('active');
            } else {
                $('.password-wp').removeClass('active');
            }
        });

        <c:if test="${action == 'update'}">
        $('#qa_email').attr('readonly', true);
        </c:if>
    });

    var mess = '';
    $('#postQuestion').click(function () {
        if ($('#qa_email').val() === '' || $('#qa_title').val() === '' || $('#qa_question').val() === '') {
            <c:if test='<%=language.equals("vn")%>'>
            mess = 'Vui lòng điền đầy đủ thông tin câu hỏi';
            </c:if>
            <c:if test='<%=language.equals("en")%>'>
            mess = 'Please fill out the question completely';
            </c:if>

            popup(mess);
        } else if (!isEmail($('#qa_email').val())) {
            <c:if test='<%=language.equals("vn")%>'>
            mess = 'Vui lòng nhập đúng định dạng email: abc@example.com';
            </c:if>
            <c:if test='<%=language.equals("en")%>'>
            mess = 'Please enter correct email format: abc@example.com';
            </c:if>
            popup(mess);
        } else if (checkBlockWord()) {
            $('#formQuestion').submit();
        }
    });

    function popup(mess) {
        $('#text-error').html(mess);
        $('.alert-error').addClass('show');
    }

    $('.btn-close').click(function () {
        $(this).parent().removeClass('show');
    });

    function isEmail(email) {
        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return regex.test(email);
    }

    function checkBlockWord() {
        var checkResult = true;
        var filterWordArr = [];
        $('.word').each(function () {
            var word = $(this).text();
            if (word !== undefined && word !== "") {
                filterWordArr.push(word.trim());
            }
        });
        var title_qa = $('#qa_title').val();
        var question_qa = $('#qa_question').val();
        if (filterWordArr.length > 0) {
            for (var i = 0; i < filterWordArr.length; i++) {
                if (title_qa.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                    <c:if test='<%=language.equals("vn")%>'>
                    mess = "Tiêu đề câu hỏi chứa từ không hợp lệ: " + filterWordArr[i];
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                    mess = "Question title contains invalid word: " + filterWordArr[i];
                    </c:if>
                    popup(mess);
                    $('#qa_title').focus();
                    checkResult = false;
                    break;
                }
                if (question_qa.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                    <c:if test='<%=language.equals("vn")%>'>
                    mess = "Nội dung câu hỏi chứa từ không hợp lệ: " + filterWordArr[i];
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                    mess = "The content of the question contains invalid words" + filterWordArr[i];
                    </c:if>
                    popup(mess);
                    $('#qa_question').focus();
                    checkResult = false;
                    break;
                }
            }
        }
        return checkResult;
    }

    setTimeout(() => {
        $('.alert').removeClass('show');
    }, 4000);
</script>
</body>
</html>
