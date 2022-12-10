<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

	<tiles:insertAttribute name="header"/>
</head>
<body>	
	<div class="container">
	
		<tiles:insertAttribute name="content"/>
	</div>
	<script src="<c:url value='/js/ui.js'/>"></script>	
</body>
</html>
