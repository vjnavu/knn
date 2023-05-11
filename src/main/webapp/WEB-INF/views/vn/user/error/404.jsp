<%--
  Created by IntelliJ IDEA.
  User: PDSOFT
  Date: 4/27/2022
  Time: 11:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content="A fully featured admin theme which can be used to build CRM, CMS, etc."/>
    <link rel="shortcut icon" href="/assets/user/favicon/favi.png"
          type="image/x-icon"/>
    <title>Kỹ năng nghề</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #fff;
            height: 100vh;
        }

        #container {
            position: absolute;
            top: 10%;
            left: 10%;
            right: 10%;
            bottom: 10%;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f1f1fa;
            box-shadow: 0 15px 30px rgba(0, 0, 0, .5);
        }

        #container .content {
            max-width: 600px;
            text-align: center;
        }

        #container .content * {
            user-select: none;
        }

        #container .content img {
            /*background: #fff;*/
            padding: 10px 20px;
            border-radius: 5px;
        }

        #container .content h2 {
            font-size: 14vw;
            color: #fff;
            line-height: 1em;
            text-shadow: 0 7px 16px rgb(0 0 0 / 50%);
            position: relative;
        }
        #container .content h2 span {
            position: relative;
        }

        #container .content h2 span:after {
            content: 'ERROR';
            position: absolute;
            top: 34%;
            left: -30%;
            transform: rotate(-55deg);
            font-size: 10%;
            line-height: 1;
            letter-spacing: 6px;
        }

        #container .content h4 {
            position: relative;
            font-size: 1.5em;
            margin-bottom: 20px;
            color: #111;
            /*background: #fff;*/
            font-weight: 300;
            padding: 10px 20px;
            display: inline-block;
            border-radius: 5px;
        }

        #container .content p {
            color: #000;
            font-size: 1.2em;
        }

        #container .content a {
            position: relative;
            display: inline-block;
            padding: 10px 25px;
            background: #437dea;
            color: #fff;
            text-decoration: none;
            margin-top: 25px;
            border-radius: 25px;
            border-bottom: 4px solid #0059ff;
            font-weight: 700;
        }

        .logo {
            display: block;
            object-fit: contain;
            width: 100%;
            height: 105px;
        }

        @media (max-width: 767px) {

            #container {
                top: 20px;
                left: 20px;
                right: 20px;
                bottom: 20px;
            }

            #container .content h2 span:after {
                left: -56%;
            }

        }

        @media (max-width: 540px) {

            #container .content h2 span {
                position: static;
            }

            #container .content h2 {
                padding-top: 1em;
            }

            #container .content h2 span:after {
                top: 6%;
                left: 50%;
                transform: rotate(0deg) translate(-50%, 0);
                font-size: .8em;
                line-height: 1;
                letter-spacing: 6px;
            }

        }
    </style>
</head>

<body>
<div id="container">
    <div class="content">
        <img src="${pageContext.request.contextPath}/assets/cms/img/logo.png" class="logo">
        <h2><span>4</span>04</h2>
        <h4>Opps! Không tìm thấy trang</h4>
        <p>Trang bạn đang tìm kiếm không tồn tại. Bạn có thể đã nhập sai địa chỉ hoặc trang có thể đã bị di chuyển.</p>
        <a href="/">Quay trở về trang chủ</a>
    </div>
</div>
</body>
</html>