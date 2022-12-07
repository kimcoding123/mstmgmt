<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<article class="page-head">
	<div class="head-box inner-width">
		<div class="tit-box">
			<a href="#none" class="like-btn"></a>
			<div class="tit-txt">기준항목참조</div>
			<div class="sub-txt">(SCR013D)</div>
		</div>
	
	</div>
</article>

<article class="table-list">
	<article class="page-head">
		<div class="head-box">
			<div class="tit-box">
				<div class="tit-txt">기준항목참조</div>
			</div>
			<div class="menu-box">
				<a href="#none" class="menu-btn" id="btnSearch">검색</a>
				<a href="#none" class="menu-btn" id="btnAddRow">행추가</a>
				<a href="#none" class="menu-btn" id="btnDelRow">행삭제</a>
				<a href="#none" class="menu-btn" id="btnFileUpload">업로드</a>
				<a href="#none" class="menu-btn" id="btnFileDownload">다운로드</a>
				<a href="#none" class="menu-btn" id="btnFormDownload">양식다운로드</a>
			</div>
		</div>
	</article>

	<div class="inner-width">
		<article class="list-table">
			<div  id="gridSrvcrItmValDtls">
			</div>
			<div class="page-foot">
				<div class="page-menu">
					<a href="#none" class="btn type-1" id='btnSrvcrDtlsSave'>저장</a>
				</div>
			</div>
		</article>
	</div>
</article>

<article class="table-list">
	<article class="page-head">
		<div class="head-box">
			<div class="tit-box">
				<div class="tit-txt">기준항목참조상세</div>
			</div>
			<div class="menu-box">
				<a href="#none" class="menu-btn" id="btnSearch2">검색</a>
				<a href="#none" class="menu-btn" id="btnAddRow2">행추가</a>
				<a href="#none" class="menu-btn" id="btnDelRow2">행삭제</a>
				<a href="#none" class="menu-btn" id="btnFileUpload2">업로드</a>
				<a href="#none" class="menu-btn" id="btnFileDownload2">다운로드</a>
				<a href="#none" class="menu-btn" id="btnFormDownload2">양식다운로드</a>
			</div>
		</div>
	</article>

	<div class="inner-width">
		<article class="list-table">
			<div  id="gridSrvcrItmValDtls2">
			</div>
			<div class="page-foot">
				<div class="page-menu">
					<a href="#none" class="btn type-1" id='btnSrvcrDtlsSave2'>저장</a>
				</div>
			</div>
		</article>
	</div>
</article>


<article class="popup popup-table type-long"    style="display: none" id="popupRegCritmVal">
</article>
<article class="popup popup-table type-long"    style="display: none" id="popupExcelUpload">
</article>

<script>

