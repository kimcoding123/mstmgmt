<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 상단메뉴 시작 -->
<header>
	<div class="header-wrap">
		<nav>
			<ul id="ulTopMenu">
				
			</ul>
		</nav>

		<div class="header-info">
			<div class="timer-box">
				<span class="timer-txt"> <c:out value="${loginVo.userKnme }"/> 님&nbsp; </span>
			</div>
			<div class="timer-box" id="logout" >
				<a href="#none" class="timer-txt">[로그아웃]&nbsp;</a>
				
			</div>
			<div class="search-box">
				<a href="#none" class="search-btn"></a>
			</div>
			<div class="my-box">
				<a href="#none" class="my-btn"></a>
			</div>
			<div class="timer-box">
				<span class="timer-txt">59:25</span>
			</div>
			<div class="msg-box">
				<a href="#none" class="msg-btn" ></a>

			</div>

		</div>
	</div>
	<form id="logoutForm" name="logoutForm" method="post" action="<c:url value='/logout.do'/>">
	</form>
</header>
<script>
$(document).ready(function(){
	/*menu 그리기*/
	function drawMenu(){
		$.ajax({
			url :"<c:url value='/mnu/selectUserMenuTree.ajax'/>"
	        ,type: "POST"
	        ,data : {'usrId':'<c:out value="${loginVo.usrid }"/>', 'depth':1 }
	        ,dataType: 'json'
		    ,async:false
	        ,success : function(list){
	        	$('#ulTopMenu').empty();
				var menuList='';
				$(list.userMenuTree).each(function(index){
		        	var className= index==0?"on":"";
		        	var li = '<li name="liTopMenu" mnuId="'+this.mnuId+'" mnuNm="'+this.mnuNm+'" id="'+this.mnuId+'"> <a href="#none" class="'+className+'" > <span class="txt">'+this.mnuNm+'</span>	</a>	</li>';
        			$('#ulTopMenu').append(li);
	    		});
			}
		});
	}
	drawMenu();

	$('li[name=liTopMenu]').on('click', function(){
		var mnuId = $(this).attr('mnuId') ;
		var mnuNm = $(this).attr('mnuNm');
		$('#divLeftMenuLabel').text(mnuNm);// leftMenu 상단 메뉴명 셋팅
		
		$.ajax({
			url :"<c:url value='/mnu/selectUserMenuTree.ajax'/>"
	        ,type: "POST"
	        ,data : {'usrId':'<c:out value="${loginVo.usrid }"/>', 'upMnuId':mnuId}
	        ,dataType: 'json'
		    ,async:false
	        ,success : function(list){
	        	$('#ulLeftMenu').empty();
				var menuList='';
				var leftMenu = "";
				$(list.userMenuTree).each(function(index){
		        	var className= "";
		        	
					if(this.depth==1){
						if(this.nextDepth==1){
							className = "no-sub-menu";
						}else{
							className += index==0?"on":"";
						}
					}
					
					if(this.depth==1){
						leftMenu += '<li><a href="#none" class="'+className+'" pgmCallUrl='+this.pgmCallUrl+'>'+this.mnuNm+'</a>';
						if(this.nextDepth!=2){
							leftMenu +=	'</li>';
						}
					}else{
						if(this.preDepth==1){
							leftMenu += '<div class="sub-menu">';
						}
						leftMenu +=	'<a href="#none" menuId="'+this.mnuId+'" pgmCallUrl="'+this.pgmCallUrl+'" >'+this.mnuNm+'</a>';
						if(this.nextDepth!=2){
							leftMenu +=	'</div></li>';
						}
					}
	    		});//end of each
	    		console.log(leftMenu);
	    		$('#ulLeftMenu').append(leftMenu);//LEFT MENU 생성하고
	    		setLeftMenuEvent();//LEFT MENU 이벤트 설정하고
	    		//$('nav.lnb .lnb-list li > div > a:first').click();//top 메뉴 클릭시마다?
				
			}
		});
	});
	//첫번째 메뉴 자동 클릭 ->left 메뉴가 셋팅되도록 하기 위함.
	$('li[name=liTopMenu]:first').click();
	//$('nav.lnb .lnb-list li > div > a:first').click();//첫번째 메뉴 클릭을 해줘야 하는데.//top 메뉴 클릭시마다 할려면 위쪽으로 옮기면 됨.

	$('#logout').on('click',function(){
		$('#logoutForm').submit();
	});
	
});


</script>
<!-- 상단메뉴 종료 -->