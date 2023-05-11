<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<body>
<c:import url="/WEB-INF/views/vn/admin/include/navigation.jsp" charEncoding="UTF-8"/>

<div class="main-content">
    <!-- HEADER -->
    <div class="header">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center">
                    <div class="col">
                        <h5 class="sub-header text-truncate">Homepage Management System</h5>
                        <h1 class="header-title text-truncate">DASHBOARD</h1>
                    </div>
                    <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <h2>Trạng thái quản trị viên</h2>
        <div class="row">
            <div class="col-12 col-lg-6 col-xl">
                <div class="card">
                    <div class="card-body">
                        <div class="row align-items-center gx-0">
                            <div class="col">
                                <h6 class="text-uppercase text-muted mb-2">Quản trị viên DSD</h6>
                                <span class="h2 mb-0">
                                    <c:if test="${dsd != null}">${dsd}</c:if>
                                    <c:if test="${dsd == null}">0</c:if>
                                </span>
                            </div>
                            <div class="col-auto"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-6 col-xl">
                <div class="card">
                    <div class="card-body">
                        <div class="row align-items-center gx-0">
                            <div class="col">
                                <h6 class="text-uppercase text-muted mb-2">Quản trị viên NSAO</h6>
                                <span class="h2 mb-0">
                                    <c:if test="${nsao != null}">${nsao}</c:if>
                                    <c:if test="${nsao == null}">0</c:if>
                                </span>
                            </div>
                            <div class="col-auto"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-6 col-xl">
                <div class="card">
                    <div class="card-body">
                        <div class="row align-items-center gx-0">
                            <div class="col">
                                <h6 class="text-uppercase text-muted mb-2">Quản trị viên chờ phê duyệt</h6>
                                <span class="h2 mb-0">
                                    <c:if test="${request != null}">${request}</c:if>
                                    <c:if test="${request == null}">0</c:if>
                                </span>
                            </div>
                            <div class="col-auto"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-6 col-xl">
                <div class="card">
                    <div class="card-body">
                        <div class="row align-items-center gx-0">
                            <div class="col">
                                <h6 class="text-uppercase text-muted mb-2">Quản trị viên ngừng sử dụng</h6>
                                <span class="h2 mb-0">
                                    <c:if test="${block != null}">${block}</c:if>
                                    <c:if test="${block == null}">0</c:if>
                                </span>
                            </div>
                            <div class="col-auto"></div>
                        </div>
                    </div>
                </div>
            </div>

        </div> <!-- / .row -->


        <div class="row">
            <div class="col-12 col-xl-12">
                <h2>Số lượng người truy cập trang web</h2>
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12 col-lg-3">
                                <input id="vs_start_dt" type="text" class="form-control date-picker"
                                       placeholder="Từ Ngày"
                                       data-flatpickr>
                            </div>
                            <div class="col-12 col-lg-3">
                                <input id="vs_end_dt" type="text" class="form-control date-picker"
                                       placeholder="Đến Ngày"
                                       data-flatpickr>
                            </div>
                        </div>

                        <div id="chartdiv" style="width: 100%; height: 300px">
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="row mt-5">
            <h2>Bài viết gần đây</h2>
            <div class="table-responsive">
                <table class="table table-sm table-hover table-nowrap card-table text-center">
                    <colgroup>
                        <col width="10%">
                        <col>
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>Tên Bảng Tin</th>
                        <th>Tiêu Đề</th>
                        <th>Người đăng ký</th>
                        <th>Ngày đăng ký</th>
                        <th>Quản lý</th>
                    </tr>
                    </thead>
                    <tbody class="list fs-base">
                    <c:if test="${empty posts}">
                        <tr>
                            <td colspan="7" class="text-center">Không có dữ liệu</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${posts}" var="item">
                        <tr>
                            <td class="text-primary">
                                    ${item.board_name}
                            </td>
                            <td class="text-start text-primary">${item.post_title_vn}</td>
                            <td>${item.regis_name}</td>
                            <td><fmt:formatDate value="${item.post_reg_dt}"
                                                pattern="dd-MM-yyyy"/></td>
                            <td>
                                <a
                                        class="btn btn-primary" href="/cms/post/update/${item.post_seq}">Chỉnh
                                    sửa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row mt-5">
            <h2>Bài viết hỏi & đáp</h2>
            <div class="table-responsive">
                <table class="table table-sm table-hover table-nowrap card-table text-center">
                    <colgroup>
                        <col>
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>Tiêu đề</th>
                        <th>Trạng thái</th>
                        <th>Người hỏi</th>
                        <th>Ngày hỏi</th>
                        <th>Quản lý</th>
                    </tr>
                    </thead>
                    <tbody class="list fs-base">
                    <c:if test="${empty qas}">
                        <tr>
                            <td colspan="7" class="text-center">Không có dữ liệu</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${qas}" var="item1">
                        <tr>
                            <td class="text-start text-primary">${item1.qa_title}</td>
                            <td>
                                <c:if test="${item1.qa_answer_dt != null}"> Đã trả lời</c:if>
                                <c:if test="${item1.qa_answer_dt == null}"><span
                                        class="text-danger">Chưa trả lời</span></c:if>
                            </td>
                            <td>${item1.qa_email}</td>
                            <td><fmt:formatDate value="${item1.qa_question_dt}"
                                                pattern="dd-MM-yyyy"/></td>
                            <td>
                                <p style="color: blue;"><a class="btn btn-primary"
                                                           href="/cms/qa/update/${item1.qa_seq}">Trả lời</a></p>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/admin/user-script.jsp" charEncoding="UTF-8"/>

