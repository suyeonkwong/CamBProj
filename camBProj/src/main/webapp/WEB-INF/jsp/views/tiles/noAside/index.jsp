<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><tiles:insertAttribute name="title" /></title>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    
	<!-- ********* link import ********************************************************************************* -->
    
    <!-- 파비콘 -->
  	<link rel="shortcut icon" href="/resources/img/favicon/logo.ico" type="image/x-icon">
  	<link rel="icon" href="/resources/img/favicon/logo.ico" type="image/x-icon">
    
    <!-- Custom fonts for this template-->
    <link href="/resources/sbadmin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	
	<!-- 구글 웹 폰트 -->    
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link rel="stylesheet" type="text/css" href="/resources/sbadmin/css/sb-admin-2.min.css" >
	<link rel="stylesheet" type="text/css" href="/resources/css/sb-admin-2.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/sb-admin-2.css">
	
	<!-- Daterange picker -->
    <link rel="stylesheet" href="/resources/adminlte/plugins/daterangepicker/daterangepicker.css">
	
	
	<!-- ********* 부트스트랩 셀렉트 ********************************************************************************* -->
<%-- 	<link href="${pageContext.request.contextPath}/resources/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet" type="text/css"  /> --%>
<%-- 	<script src="${pageContext.request.contextPath}/resources/bootstrap-select/dist/js/bootstrap-select.min.js" ></script> --%>

	<!-- ********* alert toastr ********************************************************************************* -->
	<link href="${pageContext.request.contextPath}/resources/adminlte/plugins/toastr/toastr.min.css" rel="stylesheet" type="text/css"  />
	<script src="${pageContext.request.contextPath}/resources/adminlte/plugins/toastr/toastr.min.js" ></script>

	
	<!-- pdf 다운로드 -->
	<script type="text/javascript" src="/resources/jspdf.min.js"></script>
	<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
	
	<!-- ********* 공용 ********************************************************************************* -->
	<link href="${pageContext.request.contextPath}/resources/css/ddit.min.css" rel="stylesheet">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ddit.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ddit.registrationLecture.js"></script>
	
	<!-- 풀캘린더 -->
	<link href='/resources/fullcalendar-5.9.0/lib/main.css' rel='stylesheet' />
	<script src='/resources/fullcalendar-5.9.0/lib/main.js'></script>
	
<style>
	.container-fluid {
		display: flex;
    	align-items: center;
    }
    #body {
    	justify-content: center; 
    	align-items: center;
    	margin: auto;
	}
	.errorImg {
		height: 300px;
	}
</style>  
	
	
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
        
            <!-- Main Content -->
            <div id="content">
                <tiles:insertAttribute name="header"/>
                <!-- Begin Page Content -->
                <div class="container-fluid" style="height: 80vh;">
                	<tiles:insertAttribute name="body" />   
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
	        <div>
				<tiles:insertAttribute name="footer" />
	        </div>
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
<!--     <a class="scroll-to-top rounded" href="/resources/sbadmin/#page-top"> -->
<!--         <i class="fas fa-angle-up"></i> -->
<!--     </a> -->

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="/resources/sbadmin/login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

	<!-- ********* script import ********************************************************************************* -->
   	<!-- 다음 주소 api(CDN) -->
    <script async="async" type="text/javascript" src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js?autoload=false"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
   
    <!-- Bootstrap core JavaScript-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/sbadmin/vendor/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/sbadmin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/sbadmin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/sbadmin/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/sbadmin/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
<%--     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/sbadmin/js/demo/chart-area-demo.js"></script> --%>
<%--     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/sbadmin/js/demo/chart-pie-demo.js"></script> --%>
    
    <!-- daterangepicker -->
	<script type="text/javascript" src="/resources/adminlte/plugins/moment/moment.min.js"></script>
	<script type="text/javascript" src="/resources/adminlte/plugins/daterangepicker/daterangepicker.js"></script>

	<!-- google -->
	<script type="text/javascript" async="" src="https://www.google-analytics.com/analytics.js"></script>
	<script type="text/javascript" async="" src="https://www.gstatic.com/recaptcha/releases/wxAi4AKLXL2kBAvXqI4XLSWS/recaptcha__ko.js" crossorigin="anonymous" integrity="sha384-DRMHAvorJm6z+gxf+sMvOrvTeT4pdxSlicsd8Wv3S/0fYznJonIw/rI2NQWnz5/K"></script>
	<script type="text/javascript" async="" src="https://www.googletagmanager.com/gtag/js?id=UA-38417733-17&amp;l=dataLayer&amp;cx=c"></script>
	<script type="text/javascript" async="" src="https://www.google-analytics.com/analytics.js"></script>
	
	<!-- jquery-validation-1.19.3 -->
	<script type="text/javascript" src="/resources/jquery-validation-1.19.3/dist/jquery.validate.min.js"></script>
	
</body>
</html>
