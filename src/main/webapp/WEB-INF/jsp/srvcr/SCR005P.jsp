<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="popup-wrap" >

			<div class="popup-head">

				<div class="head-txt">표준 서비스기준 항목(SCR005P)</div>

				<a href="#none" class="popup-close-btn" onclick="popupCloseDirect(this)"></a>
			</div>

			<div class="popup-body">


				<article class="search-form popup-search-form">
					<div class="wrap box-style inner-width">

						<div class="form-group">

							<div class="row">

								<div class="item-box type-2">
									<div class="subject-box"><span class="txt">기준항목명</span></div>
									<div class="con-box">
										<div class="ibox">
											<input type="text" placeholder="기준항목명을 입력하세요." id="critmNm">
										</div>
									</div>
								</div>
							</div>
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

				
				<article class="msg-info-box">
					* 항목 순서 변경 후 저장 시 기준정보 순서 정보도 같이 변경됩니다.
				</article>


				<article class="set-form-box">

					<div class="txt-box">사용자 입력</div>

					<article class="set-table">

						<div class="table-box">

							<table>
								<colgroup>
									<col style="width: 150px;">
									<col style="width: auto;">
								</colgroup>
								<tr>
									<th><div class="subject-box ess">식별항목여부</div></th>
									<td class="left">
										<div class="sbox">
											<select id="popIdnfItmYn">
												<option value='Y'>Y</option>
												<option value='N'>N</option>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th><div class="subject-box ess">사용시작일자</div></th>
									<td class="left">
										<div class="ibox">
											<input type="text" id="popUseBgngYmd" value="" class="date-picker"  data-position='top left' data-mask="0000-00-00">
										</div>
									</td>
								</tr>
								<tr>
									<th><div class="subject-box ess">사용종료일자</div></th>
									<td class="left">
										<div class="ibox">
											<input type="text" id="popUseEndYmd"  value="9999-12-31" class="date-picker" data-position='top left' data-mask="0000-00-00" >
										</div>
									</td>
								</tr>
							</table>
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
	datePicker();
	//<c:out value="${srvcrId}"/>
	//<c:out value="${critmId}"/>
	var popGrid = new Grid({
		el: document.getElementById('popGrid'), // Container element
		rowHeaders:[{type:'rowNum'},{type:'checkbox',header:"<input type='checkbox' disabled/>"}],//전체선택 안되게  disabled
		bodyHeight:250,
		columns: [
			{ header: '기준항목ID', 	name: 'critmId' },
			{ header: '기준항목명', 	name: 'critmNm' },
			{ header: '물리명'	  , 	name: 'critmPhyNm'},
			{ header: '데이터타입',		name: 'datatpCd', hidden:true},
			{ header: '데이터타입',		name: 'datatpNm'}
		],
		header:{align:'center',valign:'middle'},
		data: [],// 데이터는 검색해서 
		columnOptions: {
			resizable: true
		}
	});
	
	
	$('#btnPopInit').on('click',function(){
		 $('#critmNm').val('');
	});
	
	$('#btnPopInit').on('click',function(){
		 $('#critmNm').val('');
	});
	/*popup script */
	$('#btnPopSearch').on('click',function(){
		//ajax로 땡겨온 데이터
		$.ajax({
			 url :"<c:url value='/critm/selectCritm.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'critmNm' : $('#critmNm').val()}  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	//실제로는 ajax로 데이터 땡겨옴.
	        	popGrid.resetData(data.list); 		
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

	//팝업 시작일자에 오늘 날짜 기본 셋팅
	$('#popUseBgngYmd').val(getToday());
	//팝업 적용버튼 클릭시
	$('#popBtnAply').on('click', function(){
		var row = popGrid.getCheckedRows();
		if(row.length<1){
			alert('기준항목을 선택하세요.');
			return false;
		}
		var useBgngYmd = $('#popUseBgngYmd').val();
		var useEndYmd = $('#popUseEndYmd').val();
		if(useBgngYmd>useEndYmd){
			alert('시작일자는 종료일자보다 작아야 합니다.');
			return false;
		}
		var retData = {
			critmId : row[0].critmId,
			critmNm : row[0].critmNm,
			critmPhyNm : row[0].critmPhyNm,
			datatpCd : row[0].datatpCd,
			datatpNm : row[0].datatpNm,
			idnfItmYn : $('#popIdnfItmYn').val(),
			useBgngYmd : $('#popUseBgngYmd').val(),
			useEndYmd : $('#popUseEndYmd').val()

		}
		console.log(retData);
		$('.container').removeClass('overlay');
		$('#pop').hide();
		$('#pop').data('callback')(retData);

	});

	function init(){
		//화면컴포넌트제어
		getAcctlCmpntId('${acctlPgmId}');
	}
	init();
	
});
	
</script>		