<!-- Dashboard Chart -->
<script src='${pageContext.request.contextPath}/assets/cms/js/chart/index.js'></script>
<script src='${pageContext.request.contextPath}/assets/cms/js/chart/xy.js'></script>
<script src='${pageContext.request.contextPath}/assets/cms/js/chart/Animated.js'></script>
<script src='${pageContext.request.contextPath}/assets/cms/js/chart/vi_VN.js'></script>
<%--<script src='${pageContext.request.contextPath}/assets/cms/js/chart/chart.js'></script>--%>

<script>
    $(document).ready(function () {
        var today = new Date();
        $("#vs_end_dt").val(formatDate(today));
        var lastWeek = new Date(today.setDate(today.getDate() - 7));
        $("#vs_start_dt").val(formatDate(lastWeek));
        createChart();

        $('.date-picker').change(function () {
            if ($("#vs_end_dt").val() != "" && $("#vs_start_dt").val() != "") {
                createChart();
            }
        })
    })

    function createChart() {
        $.ajax({
            url: '/cms/visitor/chart',
            headers: {
                Accept : "application/json"
            },
            type: 'GET',
            data: {'start_dt': $('#vs_start_dt').val(), 'end_dt': $('#vs_end_dt').val()},
            success: function (data) {
                if (data != null) {
                    var chartData = [];
                    for (var i = 0; i < data.length; i++) {
                        chartData.push(generateData(data[i].vs_dt, data[i].vs_total));
                    }
                    series.data.setAll(chartData);
                    series.appear(1000);
                    chart.appear(1000, 100);
                }
            },
            error: function () {
                console.log("Visitor Chart API - Error");
            }
        });
    }

    function formatDate(d) {
        var day = d.getDate();
        var month = d.getMonth() + 1;
        var year = d.getFullYear();
        if (day < 10) {
            day = "0" + day;
        }
        if (month < 10) {
            month = "0" + month;
        }
        var date = year + "-" + month + "-" + day;
        return date;
    }

    var root = am5.Root.new("chartdiv");
    root.locale = am5locales_vi_VN;
    root.dateFormatter.setAll({
        dateFormat: "yyyy-MM-dd",
        dateFields: ["valueX"]
    });

    root.setThemes([
        am5themes_Animated.new(root)
    ]);

    var chart = root.container.children.push(
        am5xy.XYChart.new(root, {
            panX: true,
            panY: true,
            wheelX: "panX",
            wheelY: "zoomX"
        })
    );
    chart.get("colors").set("step", 3);

    var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {}));
    cursor.lineY.set("visible", false);

    var xAxis = chart.xAxes.push(
        am5xy.DateAxis.new(root, {
            maxDeviation: 0.3,
            baseInterval: {
                timeUnit: "day",
                count: 1
            },
            renderer: am5xy.AxisRendererX.new(root, {}),
            tooltip: am5.Tooltip.new(root, {})
        })
    );
    var yAxis = chart.yAxes.push(
        am5xy.ValueAxis.new(root, {
            maxDeviation: 0.3,
            renderer: am5xy.AxisRendererY.new(root, {})
        })
    );

    var series = chart.series.push(am5xy.LineSeries.new(root, {
        name: "Series 1",
        xAxis: xAxis,
        yAxis: yAxis,
        valueYField: "value",
        valueXField: "date",
        tooltip: am5.Tooltip.new(root, {
            labelText: "Lượt truy cập: {valueY}"
        })
    }));
    series.strokes.template.setAll({
        strokeWidth: 2,
        strokeDasharray: [3, 3]
    });

    //Red bullet on point
    series.bullets.push(function () {
        var container = am5.Container.new(root, {
            templateField: "bulletSettings"
        });
        var circle0 = container.children.push(am5.Circle.new(root, {
            radius: 5,
            fill: am5.color(0xff0000)
        }));
        var circle1 = container.children.push(am5.Circle.new(root, {
            radius: 5,
            fill: am5.color(0xff0000)
        }));

        return am5.Bullet.new(root, {
            sprite: container
        })
    })

    function generateData(date, visitor) {
        var convertDate = new Date(date);
        convertDate.setHours(0, 0, 0, 0);
        return {
            date: convertDate.getTime(),
            value: visitor
        };
    }
</script>