$(document).ready(function(){
	datePicker();//달력 셋팅
	class CustomTextEditor {
		constructor(props) {
			const el = document.createElement('input');
			const { maxLength } = props.columnInfo.editor.options;

			el.type = 'text';
			el.maxLength = maxLength;
			el.value = String(props.value)=='null'?'':String(props.value);
			this.el = el;
			el.disabled = true;
		}
		getElement() {
			return this.el;
		}
		getValue() {
			return this.el.value;
		}
		mounted() {
			this.el.select();
		}
	}
	
	// tui.Grid는 어디있는것?
	const Grid = tui.Grid;
	
	Grid.applyTheme('striped', {
		cell: {
			header: {background: '#eef1f5'},
			evenRow: {background: '#edeff5'	}
		}
	});

	
//------------------------------------------
	const gridSrvcrItmValDtls = gridInit('gridSrvcrItmValDtls');

	const gridSrvcrItmValDtls2 = gridInit('gridSrvcrItmValDtls2');
	

    var srvcrItmList ;
    var srvcrItmList2 ;

	//var srvcrItmList; // 아래 클릭 이벤트에서 사용하고 있음... 전역변수를 지역변수로 가능한지 검토 필요
	//var srvcrItmList2; // 아래 클릭 이벤트에서 사용하고 있음... 전역변수를 지역변수로 가능한지 검토 필요

	function gridInit(inGridTag) {
		
		var inGrid = new Grid({
			el: document.getElementById(inGridTag), // Container element
			bodyHeight:300,
			rowHeaders:['rowNum','checkbox'],
			pageOptions:{useClient:true,perPage:10},
			columns: [
				
			],
			header:{align:'center',valign:'middle'},
			data: []
		});
		
	
		return inGrid;
	}
//------------------------------------------
	
	searchSrvcrDtls(gridSrvcrItmValDtls,{'srvcrId':'SVC0010'});
	searchSrvcrDtls(gridSrvcrItmValDtls2,{'srvcrId':'SVC0011'});
	
	
	// 검색 버튼 처리
	function searchSrvcrDtls(inGrid, inParam){
		
        // 1) 그리드 clear
		inGrid.clear();

		// 2) grid Column(Header) 세팅
		if (inParam.srvcrId == 'SVC0010') {
			srvcrItmList = selectSrvcrItmDtls('SVC0010');
			inGrid.setColumns( getGridSrvcrItmValDtlsColumns(srvcrItmList) );
		} else if (inParam.srvcrId == 'SVC0011') {
			srvcrItmList2 = selectSrvcrItmDtls('SVC0011');
			inGrid.setColumns( getGridSrvcrItmValDtlsColumns(srvcrItmList2) );			
		}

		// 3) 그리드 값 셋팅
		var list = selectSrvcrDtls(inParam);
		inGrid.resetData(list);
		if (list.length < 10) { 
			inGrid.setBodyHeight(list.length * 30);
		}		
		//selectSrvcrValDtls('SVC0010'); // for 테스트
	}

	
//-----------------------------------------------------	
	selectTb('TB0004');
//	selectTb('t2');
//	selectTb('t3');
	
	var param = {'tblNm':'TB0004', 'cust_id':'C0010', 'cust_seq':'1'};
	var map1   = {'tblNm':'TB0004', 'idc01':'cust_id', 'idc02':'cust_seq'};
	var map2   = {'tblNm':'TB0004', 'cust_id':'idc01', 'cust_seq':'idc02'};
	
	//JSONObject joParam = new JSONObject(param);
	//JSONObject joMap   = new JSONObject(map2);
	//console.log(joParam);
	//console.log(joMap);

    var keys = Object.keys(param); //키를 가져옵니다. 이때, keys 는 반복가능한 객체가 됩니다.
    var key;
    var afParam = {};
    for (var i=0; i<keys.length; i++) {
    	key = keys[i];
    	console.log("key : " + key + ", value : " + param[key]);
    	console.log("mapkey : " + key + ", mapvalue : " + map2[key]);
    	afParam[map2[key]] = param[key]; // 매핑값을 key, value는 그대로 value 로
    }	
    console.log('변환후param:'+afParam.idc01)
	
	//console.log(JSONObject.getString('idc01'));
	
	
    //inParam 용어명 -> 공통컬럼명 변환
    //function convColNm(inParam) {
    //	list에서 찾아서 replace?
    //}
	
	// 연습용 : 통합업무테이블 조회
	function selectTb(inTblNm) {
		
		console.log('selectTb');
		var sil;
		//서비스기준항목값내역 조회
		$.ajax({
			 url :"<c:url value='/cmm/selectTb.ajax'/>"
	        ,type: "POST"
	        ,async:false  // 함수로 싸서 피호출되게 한 경우, 비동기로해야 에러 안남
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'tblNm': inTblNm,'idc01':'ST00564'}  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	sil = data.list;
			}
		    ,error: function(){
		    	alert('오류가 발생하였습니다.');
		    }
		});
		
    	console.log(sil);
		return sil;
		
	}	
