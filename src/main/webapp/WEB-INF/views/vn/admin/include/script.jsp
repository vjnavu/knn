<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src='${pageContext.request.contextPath}/assets/cms/js/mapbox-gl.js'></script>
<script src="${pageContext.request.contextPath}/assets/cms/js/vendor.bundle.js"></script>
<script src="${pageContext.request.contextPath}/assets/cms/js/theme.bundle.js"></script>
<script src="${pageContext.request.contextPath}/assets/cms/plugin/sweetalert2/sweetalert2.all.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
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
    });

    $(window).on('load', function () {
        var requestUrl = window.location.pathname;
        var urlSubstring = requestUrl.substring(0, getPosition(requestUrl, "/", 3));
        var bigNav = $("#sidebarCollapse .navbar-nav .nav-item a");
        var elementNav = $("#sidebarCollapse .navbar-nav .nav-item .collapse ul li a");

        elementNav.each(function () {
            if (requestUrl.includes('/cms/certificate/detail')) {
                bigNav.removeClass("collapsed");
                bigNav.attr("aria-expanded", false);
                $("#sidebarCollapse .navbar-nav .nav-item .collapse").removeClass("show");
                elementNav.removeClass("active");
                $('#cerDetail').addClass("active");
                $('#cerDetail').closest(".collapse").addClass("show");
                $('#cerDetail').closest(".collapse").parent().find(".nav-link").attr("aria-expanded", true);
            }
            if (requestUrl.includes('/post/')) {
                bigNav.removeClass("collapsed");
                bigNav.attr("aria-expanded", false);
                $("#sidebarCollapse .navbar-nav .nav-item .collapse").removeClass("show");
                elementNav.removeClass("active");
                $('#postMenu').addClass("active");
                $('#postMenu').closest(".collapse").addClass("show");
                $('#postMenu').closest(".collapse").parent().find(".nav-link").attr("aria-expanded", true);
            } else {
                if ($(this).attr("href") === urlSubstring) {
                    bigNav.removeClass("collapsed");
                    bigNav.attr("aria-expanded", false);
                    $("#sidebarCollapse .navbar-nav .nav-item .collapse").removeClass("show");
                    elementNav.removeClass("active");
                    $(this).addClass("active");
                    $(this).closest(".collapse").addClass("show");
                    $(this).closest(".collapse").parent().find(".nav-link").attr("aria-expanded", true);
                }
            }
        });
    });

    function getPosition(string, subString, index) {
        return string.split(subString, index).join(subString).length;
    }

    setTimeout(function () {
        $(".alert").removeClass("show");
    }, 3000);

    function cleanElementBeforeBlind(rootElement){
        let emptyObj = {};
        $(rootElement).find('input,select,span,div,td,textarea').each(function(i, el) {
            let name = el.getAttribute('name');
            if (!!name)
                emptyObj[name] = '';
        });
        bindObjectToElement(emptyObj, rootElement);

    }

    function bindObjectToElement(obj, rootElement){
        if (!obj || !rootElement) return;
        Object.keys(obj).forEach(function (name) {
            let $el = $(rootElement).find('[name=' + name + ']');
            if ($el.length < 1) return;

            let _tagName = $el.prop('tagName');
            if (_tagName === 'INPUT') {
                let _type = $el.attr('type').toUpperCase();

                if (_type === 'TEXT' || _type === 'HIDDEN') {
                    $el.val(obj[name]);
                }
                else if (_type === 'RADIO') {
                    $el.filter(':radio[value="' + obj[name] + '"]').prop('checked', true);
                }
                else if (_type === 'CHECKBOX') {
                    if (!!obj[name])
                        $el.prop('checked', true);
                }
            }else if(_tagName == 'TEXTAREA'){
                $el.val(obj[name]);
            }
            else if (_tagName === 'SELECT') {
                if (typeof obj[name] === undefined || obj[name] === null)
                    obj[name] = '';
                $el.val(obj[name]).trigger('change');
            }
            else if (_tagName === 'SPAN' || _tagName === 'DIV' || _tagName === 'TD') {
                $el.text(obj[name]);
            }
        })
    }
</script>
</body>
</html>
