<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<article class="page-head">
	<div class="head-box inner-width">
		<div class="tit-box">
			<a href="#none" class="like-btn"></a>
			<div class="tit-txt">서비스기준 내역 관리</div>
			<div class="sub-txt">(SCR002M)</div>
		</div>
	</div>
</article>

<article class="search-form">
	<div class="wrap box-style inner-width">
		<div class="form-group">
			<div class="row">
				<div class="item-box type-3">

					<div class="subject-box"><span class="txt">업무구분</span></div>
					<div class="con-box">
						<div class="sbox">
							<select id="selectTaskDivScls">
								
							</select>
						</div>
					</div>
				</div>
				<div class="item-box type-3">
					<div class="subject-box ess"><span class="txt">서비스기준명</span></div>
					<div class="con-box">
						<div class="sbox">
							<select id="selectSrvcr">
								<option value="">선택</option>
							</select>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<div class="menu-group">
		<a href="#none" class="menu-btn type-2" id="btnInit">초기화</a>
		<a href="#none" class="menu-btn" id="btnSearch">검색</a>
	</div>
</article>


<article class="table-list">
	<article class="page-head">
		<div class="head-box">
			<div class="tit-box">
				<div class="tit-txt">서비스 기준 내역</div>
			</div>
			<div class="menu-box">
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
				<div class="tit-txt">서비스기준내역 이력</div>
				<div class="sub-txt"></div>
			</div>
		</div>
	</article>

	<div class="inner-width">
		<article class="">
			<div id="gridSrvcrItmValDtlsHist">
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
	const gridSrvcrItmValDtlsHist = new Grid({
		el: document.getElementById('gridSrvcrItmValDtlsHist'), // Container element
		bodyHeight:300,
		rowHeaders:['rowNum'],
		pageOptions:{useClient:true,perPage:10},
		columns: [
			
		],
		header:{align:'center',valign:'middle'},
		data: []
	});
	function init(){
		setSelectComponent('selectTaskDivScls','TASK_DIV_SCLS_CD', 'SELECT');
	}
	init();
	//업무구분 변경시
	$('#selectTaskDivScls').on('change', function(){
		var taskDivSclsCd = $('#selectTaskDivScls').val();
		$('#selectSrvcr').empty();

		if(taskDivSclsCd=='') {
			$('#selectSrvcr').append('<option value="">선택</option>');
			return false;
		}

		//ajax로 서비스기준 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcr.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'taskDivSclsCd':taskDivSclsCd}  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	//실제로는 ajax로 데이터 땡겨옴.
	        	setSelectSrvcrOptions(data.list);
	        	
			}
		    ,error: function(){
		    	
		    }
		});
	});
	//서비스기준명 selectbox 셋팅
	function setSelectSrvcrOptions(list){
		$(list).each(function(){
			$('#selectSrvcr').append('<option value="'+this.srvcrId+'">'+this.srvcrNm+'</option>');
		});
	}
	//검색버튼 클릭
	$('#btnSearch').on('click', function(){
		searchSrvcrDtls();
	});
	//서비스기준내역 조회
	function searchSrvcrDtls(){
		if($('#selectTaskDivScls').val()==''){
			alert('업무구분은 필수 입력입니다.');
			return false;
		}
		gridSrvcrItmValDtls.clear();
		gridSrvcrItmValDtlsHist.clear();

		//grid Column(Header) 세팅
		setGridSrvcrItmValDtlsColumns();
		var srvcrId = $('#selectSrvcr').val();//서비수기준
		//ajax로 호출해와야지~
		
		//gridSrvcrItmValDtls.resetData(eval(srvcrId+'_data'));
		//서비스기준항목값내역 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrDtls.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'srvcrId': $('#selectSrvcr').val(),'critYmd':'99991231235959'}  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	//실제로는 ajax로 데이터 땡겨옴.
	        	gridSrvcrItmValDtls.resetData(data.list);
	        	
			}
		    ,error: function(){
		    	alert('오류가 발생하였습니다.');
		    }
		});
	}
	var srvcrItmList;
	//서비스기준내역 columns 설정
	function setGridSrvcrItmValDtlsColumns(){
		var srvcrId = $('#selectSrvcr').val();//서비수기준
		
		//ajax로 서비스기준항목내역 조회
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcrItmDtls.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :{'srvcrId':srvcrId}  
	        ,dataType: 'json'
		    ,async:false  	   
	        ,success : function(data){
	        	var columns = [];
	        	srvcrItmList = data.list;
	    		$(srvcrItmList).each(function(){
	    			var colName = '';
	    			if(this.critmId=="ST00002"){//유효종료일자이면
		    			colName = 'vldEndDt';
		    			this.critmId = 'vldEndDt';
	    			}else if(this.critmId=="ST00003"){//유효시작일자이면
			    		colName = 'vldBgngDt';
			    		this.critmId = 'vldBgngDt';
		    		}else if(this.idnfItmYn=="Y"){//유효시작/종료이외의 식별자항목이면
	    				colName = 'idnfItmVal' + this.srvCritmOrd;
	    				this.critmId = 'idnfItmVal' + this.srvCritmOrd;
		    		}else{//일반항목은 그대로~
		    			colName = this.critmId.toLowerCase();//소문자로-->sql에서 소문자로 던져줘서..
		    			this.critmId = this.critmId.toLowerCase();//소문자로-->sql에서 소문자로 던져줘서..
			    	}
	    			var column = 
	    			{
	    				header:this.critmNm, 
	    				name: this.critmId, 
	    				editor: { 
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
	    			console.log(columns);
	    			columns.push(column);
	    		});
	    		
	    		gridSrvcrItmValDtls.setColumns(columns);
	    		gridSrvcrItmValDtlsHist.setColumns(columns);
	        	
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
		gridSrvcrItmValDtls.prependRow({srvcrId:$('#selectSrvcr').val(), idnfItmValDtlsSn:null, vldEndDt:'자동등록', vldBgngDt:'자동등록'});
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
		var columnName = ev.columnName;
		//유효종료일시, 유효시작일시이면 팝업창 안뜸
		if(columnName=='vldBgngDt' || columnName=='vldEndDt'){
			return false;
		}
		
		var column = srvcrItmList.filter(function(element){return element.critmId===columnName})[0];
		var dmnGroupNm = column.dmnGroupNm;
		var cdvlTnm = column.cdvlTnm;
		var dmnPhyNm = column.dmnPhyNm;
		var critmNm = column.critmNm;
		var idnfItmYn = column.idnfItmYn;
		var dmnLgcNm = column.dmnLgcNm;
		var dmnPhyTblNm = column.dmnPhyTblNm;
		var row = gridSrvcrItmValDtls.getRow(rowKey);
		var vldEndDt = row.vldEndDt;
		if(vldEndDt!='99991231235959' && vldEndDt!='자동등록' ){
			console.log('유효하지 않은 데이터');
			return false;
		}
		//기존데이터이면서 식별자이면 이력만 조회되도록.
		if(row.idnfItmValDtlsSn!=null && idnfItmYn=='Y'){
			searchSrvcrDtlsHist(row);
			return false;
		}
		console.log(dmnGroupNm);
		var url = "<c:url value='/cmm/openSCR007P.do'/>";
		//도메인물리테이블이 있으면 page 바꿈.
		if(dmnPhyTblNm!=null){
			url = "<c:url value='/cmm/openSCR009P.do'/>";
		}
		//팝업 셋팅
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
		$('.container').addClass('overlay');
		
		$('#labelCritmNm').text(critmNm);
		$('#popupRegCritmVal').data('callback',function(val){
			gridSrvcrItmValDtls.setValue(rowKey,columnName, val);
		}).show();
		/*
		if(cdvlTnm==''){
			$('#textBox').show();
			$('#selectBox').hide();
		}else if(cdvlTnm=='단순코드'){
			$('#textBox').hide();
			$('#selectBox').show();
			//ajax로 공통코드 조회
			$('#selectCritmVal').empty();
			$('#selectCritmVal').append('<option value="001">코드1[001]</option>');
			$('#selectCritmVal').append('<option value="002">코드2[002]</option>');
			$('#selectCritmVal').append('<option value="003">코드3[003]</option>');
		}else if(cdvlTnm=='여부' || cdvlTnm=='유무'){
			$('#selectCritmVal').empty();
			$('#selectCritmVal').append('<option value="Y">Y</option>');
			$('#selectCritmVal').append('<option value="N">N</option>');
		}else if(cdvlTnm=='목록코드'){
			$('#textBox').show();
			$('#selectBox').hide();
		}*/
	});
	function searchSrvcrDtlsHist(srvcrDtlsData){
		//식별자List
		var idnfItmList = srvcrItmList.filter(function(element){return element.idnfItmYn==="Y"});
		var searchCond={};//이력을 조회하기 위한 식별자 값 json

		//유효종료/시작일시 빼고
		for(i=0; i<idnfItmList.length-2; i++){
			searchCond['idnfItmVal'+(i+1)] = srvcrDtlsData[idnfItmList[i].critmId];
		}
		//조회하기 위한 파라미터 셋팅 완료
		console.log(searchCond);
		//ajax 로 이력 조회

		
		//서비스기준내역 이력조회
		$.ajax({
			url :"<c:url value='/srvcr/selectSrvcrDtls.ajax'/>"
	        ,type: "POST"
	        ,data : srvcrDtlsData
	        ,dataType: 'json'
		    ,async:false  	   
	        ,success : function(data){
	        	gridSrvcrItmValDtlsHist.resetData(data.list);
			}
		    ,error: function(){
		    	
		    }
		});
		
		
		
		
		
	}
	//저장
	$('#btnSrvcrDtlsSave').on('click', function(){
		var modifiedSrvcrDtlsData = gridSrvcrItmValDtls.dataManager.getAllModifiedData();
		if(modifiedSrvcrDtlsData.createdRows.length +
			modifiedSrvcrDtlsData.deletedRows.length +
			modifiedSrvcrDtlsData.updatedRows.length==0)
		{
			alert('변경된 사항이 없습니다.');
			return false;
		}
		
		if(validSrvcrDtls()==false){
			return false;
		}

//-------------------
		var createdRows=[] ;
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
		});
	});
	
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