//-----------------------------------------------------	
	
	
	// 기준내역 데이터 추출 (서비스호출)
	function selectSrvcrDtls(inParam) {
		
		inParam.critYmd = '99991231235959'; // key-value 추가
		
		var outList;
		//서비스기준항목값내역 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrDtls.ajax'/>"
	        ,type: "POST"
	        ,async:false  // 함수로 싸서 피호출되게 한 경우, 비동기로해야 에러 안남
		    //,contentType:'application/json; charset=UTF-8'
	        ,data : inParam//{'srvcrId': inSrvcrId,'critYmd':'99991231235959'}  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	outList = data.list;
			}
		    ,error: function(){
		    	alert('오류가 발생하였습니다.');
		    }
		});
		
    	//console.log(sil);
		return outList;
		
	}

	// 기준내역 데이터 추출 (향후 사용 예정)
	function selectSrvcrValDtls(inSrvcrId) {
		
		var outList;
		//서비스기준항목값내역 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrValDtls.ajax'/>"
	        ,type: "POST"
	        ,async:false  // 함수로 싸서 피호출되게 한 경우, 비동기로해야 에러 안남
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'srvcrId': inSrvcrId,'critYmd':'99991231235959'}  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	outList = data.list;
			}
		    ,error: function(){
		    	alert('오류가 발생하였습니다.');
		    }
		});
		
    	console.log(outList);
		return outList;
		
	}

	//서비스기준내역 columns 설정
	function getGridSrvcrItmValDtlsColumns(inSrvcrItmList){

		var columns = []; // 채워서 리턴할 변수
		
		// 유효종료일시/유효시작일시/식별은 critmId를 변경, 그외는 소문자로만 변경
   		$(inSrvcrItmList).each(function(){
   			var colName = '';
   			console.log("critmId: "+this.critmId);
   			if(this.critmId=="ST00002"){//유효종료일자이면 
   				//불필요? colName = 'vldEndDt';
    			this.critmId = 'vldEndDt';
   			}else if(this.critmId=="ST00003"){//유효시작일자이면
   				//불필요? colName = 'vldBgngDt';
	    		this.critmId = 'vldBgngDt';
    		}else if(this.idnfItmYn=="Y"){//유효시작/종료이외의 식별자항목이면
    			//불필요? colName = 'idnfItmVal' + this.srvCritmOrd;
   				this.critmId = 'idnfItmVal' + this.srvCritmOrd;
    		}else{//일반항목은 그대로~
    			//불필요? colName = this.critmId.toLowerCase();//소문자로-->sql에서 소문자로 던져줘서..
    			this.critmId = this.critmId.toLowerCase();//소문자로-->sql에서 소문자로 던져줘서..
    			//this.critmId = this.critmId;//소문자로 안바꾸면 일반항목값이 안나옴
	    	}
   			var column = 
   			{
   				header:this.critmNm, 
   				phyname:this.critmPhyNm,  // 김정삼 추가 
   				name: this.critmId, // 왜 critmId를 name이라 했지?
   				//name: this.critmPhyNm, // 왜 critmId 대신 critmPhyNm으로 바꿈
   				editor: {                       // grid column의 속성
   					type: CustomTextEditor,  
   					options: {maxLength: 4000, value:''}}, 
   				filter:'text', 
   				
   			}
   			//식별자는 필수입력
   			if(this.idnfItmYn=="Y"){
   				column.validation ={
   					required:true
   				}
   			}
   			console.log(column);
   			
   			// 앞서 셋팅한 column을 배열에 푸쉬
   			columns.push(column);
   		});
   		
		return columns;
	
	}
	
	// 기준항목내역 조회
	function selectSrvcrItmDtls(inSrvcrId) {
		
		var outList;	
		
		//ajax로 서비스기준항목내역 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrItmDtlsNew.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'srvcrId':inSrvcrId}  
	        ,dataType: 'json'
		    ,async:false  	   
	        ,success : function(data){
	        	outList = data.list;
			}
		    ,error: function(){
		    	alert('오류가 발생하였습니다.');
		    }
		});

    	console.log(outList);
		return outList;
		
	}		
	
	//검색버튼 클릭 --------------------------------------------------
	$('#btnSearch').on('click', function(){
		searchSrvcrDtls(gridSrvcrItmValDtls,{'srvcrId':'SVC0010'});
	});

	$('#btnSearch2').on('click', function(){
		searchSrvcrDtls(gridSrvcrItmValDtls2,{'srvcrId':'SVC0011'});
	});

	//행추가 -----------------------------------------------------
	$('#btnAddRow').on('click', function(){
			btnAddRowEH (gridSrvcrItmValDtls,'SVC0010' ) 
	});		

	$('#btnAddRow2').on('click', function(){
			btnAddRowEH (gridSrvcrItmValDtls2,'SVC0011' ) 
	});		

	function btnAddRowEH (inGrid, inSrvcrId) {

		if(inGrid.getColumns().length<1){
			alert('검색후 가능합니다.');
			return false;
		}
		console.log('행추가버튼클릭');
		inGrid.prependRow({srvcrId:inSrvcrId, idnfItmValDtlsSn:null, vldEndDt:'자동등록', vldBgngDt:'자동등록'});
		
	}	
	
	//행삭제 ------------------------------------------------------
	$('#btnDelRow').on('click', function(){
		btnDelRowEH (gridSrvcrItmValDtls ) 
	});
	
	//행삭제
	$('#btnDelRow2').on('click', function(){
		btnDelRowEH (gridSrvcrItmValDtls2 ) 
	});
	
	function btnDelRowEH (inGrid) {

		var rowKeys = inGrid.getCheckedRowKeys();
		if(rowKeys.length<1){
			alert('삭제할 행을 선택하세요.');
			return false;
		}
		$(rowKeys).each(function(i,val){
			inGrid.removeRow(val);
		});
		
	}	

	
	//파일업로드 --------------------------------------------------
	$('#btnFileUpload').on('click', function(){
		btnFileUploadEH (gridSrvcrItmValDtls,'SVC0010' ) ;
	});
	
	$('#btnFileUpload2').on('click', function(){
		btnFileUploadEH (gridSrvcrItmValDtls2,'SVC0011' ) ;
	});

	function btnFileUploadEH (inGrid, inSrvcrId) {
	
		var srvcrNm = inSrvcrId;
		if(confirm('['+srvcrNm+']의 데이터를 등록하시겠습니까?')){
			//팝업 셋팅
			$.ajax({
				url :"<c:url value='/cmm/openSCR008P.do'/>"
		        ,type: "POST"
		        ,data : {'srvcrId':inSrvcrId}//parameter
		        ,dataType: 'html'
			    //,async:false  	   
		        ,success : function(html){
		        	$('#popupExcelUpload').html(html);
	
		        	$('.container').addClass('overlay');
		    		$('#popupExcelUpload').data('callback',function(val){
		    			searchSrvcrDtls(inGrid, {'srvcrId': inSrvcrId} );
		    		}).show();
				}
			    ,error: function(){
			    	alert('오류가 발생하였습니다.');
			    }
			});
		}	
	}
	
	//파일다운로드 --------------------------------------------------------
	$('#btnFileDownload').on('click', function(){
		btnFileDownloadEH (gridSrvcrItmValDtls,'SVC0010' ) ;
		
	});
	$('#btnFileDownload2').on('click', function(){
		btnFileDownloadEH (gridSrvcrItmValDtls2,'SVC0011' ) ;
		
	});
	
	function btnFileDownloadEH (inGrid, inSrvcrId) {
		if(inGrid.getColumns().length<1){
			alert('검색후 가능합니다.');
			return false;
		}
		var columns = inGrid.getColumns();
		var colNames = [];
		$(columns).each(function(){
			colNames.push(this.name);
		});
		//var srvcrNm = $('#selectSrvcr :selected').text();
		var srvcrNm = inSrvcrId;  // 임시로직
		inGrid.export('xlsx', { includeHeader: true,columnNames:colNames, fileName:srvcrNm+'_데이터'});

	}	
	
	
	//파일양식다운로드----------------------------------------------------
	$('#btnFormDownload').on('click', function(){
		btnFormDownloadEH (gridSrvcrItmValDtls,'SVC0010' ) ;

	});
	$('#btnFormDownload2').on('click', function(){
		btnFormDownloadEH (gridSrvcrItmValDtls2,'SVC0011' ) ;

	});
	
	function btnFormDownloadEH (inGrid, inSrvcrId) {
		if(inGrid.getColumns().length<1){
			alert('검색후 가능합니다.');
			return false;
		}
		var columns = inGrid.getColumns();
		var colNames = [];
		$(columns).each(function(){
			colNames.push(this.name);
			//console.log(his.name);
		});
		var srvcrNm = inSrvcrId; // 임시로직
		inGrid.filter('idnfItmVal1', [{code: 'eq', value: ''}]);
		inGrid.export('xlsx', { includeHeader: true,columnNames:colNames, fileName:srvcrNm+'_양식'});
		inGrid.unfilter('idnfItmVal1');
	}	
	
	

	
	//1번 그리드 클릭 시...
	gridSrvcrItmValDtls.on('click', function(ev){
		if(ev.targetType!='cell'){
			return false;
		}
		var rowKey = ev.rowKey;
		console.log('출력'+gridSrvcrItmValDtls.getValue(rowKey, 'idnfItmVal1') ); 
		console.log('출력'+gridSrvcrItmValDtls.getValue(rowKey, 'vldBgngDt') ); 
		
		var inParam = {'idnfItmVal1': gridSrvcrItmValDtls.getValue(rowKey, 'idnfItmVal1') };
		inParam.srvcrId = 'SVC0011'; // key-value 추가
		searchSrvcrDtls(gridSrvcrItmValDtls2,inParam);

		
	});
	
	//그리드 더블클릭
	gridSrvcrItmValDtls.on('dblclick', function(ev){
		gridEH(gridSrvcrItmValDtls, srvcrItmList, ev);
	});
	gridSrvcrItmValDtls2.on('dblclick', function(ev){
		gridEH(gridSrvcrItmValDtls2, srvcrItmList2, ev);
	});

	function gridEH (inGrid, inSrvcrItmList, ev) {

		if(ev.targetType!='cell'){
			return false;
		}
		var rowKey = ev.rowKey;

		console.log('이벤트:'+ev);
		console.log('선택컬럼:'+ev.columnName);
		// getGridSrvcrItmValDtlsColumns 함수에서 name은 critmId
		var columnName = ev.columnName;
		
		
		//유효종료일시, 유효시작일시이면 팝업창 안뜸
		if(columnName=='vldBgngDt' || columnName=='vldEndDt'){
		//if(columnName=='유효시작일시' || columnName=='유효종료일시'){
			return false;
		}
		// 선택한 로우에 해당하는 서비스기준항목 내역 추출(도메인논리명 포함)한 것을 column에 저장
		var column = inSrvcrItmList.filter(function(element){return element.critmId==columnName})[0];
		//var column = srvcrItmList.filter(function(element){return element.critmNm===columnName})[0];
		console.log('컬럼배열:'+column);
		var dmnGroupNm = column.dmnGroupNm;
		var cdvlTnm = column.cdvlTnm;
		var dmnPhyNm = column.dmnPhyNm;
		var critmNm = column.critmNm;
		var idnfItmYn = column.idnfItmYn;
		var dmnLgcNm = column.dmnLgcNm;
		var dmnPhyTblNm = column.dmnPhyTblNm;
		var critmRefId  = column.critmRefId;
		var row = inGrid.getRow(rowKey);
		var vldEndDt = row.vldEndDt;
		
		// 최종 아니면 오류
		if(vldEndDt!='99991231235959' && vldEndDt!='자동등록' ){
			console.log('유효하지 않은 데이터');
			return false;
		}

		// 팝업창 선택 
		var url = "<c:url value='/cmm/openSCR007P.do'/>";
		//도메인물리테이블이 있으면 page 바꿈.
		if (critmRefId!=null) {
            console.log('기준항목참조ID가 널이 아님')
			url = "<c:url value='/cmm/openSCR009R.do'/>";
		} else if (dmnPhyTblNm!=null){
			url = "<c:url value='/cmm/openSCR009P.do'/>";
		}
		
		//팝업 셋팅
		// 전달한 data값은 어떻게 사용?
		// 전달받은 html을 popupRegCritmVal에 뿌린다? 	(display none는 어디서 변경?- show로 )	
		$.ajax({
			url : url
	        ,type: "POST"
	        ,data : {'critmNm':critmNm, 'cdvlTnm':cdvlTnm, 'dmnLgcNm':dmnLgcNm, 'dmnPhyNm':dmnPhyNm, 'dmnPhyTblNm':dmnPhyTblNm}//parameter
	        ,dataType: 'html'
		    ,async:false  	   
	        ,success : function(html){
	        	$('#popupRegCritmVal').html(html);
	        	console.log('cdvlTnm:'+cdvlTnm);
	        	console.log('dmnLgcNm:'+dmnLgcNm);
	        	console.log('dmnPhyNm:'+dmnPhyNm);
			}
		    ,error: function(){
		    	
		    }
		});
		
		$('.container').addClass('overlay'); // addClass하면 overlay가 보여짐?
		
		$('#labelCritmNm').text(critmNm); // labelCritmNm는 팝업에 있는것
		
		// 값 셋팅 후 팝업창 닫았는데, 그리드에 반영안되고 있음(로직 수정 전에는 정상 작동)
		$('#popupRegCritmVal').data('callback',function(val){
			inGrid.setValue(rowKey,columnName, val);
			console.log('팝업으로 가져온컬럼'+columnName);
			console.log('팝업으로 가져온값'+val);
		}).show();
		//inGrid.setValue(rowKey,columnName, 'N');
	}
	

	//저장
	$('#btnSrvcrDtlsSave').on('click', function(){
		btnSaveEH (gridSrvcrItmValDtls, 'SVC0010' ) ;	
	});
	$('#btnSrvcrDtlsSave2').on('click', function(){
		btnSaveEH (gridSrvcrItmValDtls2,'SVC0011' ) ;	
	});

	function btnSaveEH (inGrid, inSrvcrId) {
		var modifiedSrvcrDtlsData = inGrid.dataManager.getAllModifiedData();
		if( modifiedSrvcrDtlsData.createdRows.length +
			modifiedSrvcrDtlsData.deletedRows.length +
			modifiedSrvcrDtlsData.updatedRows.length==0)
		{
			alert('변경된 사항이 없습니다.');
			return false;
		}
		
		if(validSrvcrDtls(inGrid)==false){
			return false;
		}

		var createdRows=[];
		var updatedRows=[];
		var deletedRows=[];
		
		$(modifiedSrvcrDtlsData.createdRows).each(function(){
			var row = this;
			delete row['_attributes'];
			delete row['rowKey'];
			createdRows.push(row);
		});
		$(modifiedSrvcrDtlsData.updatedRows).each(function(){
			var row = this;
			delete row['_attributes'];
			delete row['rowKey'];
			updatedRows.push(row);
		});
		$(modifiedSrvcrDtlsData.deletedRows).each(function(){
			var row = this;
			delete row['_attributes'];
			delete row['rowKey'];
			deletedRows.push(row);
		});		
		
		saveSrvcrDtls(createdRows, updatedRows, deletedRows);	
    	searchSrvcrDtls(inGrid,{'srvcrId':inSrvcrId});

	}
	
	function saveSrvcrDtls(createdRows,updatedRows, deletedRows ){
		
		var param = {'createdRows':createdRows,
			  		 'updatedRows':updatedRows,
					 'deletedRows':deletedRows
					};
		$.ajax({
			 url :"<c:url value='/srvcr/saveSrvcrDtls.ajax'/>"
		    ,type: "POST"
		    ,async:false // 추가 (디폴트 async로 하면 저장시 변경후 값이 안보임)  	   
		    ,contentType:'application/json; charset=UTF-8'
		    ,data :JSON.stringify(param) 
		    ,dataType: 'json'  	   
		    ,success : function(data){
		        //데이터는 눈에보이는것으로 재셋팅--저장버튼 클릭시 또 저장되므로
		        if(data.isSuccess=="Y"){
		        	//searchSrvcrDtls()
					alert('저장하였습니다.');
			    }else{
					alert(data.errorMessage);
				}
			}
		    ,error: function(){
		    	alert('오류가 발생하였습니다.');
		    }
		}); // end of ajax
		
	} // end of function
	
	/*서비스기준 유효성 검증 */
	function validSrvcrDtls(inGrid, inModifiedData){
		var errorInfo = inGrid.validate();
		
		//에러가 없으면
		if(errorInfo.length==0){
			return true;
		}
		
		var rowKey = errorInfo[0].rowKey;
		var colNm = errorInfo[0].errors[0].columnName;
		var errorCode = errorInfo[0].errors[0].errorCode[0];
		if(errorCode =='VALIDATOR_FN'){
			errorCode = errorInfo[0].errors[0].errorInfo[0].customErrorCode;
		}
		var header = inGrid.getColumns().filter(col=>col.name==colNm)[0].header;
		
		var errorMessage = getErrorMessage(errorCode, header);
		alert(errorMessage);
		inGrid.focus(rowKey,colNm);
		return false;

	}
	//초기화버튼
	$('#btnInit').on('click',function(){
		$('#selectTaskDivScls').val('');
		$('#selectTaskDivScls').change();
	});


	
});
</script>