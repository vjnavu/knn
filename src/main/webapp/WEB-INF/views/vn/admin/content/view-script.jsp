<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $(document).ready(function () {
        $('#deletePost').click(function () {
            if (confirm('Bạn muốn xóa nội dung này?')) {
                postRequest('/cms/content/delete/${contentView.ctn_seq}');
            }
        });
    })
    let CSRF_PARAMETER = $("meta[name='_csrf_parameter']").attr("content");
    let CSRF_HEADER = $("meta[name='_csrf_header']").attr("content");
    let CSRF_TOKEN = $("meta[name='_csrf']").attr("content");

    function postRequest(url, data) {
        const form = document.createElement("form");
        form.setAttribute("method", 'post');
        form.setAttribute("action", url);
        if (!data) data = {};
        data[CSRF_PARAMETER] = CSRF_TOKEN;
        for (let i in data) {
            let dataField = document.createElement("input");
            dataField.setAttribute("type", "hidden");
            dataField.setAttribute("name", i);
            dataField.setAttribute("value", data[i]);
            form.appendChild(dataField);
        }
        document.body.appendChild(form);
        form.submit();
    }
</script>
