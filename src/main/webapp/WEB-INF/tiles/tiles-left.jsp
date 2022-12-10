<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--left menu start-->
<nav class="lnb">
	<a href="#none" class="toggle-btn"></a>


	<div class="logo-box">
		업무 기준/규칙 관리 시스템
	</div>

	<div class="lnb-tit-box" id="divLeftMenuLabel">기준관리</div>

	<ul class="lnb-list" id="ulLeftMenu">
		<li>
			<a href="#none" class="off">기준항목관리</a>
			<div class="sub-menu">
				<a href="#none" menuId="SCR101M">기준항목등록</a>
				<a href="#none" menuId="SCR102M">기준항목도메인등록</a>
			</div>
		</li>

		<li>
			<a href="#none" class="on">기준관리</a>

			<div class="sub-menu" >
				<a href="#none" menuId="SCR001M">기준등록</a>
				<a href="#none" menuId="SCR002M">기준내역등록</a>
				<a href="#none" menuId="SCR010D">기준내역등록(테스트)</a>
				<a href="#none" menuId="SCR011D">HTML태그편집기(테스트)</a>
				<a href="#none" menuId="SCR012D">화면디자인</a>
				<a href="#none" menuId="SCR013D">기준항목참조</a>
				<a href="#none" menuId="SCR014D">통합테이블</a>
				<a href="#none" menuId="SCR015D">연습</a>
			</div>
		</li>

		<li>
			<a href="#none" class="off">규칙관리</a>

			<div class="sub-menu">
				<a href="#none">규칙등록</a>
			</div>
		</li>
	</ul>

</nav>
<!--left menu end-->
<script>
function setLeftMenuEvent(){
	$('nav.lnb .lnb-list li > div > a').on('click',function (){
		var menuId = $(this).attr('menuId');
	    var url = $(this).attr('pgmCallUrl');
		if(menuId==undefined){
			alert('menuId 를 셋팅하세요');
			return;
		}
		//현재는 메뉴관리를 DB에서 하지 않기때문에 공통적인 패턴을 적용함
		$.ajax({
			url : contextRoot+'/'+url
	        ,type: "POST"
	        ,data : {'menuId':menuId}//parameter
	        ,dataType: 'html'  	   
	        ,success : function(data){
	            $('#pageContent').empty();
	            $('#pageContent').html(data);
			}
		});
	});

	$('nav.lnb .lnb-list li > a ').on('click',function (){
		$('nav.lnb .lnb-list li > a ').each(function(){
			if(this.className!="no-sub-menu"){
				this.className="";
			}
			
		});
		if(this.className!="no-sub-menu"){
			this.className= "on";
		}
		
	});
}
</script>