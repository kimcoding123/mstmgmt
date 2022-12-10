<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="popup-wrap">

	<div class="popup-head">

		<div class="head-txt">서비스기준 이력(SCR004P)</div>

		<a href="#none" class="popup-close-btn" onclick="popupCloseDirect(this)"></a>
	</div>

	<div class="popup-body">

		<article class="order-list scroll-list">
			<article class="list-table bg-gray">
				<div class="" id='popGridSrvcrHist'>
				</div>
			</article>
		</article>
	</div>

	<div class="popup-foot">
		<div class="popup-menu">
			<a href="#none" class="btn type-2" onclick="popupCloseDirect(this)">닫기</a>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	/*팝업용 script 시작*/
	var popGridSrvcrHist = new Grid({
		el: document.getElementById('popGridSrvcrHist'), // Container element
		rowHeaders:['rowNum'],
		bodyHeight:250,
		columns: [
			{ header: '서비스기준id', 	name: 'srvcrId' , hidden:true},
			{ header: '서비스기준명', 	name: 'srvcrNm' },
			{ header: '유효시작일시', 	name: 'vldBgngDt'},
			{ header: '유효종료일시', 	name: 'vldEndDt' },
			{ header: '서비스기준설명',		name: 'srvcrDc'},
			{ header: '서비스기준뷰명',		name: 'srvcrViewNm'},
			{ header: '업무구분',		name: 'taskDivSclsCd', hidden:true},
			{ header: '업무구분',		name: 'taskDivSclsNm'},
			{ header: '사용시작일자',		name: 'useBgngYmd'},
			{ header: '사용종료일자',		name: 'useEndYmd'}
		],
		header:{align:'center',valign:'middle'},
		data: [],// 데이터는 검색해서 
		columnOptions: {
			resizable: true
		}
	});
	//서비스기준이력 조회
	function selectSrvcrHist(){
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrHist.ajax'/>"
		    ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
		    ,data :{'srvcrId':'<c:out value="${srvcrId}"/>'}  
		    ,dataType: 'json'  	   
		    ,success : function(data){
		    	popGridSrvcrHist.refreshLayout();
		    	//실제로는 ajax로 데이터 땡겨옴.
				popGridSrvcrHist.resetData(data.list);		
			}

		});
	}
	function init(){
		selectSrvcrHist();
		//화면컴포넌트제어
		getAcctlCmpntId('${acctlPgmId}');
	}
	init();
	
});
	
</script>		