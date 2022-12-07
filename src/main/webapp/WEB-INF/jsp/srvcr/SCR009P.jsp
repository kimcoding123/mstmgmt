<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="popup-wrap" >

			<div class="popup-head">

				<div class="head-txt"><c:out value="${dmnLgcNm}"/> 조회(SCR009P)</div>

				<a href="#none" class="popup-close-btn" onclick="popupCloseDirect(this)"></a>
			</div>

			<div class="popup-body">


				<article class="search-form popup-search-form">
					<div class="wrap box-style inner-width">

						<div class="form-group" id="formGroup">

							
							
						</div>

						<div class="menu-group">
							<a href="#none" class="menu-btn type-2" id='btnPopInit'>초기화</a>
							<a href="#none" class="menu-btn" id='btnPopSearch'>검색</a>
						</div>
					</div>
				</article>


				<article class="order-list scroll-list" style="height:300px;">
					<article class="list-table bg-gray">
						<div class="" id='popGrid'>
							

						</div>
					</article>
					
				</article>
			</div>

			<div class="popup-foot">


				<div class="popup-menu">
					<a href="#none" class="btn type-2" onclick="popupCloseDirect(this)">취소</a>
					<a href="#none" class="btn type-1" id="popBtnAply">적용</a>
				</div>
			</div>
		</div>
<script>
$(document).ready(function(){
	var popGrid = new Grid({
		el: document.getElementById('popGrid'), // Container element
		rowHeaders:[{type:'rowNum'},{type:'checkbox',header:"<input type='checkbox' disabled/>"}],//전체선택 안되게  disabled
		bodyHeight:250,
		columns:[],
		header:{align:'center',valign:'middle'},
		data: [],// 데이터는 검색해서 
		columnOptions: {
			resizable: true
		}
	});
	
	var dmnLgcNm = '<c:out value="${dmnLgcNm}"/>';
	var critmDmnLstIqiemDtls;
	function init(){
		getCritmDmnLstIqiemDtls();
	}
	init();

	function getCritmDmnLstIqiemDtls(){
		//ajax로 땡겨온 데이터
		$.ajax({
			 url :"<c:url value='/srvcr/selectCritmDmnLstIqiemDtls.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'dmnLgcNm' : dmnLgcNm}  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	critmDmnLstIqiemDtls = data.list;  
	        	//조회항목 생성
	        	setSearchCond();
	        	//검색조건중 단순코드 설정
	        	setSearchCondCode();
	        	//그리드 컬럼 생성  	 	
	        	setGridColumn();	
	        
			}
		    ,error: function(){
		    	
		    }
		});
		//
	}

	function setSearchCond(){
		var searchCondList = critmDmnLstIqiemDtls.filter(function(element){return element.srchCndTrgtItmYn==='Y'});
		
		var html='';
		html+='<div class="row">';
		
		//한개만 체크되도록
		$.each(searchCondList, function(index, item){
			if(index>0 && index%2==0){
				html+='</div>';
				html+='<div class="row">';
			}
			html+='<div class="item-box type-2">';
			html+='	<div class="subject-box"><span class="txt">'+item.critmNm+'</span></div>';
			html+='	<div class="con-box">';
			
			if(item.dmnGroupNm=='여부' || item.dmnGroupNm=='유무'){
				html+='		<div class="sbox">';
				html+='			<select id="'+item.critmPhyNm+'" name="'+item.critmPhyNm+'">';
				html+='				<option value="">선택</option>';
				html+='				<option value="Y">Y</option>';
				html+='				<option value="N">N</option>';
				html+='			</select>';
			}else if(item.cdvlTnm=="단순코드"){
				html+='		<div class="sbox">';
				html+='			<select id="'+item.critmPhyNm+'" name="'+item.critmPhyNm+'">';
				html+='			</select>';
			}else{
				html+='		<div class="ibox">';
				html+='			<input type="text" placeholder="'+item.critmNm+'을(를) 입력하세요." id="'+item.critmPhyNm+'" name="'+item.critmPhyNm+'">';
			}
			html+='		</div>';
			html+='	</div>';
			html+='</div>';
			
		});
		html+='</div>';		
		$('#formGroup').html(html);
	}
	function setGridColumn(){
		var columns = [];
		$.each(critmDmnLstIqiemDtls, function(index, item){
			var column = 
			{
				header:item.critmNm, 
				name: under2camel(item.critmPhyNm) 
			}
			
			columns.push(column);
		});
		
		popGrid.setColumns(columns);
	}
	function setSearchCondCode(){
		var codeDmnList = critmDmnLstIqiemDtls.filter(function(element){return element.cdvlTnm==='단순코드'});
		$.each(critmDmnLstIqiemDtls, function(index, item){
			setSelectComponent(item.critmPhyNm,item.critmPhyNm,'SELECT');
		});
	}
	$('#btnPopInit').on('click',function(){
		$('#formGroup').find("input, select").val('');
	});
	/*popup script */
	$('#btnPopSearch').on('click',function(){
		var param = $('#formGroup').find("input, select").serializeArray() ;
		param.push({name:'dmnLgcNm',value:dmnLgcNm});
		param.push({name:'dmnPhyTblNm',value: '<c:out value="${dmnPhyTblNm}"/>'});
		
		//ajax로 땡겨온 데이터
		$.ajax({
			 url :"<c:url value='/srvcr/selectcritmDmnData.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data : param
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	//실제로는 ajax로 데이터 땡겨옴.
	        	popGrid.resetData(data.list); 		
			}
		    ,error: function(){
		    	
		    }
		});
		//
	});

	popGrid.on('check',function(ev){
		var rowkey = ev.rowKey;
		var rows = popGrid.getCheckedRows();
		//한개만 체크되도록
		$.each(rows, function(index, row){
			if(rowkey!=row.rowKey){
				popGrid.uncheck(row.rowKey);
			}
		});
	});
	popGrid.on('checkAll', function(allPage){
		popGrid.unckeckAll();
	});

	//팝업 적용버튼 클릭시
	$('#popBtnAply').on('click', function(){
		var row = popGrid.getCheckedRows();
		if(row.length<1){
			alert('항목을 선택하세요.');
			return false;
		}
		var retCol = critmDmnLstIqiemDtls.filter(function(element){return element.colOrd===1})[0].critmPhyNm;
		
		var value = row[0][under2camel(retCol)];
		
		$('.container').removeClass('overlay');
		$('#popupRegCritmVal').hide();
		$('#popupRegCritmVal').data('callback')(value);

	});
});
	
</script>		