<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<article class="page-head">
	<div class="head-box inner-width">
		<div class="tit-box">
			<a href="#none" class="like-btn"></a>
			<div class="tit-txt">기준관리</div>
			<div class="sub-txt">(SCR001M)</div>
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
					<div class="subject-box ess"><span class="txt">기준명</span></div>
					<div class="con-box">
						<div class="ibox">
							<input type="text" id="txtSrvcrNm" placeholder="기준명을 입력하세요.">
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
				<div class="tit-txt">서비스 기준</div>
			</div>

			<div class="menu-box">
				<a href="#none" class="menu-btn" id="btnSrvcrNew">신규</a>
				<a href="#none" class="menu-btn" id="btnSrvcrModify">변경</a>
				<a href="#none" class="menu-btn" id="btnSearchSrvcrHist">이력조회</a>
			</div>
		</div>



	</article>

	<div class="inner-width">
		<article class="list-table">
			<div  id="grid">
				

			</div>
			<div class="page-foot">
				<div class="page-menu">
					<a href="#none" class="btn type-1" id='btnSrvcrSave'>저장</a>
				</div>
			</div>
		</article>
		
	</div>


</article>

<article class="table-list">

	<article class="page-head">
		<div class="head-box">
			<div class="tit-box">
				<div class="tit-txt">기준 항목</div>
				<div class="sub-txt"></div>
			</div>
			<div class="menu-box">
				<a href="#none" class="menu-btn" id="btnAdd">추가</a>
				<a href="#none" class="menu-btn" id="btnSrvcrItmModify">변경</a>
				<a href="#none" class="menu-btn" id="btnDelete">삭제</a>
			</div>
		</div>
	</article>

	<div class="inner-width">
		<article class="">
			<div id="gridSrvcrItm">
				
			</div>

		</article>
	</div>


</article>


<div class="page-foot">
	<div class="page-menu">
		<a href="#none" class="btn type-1" id='btnSaveSrvcrItmDtls'>저장</a>
	</div>
