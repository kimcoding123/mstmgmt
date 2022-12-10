<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="popup-wrap">
	<div class="popup-head">
		<div class="head-txt">서비스기준내역 엑셀 업로드(SCR008P)</div>
		<a href="#none" class="popup-close-btn" onclick="popupCloseDirect(this)"></a>
	</div>
	<div class="popup-body">
		<article class="search-form popup-search-form">
			<div class="wrap box-style inner-width">
				<div class="form-group">
					<div class="row">
						<div class="item-box type-1">
							<div class="subject-box " style="width:150px"><span class="txt" id="labelCritmNm"><c:out value="${critmNm}"/></span></div>
							<!-- 실제개발시에는 스크립트릿으로 애초에 한개만 생성되도록 하고 id도 동일하게 함.-->
							<div class="con-box"  id="textBox">
								<div class="ibox">
								  	<form id=fileUploadForm name="fileUploadForm" enctype="multipart/form-data" method="post" accept-charset="utf-8">
										<input type="file" id="fileUpload" name="fileUpload" accept=".xlsx">
										<input type="hidden" name="srvcrId" value='<c:out value="${srvcrId}"/>'/>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</article>
	</div>

	<div class="popup-foot">
		<div class="popup-menu">
			<a href="#none" class="btn type-2" onclick="popupCloseDirect(this)">취소</a>
			<a href="#none" class="btn type-1" id="btnPopAply">업로드</a>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	var srvcrId = '<c:out value="${srvcrId}"/>';
	$('#btnPopAply').on('click',function(){
		var files = $('#fileUpload')[0].files;
		if(files.length == 0){
			alert("파일은 선택해주세요");
		    return;
		}
		/*
		uploadForm.action =  "<c:url value='/srvcr/fileUpload.ajax'/>";
		uploadForm.submit();
		*/
	    var form = $('#fileUploadForm')[0];  	    
	    // Create an FormData object          
	    var data = new FormData(form);

		$.ajax({
			type:"POST",
			url: "<c:url value='/srvcr/uploadSrvcrDtlsExcel.ajax'/>",
			enctype: 'multipart/form-data;charset=UTF-8',
			
			processData: false,
			contentType: false,
			cache: false,      
			data: data,
			success: function(data){

				if(JSON.parse(data).isSuccess=="Y"){
					alert("저장하였습니다.");
				}else{
					alert(JSON.parse(data).errorMessage);
				}
				$('.container').removeClass('overlay');
				$('#popupExcelUpload').hide();
				$('#popupExcelUpload').data('callback')(JSON.parse(data));
			},
			err: function(err){
				alert(err);
			}
		})
		
	});
	function init(){
		//화면컴포넌트제어
		getAcctlCmpntId('${acctlPgmId}');
	}
	init();
	
});
	
</script>		