<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<script>
		const contextRoot = '${pageContext.request.contextPath}';
	</script>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/reset.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/ui.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/datepicker.min.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/tui-grid.min.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/tui-date-picker.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/tui-pagination.min.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/datepicker.min.css'/>"/>
	

    <script src="<c:url value='/js/babel.min.js'/>"></script>
    <script src="<c:url value='/js/xlsx.full.min.js'/>"></script>	
	<script src="<c:url value='/js/jquery-3.1.1.min.js'/>"></script>
	<script src="<c:url value='/js/jquery-ui-1.12.1.js'/>"></script>
	<script src="<c:url value='/js/datepicker.min.js'/>"></script>
	<script src="<c:url value='/js/datepicker.ko.js'/>"></script>
	<script src="<c:url value='/js/jquery.mask.js'/>"></script>
	<script src="<c:url value='/js/tui-date-picker.min.js'/>"></script>
	<script src="<c:url value='/js/tui-pagination.min.js'/>"></script>
	<script src="<c:url value='/js/tui-grid.min.js'/>"></script>
	<script src="<c:url value='/js/cmm.js'/>"></script>

	<!-- Toast UI Editor -->
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>		

	<!-- 부트스트랩 5.0
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	-->
	
	<!-- 부트스트랩 3.3 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>		


	<tiles:insertAttribute name="header"/>
</head>
<body>	
	<div class="container">
	
		<div class="wrapper">
	
			<div class="contents-wrapper">
				<tiles:insertAttribute name="left"/>
				
	
				<section class="page">
					<tiles:insertAttribute name="nav"/>
					
					<div class="page-wrap" id="pageContent">
						<tiles:insertAttribute name="content"/>
					</div>
				</section>
			</div>
		</div>
	</div>
	<script src="<c:url value='/js/ui.js'/>"></script>	
</body>
</html>