</div>
<article class="popup popup-table type-long"    style="display: none" id="popSrvcrRegPop">
</article>
<article class="popup popup-table type-long"    style="display: none" id="popSrvcrHist">
</article>
<article class="popup popup-table type-long"    style="display: none" id="popSrvcrItmMod">
</article>
<article class="popup popup-table type-long"    style="display: none" id="pop">
</article>
<script>
$(document).ready(function(){
	var gridSrvcr = new Grid({
		el: document.getElementById('grid'), // Container element
		bodyHeight:250,
		rowHeaders:[{type:'rowNum'},{type:'checkbox',header:"<input type='checkbox' disabled/>"}],//전체선택 안되게  disabled
		pageOptions:{useClient:true,perPage:10},
		columns: [
			{ header: '서비스기준ID'  ,	name: 'srvcrId' , hidden:true},
			{ header: '서비스기준명'  ,	name: 'srvcrNm'      },
			{ header: '서비스기준설명', name: 'srvcrDc'      },
			{ header: '서비스기준뷰명', name: 'srvcrViewNm'  },
			{ header: '업무구분'	 , name: 'taskDivSclsCd', hidden:true},
			{ header: '업무구분'	 , name: 'taskDivSclsNm'},
			{ header: '사용시작일자' , name: 'useBgngYmd'   },
			{ header: '사용종료일자' , name: 'useEndYmd'    }
		],
		header:{align:'center',valign:'middle'},
		data: []
	});
	var gridSrvcrItm = new Grid({
		el: document.getElementById('gridSrvcrItm'), // Container element
		data: [],
		draggable: true,//drag&drop
		rowHeaders:[{type:'rowNum'},{type:'checkbox',header:"<input type='checkbox' disabled/>"},'draggable'],//전체선택 안되게  disabled
	//	pageOptions:{useClient:true,perPage:5},
		columns: [
			{ header: '서비스기준ID', 	name: 'srvcrId' , hidden:true,filter:{type:'text'}},
			{ header: '항목ID', 	name: 'critmId' , hidden:true},
			{ header: '물리명', 	name: 'critmPhyNm' , },
			{ header: '항목명', name: 'critmNm'},
			{ header: '식별항목여부', name: 'idnfItmYn'},
			{ header: '서비스기준항목순서', name: 'srvCritmOrd', sortable: false, hidden:true},
			{ header: '사용시작일자', name: 'useBgngYmd', editor:'datePicker', 
				validation:{dataType:'string', required:true, validatorFn: (value, row, columnName) => { return {valid: value <= row['useEndYmd'],meta: { customErrorCode: 'BGNG_DATE_ERROR_CODE' }}}}},
			{ header: '사용종료일자', name: 'useEndYmd', editor:{type:'datePicker', options:{format:'yyyy-MM-dd'}}, 
						validation:{dataType:'string', required:true, validatorFn: (value, row, columnName) => { return {valid: value >= row['useBgngYmd'],meta: { customErrorCode: 'END_DATE_ERROR_CODE' }}}}			}
		],
		header:{align:'center',valign:'middle'}
	});

	function init(){
		
		setSelectComponent('selectTaskDivScls','TASK_DIV_SCLS_CD', 'ALL');
		//화면컴포넌트제어
		getAcctlCmpntId('${acctlPgmId}');
	}
	init();

	//신규버튼 클릭시
	$('#btnSrvcrNew').on('click', function(){
        //한row 추가
		gridSrvcr.prependRow();

	});
	//서비스기준 변경버튼 클릭
	$('#btnSrvcrModify').on('click', function(){
		var rows = gridSrvcr.getCheckedRows();
		if(rows.length<1){
			alert('변경할 데이터를 선택하세요.');
			return false;
		}
		var srvcrId = rows[0].srvcrId;
		
		if(callSrvcrRegPop(srvcrId)){
			
		}
		
		//data에 row를 담고 callback 설정
		$('#popSrvcrRegPop').data('callback',function callback(data){
			setGridSrvcrData(data,rows[0].rowKey);
		}).show();
		//서비스기준 popup에 데이터셋팅
		setPopSrvcrData(rows[0]);
	});


	//서비스기준 팝업에 데이터 셋팅
	function setPopSrvcrData(data){
		$('#popSrvcrNm').val(data.srvcrNm);
		$('#popSrvcrViewNm').val(data.srvcrViewNm);
		$('#popTaskDivSclsCd').val(data.taskDivSclsCd);
		$('#popSrvcrDc').val(data.srvcrDc);
		$('#popSrvcrUseBgngYmd').val(data.useBgngYmd);
		$('#popSrvcrUseEndYmd').val(data.useEndYmd);
	}
	//서비스기준 그리드에 데이터 셋팅
	function setGridSrvcrData(data, rowKey){
		
		gridSrvcr.setValue(rowKey,'srvcrNm', data.srvcrNm);
		gridSrvcr.setValue(rowKey,'srvcrDc', data.srvcrDc);
		gridSrvcr.setValue(rowKey,'srvcrViewNm', data.srvcrViewNm);
		gridSrvcr.setValue(rowKey,'taskDivSclsCd', data.taskDivSclsCd);
		gridSrvcr.setValue(rowKey,'taskDivSclsNm', data.taskDivSclsNm);
		gridSrvcr.setValue(rowKey,'useBgngYmd', data.useBgngYmd);
		gridSrvcr.setValue(rowKey,'useEndYmd', data.useEndYmd);
	}
	gridSrvcr.on('click',function(ev){
		//데이터가 있는 cell이 아니면
		if(ev.targetType!='cell'){
			return false;
		}
        var rowKey = ev.rowKey;
		
		var row = gridSrvcr.getRow(rowKey);
		
		var srvcrId = row.srvcrId;
		
		//신규등록이면 등록팝업창 호출
		if(srvcrId == null){
			gridSrvcrItm.clear();
			$('.container').addClass('overlay');
			callSrvcrRegPop('');
			
			$('#popSrvcrRegPop').data('callback',function callback(data){
				setGridSrvcrData(data, rowKey);
			}).show();;
		}
		//기존 데이터면 서비스기준항목 목록 조회
		else{
			selectGridSrvcrItmData(srvcrId);
			
		}
	});
	//서비스기준항목 그리드 데이터 셋팅
	function selectGridSrvcrItmData(srvcrId){

		$.ajax({
			url :"<c:url value='/srvcr/selectSrvcrItmDtls.ajax'/>"
	        ,type: "POST"
	        ,data : {'srvcrId':srvcrId}//parameter
	        ,dataType: 'json'
		    ,async:false  	   
	        ,success : function(data){
		        setGridSrvcrItmData(srvcrId, data.list);
	        	
			}
		});
	
		/*개발시에는 ajax로 조회
		var dataList = eval('srvcrItmData_'+srvcrId);

		data = dataList.filter(function(element){return element.critmId==='ST00002'})[0];
		data._attributes= {disabled: true };// 수정/삭제 못하게 처리
		data = dataList.filter(function(element){return element.critmId==='ST00003'})[0];
		data._attributes= { disabled: true 	}// 수정/삭제 못하게 처리
		*/
		
		//console.log(ev);
	}
	function setGridSrvcrItmData(srvcrId, list){
		if(list.length==0){
			list =
			[{
				srvcrId:srvcrId,
				critmId:'ST00002',
				critmNm:'유효종료일시',
				critmPhyNm:'VLD_END_DT',
				srvCritmOrd:3,
				idnfItmYn:'Y',
				useBgngYmd:getToday(),
				useEndYmd:'9999-12-31',
				dmnGroupNm:'',
				cdvlTnm:'',
				dmnPhyNm:'',
				datatpNm:'VARCHAR2'
			},
			{
				srvcrId:srvcrId,
				critmId:'ST00003',
				critmNm:'유효시작일시',
				critmPhyNm:'VLD_BGNG_DT',
				srvCritmOrd:4,
				idnfItmYn:'Y',
				useBgngYmd:getToday(),
				useEndYmd:'9999-12-31',
				dmnGroupNm:'',
				cdvlTnm:'',
				dmnPhyNm:'',
				datatpNm:'VARCHAR2'
			}]
		
			gridSrvcrItm.clear();
			var data = list.filter(function(element){return element.critmId==='ST00002'})[0];
			data._attributes= {disabled: true };// 수정/삭제 못하게 처리
			gridSrvcrItm.appendRow(data);//created 상태 
			data = list.filter(function(element){return element.critmId==='ST00003'})[0];
			data._attributes= { disabled: true 	}// 수정/삭제 못하게 처리
			gridSrvcrItm.appendRow(data);
		}else{
			var data = list.filter(function(element){return element.critmId==='ST00002'})[0];
			data._attributes= {disabled: true };// 수정/삭제 못하게 처리
			gridSrvcrItm.appendRow(data);//created 상태 
			data = list.filter(function(element){return element.critmId==='ST00003'})[0];
			data._attributes= { disabled: true 	}// 수정/삭제 못하게 처리
			gridSrvcrItm.resetData(list);
		}
		//gridSrvcrItm.appendRows(list);
		//
		
	}
	//서비스기준 그리드 체크박스 선택시
	function callSrvcrRegPop(srvcrId){
		
		$.ajax({
			url :"<c:url value='/cmm/openSCR003P.do'/>"
	        ,type: "POST"
	        ,data : {'srvcrId':srvcrId}//parameter
	        ,dataType: 'html'
		    ,async:false  	   
	        ,success : function(html){
	        	$('#popSrvcrRegPop').html(html);
			}
		});
		return false;
	}
	gridSrvcr.on('check',function(ev){
		var rowKey = ev.rowKey;
		var rows = gridSrvcr.getCheckedRows();
		
		//한개만 체크되도록
		$.each(rows, function(index, row){
			if(rowKey!=row.rowKey){
				gridSrvcr.uncheck(row.rowKey);
			}
		});
	});

	//서비스기준 저장
	$('#btnSrvcrSave').on('click', function(){
		if(gridSrvcr.isModified()==false){
			alert('수정된 데이터가 없습니다.');
			return false;
		}
		var isOK=true;
		var modifiedSrvcrData = gridSrvcr.dataManager.getAllModifiedData();
		$(modifiedSrvcrData.createdRows).each(function(){
			if(this.srvcrNm==null){
				alert('기준명은 필수 입력입니다.');
				gridSrvcr.focus(this.rowKey,'srvcrNm');
				isOK = false;
				return false;
			}
		});

		if(isOK){
			var createdRows=[] ;
			var updatedRows=[];
			var deletedRows=[];
			$(modifiedSrvcrData.createdRows).each(function(){
				var row = this;
				delete row['_attributes'];
				createdRows.push(row);
			});
			$(modifiedSrvcrData.updatedRows).each(function(){
				var row = this;
				delete row['_attributes'];
				updatedRows.push(row);
			});
			$(modifiedSrvcrData.deletedRows).each(function(){
				var row = this;
				delete row['_attributes'];
				deletedRows.push(row);
			});
			
			var param = {'createdRows':createdRows,
						'updatedRows':updatedRows,
						'deletedRows':deletedRows
					};
			$.ajax({
				 url :"<c:url value='/srvcr/saveSrvcr.ajax'/>"
		        ,type: "POST"
			    ,contentType:'application/json; charset=UTF-8'
		        ,data :JSON.stringify(param) 
		        ,dataType: 'json'  	   
		        ,success : function(data){
			        //데이터는 눈에보이는것으로 재셋팅--저장버튼 클릭시 또 저장되므로
			        if(data.isSuccess=="Y"){
			        	searchSrvcr();
						alert('저장하였습니다.');
				    }else{
						alert(data.errorMessage);
					}
		        	
				}
			});
		}
		
	});
	
	/*조회버튼 클릭*/
	$('#btnSearch').on('click',function(){
		searchSrvcr();
	});
	function searchSrvcr(){
		var data = 
			{	
				taskDivSclsCd:$('#selectTaskDivScls').val(),
	        	srvcrNm:$('#txtSrvcrNm').val()
        	} 
		$.ajax({
			 url :"<c:url value='/srvcr/selectSrvcr.ajax'/>"
	        ,type: "POST"
		    //,contentType:'application/json; charset=UTF-8'
	        ,data :data  
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	//실제로는 ajax로 데이터 땡겨옴.
	    		gridSrvcr.resetData(data.list);		
	    		gridSrvcrItm.clear();
			}
		});
	}
	/*초기화버튼 클릭*/
	$('#btnInit').on('click',function(){
		$('#selectTaskDivScls').val('');
		$('#txtSrvcrNm').val('');
	});
	//서비스기준항목 변경
	$('#btnSrvcrItmModify').on('click', function(){
		var rows = gridSrvcrItm.getCheckedRows();
		if(rows.length<1){
			alert('기준항목을 선택하세요');
			return false;
		}
		$('.container').addClass('overlay');

		$.ajax({
			url :"<c:url value='/cmm/openSCR006P.do'/>"
	        ,type: "POST"
	        ,data : {'srvcrId':rows[0].srvcrId,'critmId':rows[0].critmId}//parameter
	        ,dataType: 'html'
		    ,async:false  	   
	        ,success : function(html){
	        	$('#popSrvcrItmMod').html(html);
			}
		});
		
		setPopSrvcrItmMod_SrvcrItmData(rows[0])
		$('#popSrvcrItmMod').data('callback',function(data){
			
			var rowKey = rows[0].rowKey;
			gridSrvcrItm.setValue(rowKey,'idnfItmYn',data.idnfItmYn);
			gridSrvcrItm.setValue(rowKey,'useBgngYmd',data.useBgngYmd);
			gridSrvcrItm.setValue(rowKey,'useEndYmd',data.useEndYmd);
			
			//식별자여부가 N->Y로 변경
			if(data.idnfItmYn=='Y' && rows[0].idnfItmYn=='N'){
				var rownum = gridSrvcrItm.findRows({critmId:'ST00002'})[0]._attributes.rowNum-1;//유효종료일자의 순서
				
				gridSrvcrItm.moveRow(rowKey,rownum);//유효종료일자 위로
				setSrvCritmOrdAll(gridSrvcrItm.getData());
			}
			//식별자여부가 Y->N로 변경
			else if(data.idnfItmYn=='N' && rows[0].idnfItmYn=='Y'){
				
				gridSrvcrItm.moveRow(rowKey,gridSrvcrItm.getData().length-1);//맨밑으로
				setSrvCritmOrdAll(gridSrvcrItm.getData());
			}

		}).show();
		//popGrid.refreshLayout(); 
	});
	//서비스기준항목 팝업에 데이터 셋팅
	function setPopSrvcrItmMod_SrvcrItmData(data){
		
		$('#popSrvcrItmMod_IdnfItmYn').val(data.idnfItmYn);
		$('#popSrvcrItmMod_UseBgngYmd').val(data.useBgngYmd);
		$('#popSrvcrItmMod_UseEndYmd').val(data.useEndYmd);
	}
	//서비스기준 이력 조회
	$('#btnSearchSrvcrHist').on('click',function(){
		
		var data = gridSrvcr.getCheckedRows();
		if(data.length==0){
			alert('기준 데이터를 선택하세요');
			return false;
		}

		$.ajax({
			url :"<c:url value='/cmm/openSCR004P.do'/>"
	        ,type: "POST"
	        ,data : {'srvcrId':data[0].srvcrId}//parameter
	        ,dataType: 'html'
		    ,async:false  	   
	        ,success : function(html){
	        	$('#popSrvcrHist').html(html);
	        	$('.container').addClass('overlay');
	    		$('#popSrvcrHist').show();
	    		//popGridSrvcrHist.refreshLayout(); 
			}
		});
	});
	$('#btnAdd').on('click', function(){
		var dataList = gridSrvcrItm.getData();
		if(dataList.length<1){
			alert('기준 클릭후 가능합니다.');
			return false;
		}
		gridSrvcrItm.appendRow();
		/*
		$('.container').addClass('overlay');
		$('#pop').data('callback',function(data){
			
			var rows  = gridSrvcrItm.findRows({critmId : data.critmId});
			if(rows.length>=1){
				alert(data.critmNm+'은(는) 이미 존재하는 항목입니다.');
				return false;
			}
			
			
			data.srvcrId = dataList[0].srvcrId;
			if(data.idnfItmYn=='Y'){
				gridSrvcrItm.appendRow(data);
				
				var rownum = gridSrvcrItm.findRows({critmId:'ST00002'})[0]._attributes.rowNum-1;//유효시작일자의 순서
				var rowKey = gridSrvcrItm.findRows({critmId:data.critmId})[0].rowKey;//추가한 데이터의 rowKey
				
				gridSrvcrItm.moveRow(rowKey,rownum);//유효실자 위로
				setSrvCritmOrdAll(gridSrvcrItm.getData());
			}else{
				gridSrvcrItm.appendRow(data);
			}
			
		}).show();
		popGrid.refreshLayout(); */
	});
	
	
	//서비스기준 항목 삭제
	$('#btnDelete').on('click', function(){
		var data = gridSrvcrItm.getCheckedRows();
		if(data.length==0){
			alert('삭제할 데이터를 선택하세요');
			return false;
		}
		if(confirm('기준항목 및 데이터도 삭제됩니다. 삭제하시겠습니까?')){
			//실제 개발시에는 데이터 삭제후 재조회
			gridSrvcrItm.removeCheckedRows();
			//alert('ajax data 삭제 호출해야함.');
			//1.식별자이면 데이터가 있을경우 삭제하면 안되고.
			//2. 일반속성이면 데이터까지 전부 삭제해야하고.
			
		}
	});
	//서비스기준항목 click
	gridSrvcrItm.on('click', function(ev){
		if(ev.targetType!='cell'){
			return false;
		}
		var data = gridSrvcrItm.getRow(ev.rowKey);
		
		//이미 값이 있는것은 변경button을 통해서
		if(data.critmId!=null){
			return false;
		}
		//ajax scr005p호출
		$.ajax({
			url :"<c:url value='/cmm/openSCR005P.do'/>"
	        ,type: "POST"
	        ,data : {'srvcrId':data.srvcrId, 'critmId':data.critmId}//parameter
	        ,dataType: 'html'
		    ,async:false  	   
	        ,success : function(html){
	        	$('#pop').html(html);
			}
		});
		$('#pop').data('data', data);
		$('#pop').data('callback',function(data){
			var rows  = gridSrvcrItm.findRows({critmId : data.critmId});
			if(rows.length>=1){
				alert(data.critmNm+'은(는) 이미 존재하는 항목입니다.');
				return false;
			}
			var dataList = gridSrvcrItm.getData();
			data.srvcrId = dataList[0].srvcrId;
			/*
			gridSrvcrItm.setValue(ev.rowKey, 'srvcrId', data.srvcrId);
			gridSrvcrItm.setValue(ev.rowKey, 'critmId', data.critmId);
			gridSrvcrItm.setValue(ev.rowKey, 'critmNm', data.critmNm);
			gridSrvcrItm.setValue(ev.rowKey, 'critmPhyNm', data.critmPhyNm);
			gridSrvcrItm.setValue(ev.rowKey, 'idnfItmYn', data.idnfItmYn);
			gridSrvcrItm.setValue(ev.rowKey, 'useBgngYmd', data.useBgngYmd);
			gridSrvcrItm.setValue(ev.rowKey, 'useEndYmd', data.useEndYmd);
			*/
			gridSrvcrItm.setRow(ev.rowKey, data); 
			//식별자이면
			if(data.idnfItmYn=='Y'){
				//gridSrvcrItm.appendRow(data);
				
				var rownum = gridSrvcrItm.findRows({critmId:'ST00002'})[0]._attributes.rowNum-1;//유효시작일자의 순서
				var rowKey = gridSrvcrItm.findRows({critmId:data.critmId})[0].rowKey;//추가한 데이터의 rowKey
				
				gridSrvcrItm.moveRow(rowKey,rownum);//유효실자 위로
				
			}else{
				//gridSrvcrItm.appendRow(data);
			}
			//항목 순서 셋팅
			setSrvCritmOrdAll(gridSrvcrItm.getData());
		}).show();
		//popGrid.refreshLayout();
	});
	gridSrvcrItm.on('dragStart',function(ev){
		
		var row = gridSrvcrItm.getRow(ev.rowKey);
		if(row.critmId=='ST00002' || row.critmId=='ST00003' ){//유효시작일시, 유효종료일시에 해당하는 ID
			ev.stop();
		}
		
	});
	gridSrvcrItm.on('drop',function(ev){
		
		var dragRow = gridSrvcrItm.getRow(ev.rowKey);

		var rows =  gridSrvcrItm.getData();
				
		var row1  = gridSrvcrItm.findRows({critmId:'ST00002'})[0];//유효종료일시
		var row2  = gridSrvcrItm.findRows({critmId:'ST00003'})[0];//유효시작일시
		ev.stop();
		//유효종료일시와 유효시작일시 사이에 못들어가도록 함
		if(row2._attributes.rowNum>dragRow._attributes.rowNum && row1._attributes.rowNum<dragRow._attributes.rowNum){
			
			
			gridSrvcrItm.moveRow(row2.rowKey,dragRow._attributes.rowNum-1);//유효시작일시 뒤로
			gridSrvcrItm.setValue(dragRow.rowKey,'idnfItmYn','N');//식별항목여부 ='N'
		}else if(row2._attributes.rowNum>dragRow._attributes.rowNum){
			gridSrvcrItm.setValue(dragRow.rowKey,'idnfItmYn','Y');//식별항목여부 ='Y'
		}else{
			gridSrvcrItm.setValue(dragRow.rowKey,'idnfItmYn','N');//식별항목여부 ='N'
		}

		
		//전체 순위 재설정
		setSrvCritmOrdAll(rows);
		//식별항목여부 체크해야하고.
		//유효종료/시작일시 사이로 들어가면 안되고
	});
	gridSrvcrItm.on('check',function(ev){
		var rowkey = ev.rowKey;
		var rows = gridSrvcrItm.getCheckedRows();
		//한개만 체크되도록
		$.each(rows, function(index, row){
			if(rowkey!=row.rowKey){
				gridSrvcrItm.uncheck(row.rowKey);
			}
		});
	});
	
	/*전체항목 순서값 셋팅*/
	function setSrvCritmOrdAll(rows){
		$.each(rows, function(index, row){
			gridSrvcrItm.setValue(row.rowKey,'srvCritmOrd',row._attributes.rowNum)
		});
	}
	/*저장버튼 클릭시*/
	$('#btnSaveSrvcrItmDtls').on('click',function(){
		
		//gridSrvcr.finishEditing();
		//gridSrvcrItm.finishEditing();
		if(gridSrvcrItm.isModified()==false){
			alert('수정된 데이터가 없습니다.');
			return;
		}
		var srvcrId = gridSrvcrItm.getRowAt(0).srvcrId;
		var modifiedSrvcrItmData = gridSrvcrItm.dataManager.getAllModifiedData();
		console.log(modifiedSrvcrItmData);
		var errors = gridSrvcrItm.validate();
		if(validSrvcrItm()==false){
			
			return false;
		}

		var createdRows=[] ;
		var updatedRows=[];
		var deletedRows=[];
		$(modifiedSrvcrItmData.createdRows).each(function(){
			var row = this;
			delete row['_attributes'];
			createdRows.push(row);
		});
		$(modifiedSrvcrItmData.updatedRows).each(function(){
			var row = this;
			delete row['_attributes'];
			updatedRows.push(row);
		});
		$(modifiedSrvcrItmData.deletedRows).each(function(){
			var row = this;
			delete row['_attributes'];
			deletedRows.push(row);
		});
		
		var param = {'createdRows':createdRows,
					'updatedRows':updatedRows,
					'deletedRows':deletedRows,
					'srvcrId':srvcrId
				};
		$.ajax({
			 url :"<c:url value='/srvcr/saveSrvcrItmDtls.ajax'/>"
	        ,type: "POST"
		    ,contentType:'application/json; charset=UTF-8'
	        ,data :JSON.stringify(param) 
	        ,dataType: 'json'  	   
	        ,success : function(data){
		        //데이터는 눈에보이는것으로 재셋팅--저장버튼 클릭시 또 저장되므로
		        if(data.isSuccess=="Y"){
		        	selectGridSrvcrItmData(srvcrId);
					alert('저장하였습니다.');
			    }else{
					alert(data.errorMessage);
				}
			}
		});
	});
	/*서비스기준항목 유효성 검증 */
	function validSrvcrItm(modifiedData){
		
		var errorInfo = gridSrvcrItm.validate();
		//에러가 없으면
		if(errorInfo.length==0){
			return true;
		}
		
		var rowKey = errorInfo[0].rowKey;
		var colNm = errorInfo[0].errors[0].columnName;
		var errorCode = errorInfo[0].errors[0].errorCode[0];
		var header = gridSrvcr.getColumns().filter(col=>col.name==colNm)[0].header;
		if(errorCode =='VALIDATOR_FN'){
			errorCode = errorInfo[0].errors[0].errorInfo[0].customErrorCode;
		}

		var errorMessage = getErrorMessage(errorCode, header);
		alert(errorMessage);
		gridSrvcr.startEditing(rowKey,colNm);
		return false;

	}
	
});//end of ready

</script>
