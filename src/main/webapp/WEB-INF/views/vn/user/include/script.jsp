<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/assets/user/js/jquery.js"></script>
<script src="/assets/user/js/dropdown.js"></script>
<script src="/assets/user/js/slideshow.js"></script>
<script src="/assets/user/js/menu.js"></script>
<script src="/assets/user/js/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/cms/plugin/sweetalert2/sweetalert2.all.min.js"></script>
<script>
    $(document).ready(function () {
        <c:if test="${not empty alert}">
        Swal.fire({
            text: "${alert}",
            icon: 'error',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
        })
        </c:if>
        <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }%>
        if (<%=language.equals("vn") %>) {
            $('.language-wrap .select-selected').text('VIETNAM');
        } else if (<%=language.equals("en") %>) {
            $('.language-wrap .select-selected').text('ENGLISH');
        } else {
            $('.language-wrap .select-selected').text('GLOBAL');
        }
    });
    $('.language-wrap .select-items').click(function () {
        let value = $('#language').val()
        $.ajax({
            url: '/language/change',
            type: 'POST',
            data: {'language': value},
            success: function (data) {
                location.reload();
            },
            error: function () {
                alert('Đã xảy ra lỗi trong quá trình thay đổi ngôn ngữ')
            }
        });
    })
    $(document).ready(function () {
        $(function () {
            let token = $("input[name='_csrf']").val();
            let header = "X-CSRF-TOKEN";
            $(document).ajaxSend(function (e, xhr, options) {
                xhr.setRequestHeader(header, token);
            });
        });
    });

    $('#generalSearch').on('click', function () {
        if ($('#keyGen').val().trim() != '') {
            $('#pageGen').val('1');
            $('#genSearchForm').submit();
        }
    });
    $(document).ready(function () {
        $('#genSearchForm').on('keypress', function (e) {
            var keyPressed = e.keyCode || e.which;
            if (keyPressed === 13) {
                e.preventDefault();
                return false;
            }
        });
    });
</script>
