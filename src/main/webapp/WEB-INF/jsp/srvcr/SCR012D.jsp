<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<article class="page-head">
	<div class="head-box inner-width">
		<div class="tit-box">
			<a href="#none" class="like-btn"></a>
			<div class="tit-txt">HTML화면 관리</div>
			<div class="sub-txt">(SCR012D)</div>
		</div>
	
	</div>
</article>

<article class="table-list">
	<article class="page-head">
		<div class="head-box">
			<div class="tit-box">
				<div class="tit-txt">태그목록</div>
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
		</div>
	</article>

	<div class="inner-width">
		<article class="list-table">
			<div  id="gridSrvcrItmValDtls2">
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
	const Grid = tui.Grid;

	Grid.applyTheme('striped', {
		cell: {
			header: {
				background: '#eef1f5'
			},
			evenRow: {
				background: '#edeff5'
			}
		}
	});
	const gridSrvcrItmValDtls = new Grid({
		el: document.getElementById('gridSrvcrItmValDtls'), // Container element
		bodyHeight:300,
		rowHeaders:['rowNum','checkbox'],
		pageOptions:{useClient:true,perPage:10},
		columns: [
			
		],
		header:{align:'center',valign:'middle'},
		data: []
	});

	const Grid2 = tui.Grid;
	
	Grid2.applyTheme('clean', {
		cell: {
			header: {
				background: '#eef1f5'
			}
		}
	});	
	const gridSrvcrItmValDtls2 = new Grid2({
		el: document.getElementById('gridSrvcrItmValDtls2'), // Container element
		//bodyHeight:300,
		width: 500,
		scrollX: false,
		scrollY: false,
		//rowHeaders:['rowNum','checkbox'],
		//pageOptions:{useClient:true,perPage:50},
		columns: [
	      {
	        header: '항목명(논리)',
	        name: 'item_lo'
	      },
	      //{
		  //      header: '항목명(물리)',
		  //      name: 'item_ph'
		  //    },
	      {
	        header: '항목값',
	        name: 'item_val'
	      }
		],
		header:{align:'center',valign:'middle'},
		data: []
	});
	
	searchSrvcrDtls();
	
	//검색버튼 클릭
	$('#btnSearch').on('click', function(){
		searchSrvcrDtls();
	});
	//서비스기준내역 조회 : 검색하면 실행 searchSrvcrDtls
	// 가져오는 것과 grid 셋팅하는것 분리 필요
	// 가져오는 js 공통모듈화 가능?
	function searchSrvcrDtls(){
		gridSrvcrItmValDtls.clear();
		gridSrvcrItmValDtls2.clear();

		//grid Column(Header) 세팅
		setGridSrvcrItmValDtlsColumns();
		console.log('데이터추출');
		gridSrvcrItmValDtls.resetData(selectSrvcrDtls('SVC0006'));
		selectSrvcrValDtls('SVC0006'); // for 테스트
		
	}

	
	// 기준내역 데이터 추출
	function selectSrvcrDtls(srvcrId) {
		
		var srvcrId = srvcrId;//SVC0006 HTML화면
		var sil;
		//서비스기준항목값내역 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrDtls.ajax'/>"
	        ,type: "POST"
	        ,async:false  // 함수로 싸서 피호출되게 한 경우, 비동기로해야 에러 안남
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'srvcrId': srvcrId,'critYmd':'99991231235959'}  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	sil = data.list;
			}
		    ,error: function(){
		    	alert('오류가 발생하였습니다.');
		    }
		});
		
    	//console.log(sil);
		return sil;
		
	}

	// 기준내역 데이터 추출
	function selectSrvcrValDtls(srvcrId) {
		
		var srvcrId = srvcrId;//SVC0006 HTML화면
		var sil;
		//서비스기준항목값내역 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrValDtls.ajax'/>"
	        ,type: "POST"
	        ,async:false  // 함수로 싸서 피호출되게 한 경우, 비동기로해야 에러 안남
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'srvcrId': srvcrId,'critYmd':'99991231235959'}  
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
	

	//서비스기준내역 columns 설정
	var srvcrItmList;
	function setGridSrvcrItmValDtlsColumns(){
		var srvcrId = 'SVC0006';//서비수기준
		
		//ajax로 서비스기준항목내역 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrItmDtlsNew.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'srvcrId':srvcrId}  
	        ,dataType: 'json'
		    ,async:false  	   
	        ,success : function(data){
	        	var columns = [];
	        	srvcrItmList = data.list;
	        	//console.log(srvcrItmList);  // 이상하게도 콘솔로그에 아래 로직 변경된 결과를 보여주므로 주의할것!
	    		$(srvcrItmList).each(function(){
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
	    				namephy:this.critmPhyNm,  // 김정삼 추가 
	    				name: this.critmId, // 왜 critmId를 name이라 했지?
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
	    		
	    		gridSrvcrItmValDtls.setColumns(columns);
	        	
			}
		    ,error: function(){
		    	alert('오류가 발생하였습니다.');
		    }
		});
	
	
	}
	//행추가
	$('#btnAddRow').on('click', function(){
		
		if(gridSrvcrItmValDtls.getColumns().length<1){
			alert('검색후 가능합니다.');
			return false;
		}
		gridSrvcrItmValDtls.prependRow({srvcrId:'SVC0006', idnfItmValDtlsSn:null, vldEndDt:'자동등록', vldBgngDt:'자동등록'});
	});
	//행삭제
	$('#btnDelRow').on('click', function(){
		var rowKeys = gridSrvcrItmValDtls.getCheckedRowKeys();
		if(rowKeys.length<1){
			alert('삭제할 행을 선택하세요.');
			return false;
		}
		$(rowKeys).each(function(i,val){
			gridSrvcrItmValDtls.removeRow(val);
		});
	});
	//파일업로드
	$('#btnFileUpload').on('click', function(){
		
		if($('#selectSrvcr').val()==''){
			alert('검색후 가능합니다.');
			return false;
		}
		var srvcrNm = $('#selectSrvcr :selected').text();
		if(confirm('['+srvcrNm+']의 데이터를 등록하시겠습니까?')){
			//팝업 셋팅
			$.ajax({
				url :"<c:url value='/cmm/openSCR008P.do'/>"
		        ,type: "POST"
		        ,data : {'srvcrId':$('#selectSrvcr').val()}//parameter
		        ,dataType: 'html'
			    //,async:false  	   
		        ,success : function(html){
		        	$('#popupExcelUpload').html(html);

		        	$('.container').addClass('overlay');
		    		$('#popupExcelUpload').data('callback',function(val){
		    			searchSrvcrDtls();
		    		}).show();
				}
			    ,error: function(){
			    	alert('오류가 발생하였습니다.');
			    }
			});
		}
	});
	//파일다운로드
	$('#btnFileDownload').on('click', function(){
		if(gridSrvcrItmValDtls.getColumns().length<1){
			alert('검색후 가능합니다.');
			return false;
		}
		var columns = gridSrvcrItmValDtls.getColumns();
		var colNames = [];
		$(columns).each(function(){
			colNames.push(this.name);
		});
		var srvcrNm = $('#selectSrvcr :selected').text();
		gridSrvcrItmValDtls.export('xlsx', { includeHeader: true,columnNames:colNames, fileName:srvcrNm+'_데이터'});
	});
	//파일양식다운로드
	$('#btnFormDownload').on('click', function(){
		if(gridSrvcrItmValDtls.getColumns().length<1){
			alert('검색후 가능합니다.');
			return false;
		}
		var columns = gridSrvcrItmValDtls.getColumns();
		var colNames = [];
		$(columns).each(function(){
			colNames.push(this.name);
			console.log(his.name);
		});
		var srvcrNm = $('#selectSrvcr :selected').text();
		gridSrvcrItmValDtls.filter('idnfItmVal1', [{code: 'eq', value: ''}]);
		gridSrvcrItmValDtls.export('xlsx', { includeHeader: true,columnNames:colNames, fileName:srvcrNm+'_양식'});
		gridSrvcrItmValDtls.unfilter('idnfItmVal1');
	});
	
	//그리드 클릭
	gridSrvcrItmValDtls.on('click', function(ev){
		if(ev.targetType!='cell'){
			return false;
		}
		var rowKey = ev.rowKey;
		// 이하 그리드2 셋팅 ----------------------------
		var columns = gridSrvcrItmValDtls.getColumns();
		gridSrvcrItmValDtls2.clear();
		var rowData;
		//console.log(columns);
		$(columns).each(function(){
			//console.log(this.name+" "+this.header+" "+gridSrvcrItmValDtls.getValue(rowKey,this.name));
			rowData = {item_lo: this.header, item_ph:this.name, item_val: gridSrvcrItmValDtls.getValue(rowKey,this.name) } ;
			//console.log(rowData);
			gridSrvcrItmValDtls2.appendRow(rowData);
			//console.log(gridSrvcrItmValDtls2.getValue(1,'item_lo'));
			//rowData = [];
		});
		
		// ---------------------------------

	});
	
	//그리드 클릭
	// 
	gridSrvcrItmValDtls2.on('click', function(ev){
		if(ev.targetType!='cell'){
			return false;
		}
		var rowKey = ev.rowKey;

		console.log('항목명(논리):'+gridSrvcrItmValDtls2.getValue(rowKey, 'item_lo'));
		console.log('항목명(물리):'+gridSrvcrItmValDtls2.getValue(rowKey, 'item_ph'));
		console.log('항목값:'+gridSrvcrItmValDtls2.getValue(rowKey, 'item_val'));

		//var columnName = ev.columnName;
		var columnName = gridSrvcrItmValDtls2.getValue(rowKey, 'item_lo');
		
		//유효종료일시, 유효시작일시이면 팝업창 안뜸
		//if(columnName=='vldBgngDt' || columnName=='vldEndDt'){
		if(columnName=='유효시작일시' || columnName=='유효종료일시'){
			return false;
		}
		console.log('columnName:'+columnName);
		//console.log('columnName:'+columnName);
		// 선택한 로우에 해당하는 서비스기준항목 내역 추출(도메인논리명 포함)한 것을 column에 저장
		var column = srvcrItmList.filter(function(element){return element.critmNm===columnName})[0];
		console.log(srvcrItmList.filter(function(element){return element.critmNm===columnName})[0]);
		var dmnGroupNm = column.dmnGroupNm;
		var cdvlTnm = column.cdvlTnm;
		var dmnPhyNm = column.dmnPhyNm;
		var critmNm = column.critmNm;
		var idnfItmYn = column.idnfItmYn;
		var dmnLgcNm = column.dmnLgcNm;
		var dmnPhyTblNm = column.dmnPhyTblNm;
		var critmRefId  = column.critmRefId;
		var row = gridSrvcrItmValDtls2.getRow(rowKey);
		var vldEndDt = row.vldEndDt;
		
		// 
		//if(vldEndDt!='99991231235959' && vldEndDt!='자동등록' ){
		//	console.log('유효하지 않은 데이터');
		//	return false;
		//}

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
		// 전달받은 html을 popupRegCritmVal에 뿌린다? 	(display none는 어디서 변경?)	
		$.ajax({
			url : url
	        ,type: "POST"
	        ,data : {'critmNm':critmNm, 'cdvlTnm':cdvlTnm, 'dmnLgcNm':dmnLgcNm, 'dmnPhyNm':dmnPhyNm, 'dmnPhyTblNm':dmnPhyTblNm}//parameter
	        ,dataType: 'html'
		    ,async:false  	   
	        ,success : function(html){
	        	$('#popupRegCritmVal').html(html);
			}
		    ,error: function(){
		    	
		    }
		});
		$('.container').addClass('overlay'); // addClass하면 overlay가 보여짐?
		
		$('#labelCritmNm').text(critmNm); // labelCritmNm는 팝업에 있는것
		$('#popupRegCritmVal').data('callback',function(val){
			gridSrvcrItmValDtls2.setValue(rowKey,'item_val', val);
		}).show();


	});


	//저장
	


	$('#btnSrvcrDtlsSave').on('click', function(){
		var modifiedSrvcrDtlsData = gridSrvcrItmValDtls.dataManager.getAllModifiedData();
		if( modifiedSrvcrDtlsData.createdRows.length +
			modifiedSrvcrDtlsData.deletedRows.length +
			modifiedSrvcrDtlsData.updatedRows.length==0)
		{
			alert('변경된 사항이 없습니다.');
			return false;
		}
		
		if(validSrvcrDtls()==false){
			return false;
		}

		var createdRows=[];
		var updatedRows=[];
		var deletedRows=[];
		
//-------------------
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
		
		saveSrvcrDtls(createdRows,updatedRows, deletedRows );
	});
	
	function saveSrvcrDtls(createdRows,updatedRows, deletedRows ){

		var param = {'createdRows':createdRows,
				'updatedRows':updatedRows,
				'deletedRows':deletedRows
			};
		$.ajax({
			 url :"<c:url value='/srvcr/saveSrvcrDtls.ajax'/>"
		    ,type: "POST"
		    ,contentType:'application/json; charset=UTF-8'
		    ,data :JSON.stringify(param) 
		    ,dataType: 'json'  	   
		    ,success : function(data){
		        //데이터는 눈에보이는것으로 재셋팅--저장버튼 클릭시 또 저장되므로
		        if(data.isSuccess=="Y"){
		        	searchSrvcrDtls()
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
	function validSrvcrDtls(modifiedData){
		var errorInfo = gridSrvcrItmValDtls.validate();
		
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
		var header = gridSrvcrItmValDtls.getColumns().filter(col=>col.name==colNm)[0].header;
		
		var errorMessage = getErrorMessage(errorCode, header);
		alert(errorMessage);
		gridSrvcrItmValDtls.focus(rowKey,colNm);
		return false;

	}
	//초기화버튼
	$('#btnInit').on('click',function(){
		$('#selectTaskDivScls').val('');
		$('#selectTaskDivScls').change();
	});
});
</script>