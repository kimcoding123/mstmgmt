<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<div class="popup-wrap">
			<div class="popup-head">
				<div class="head-txt">서비스 기준 등록</div>
				<a href="#none" class="popup-close-btn" onclick="popupCloseDirect(this)"></a>
			</div>
			<div class="popup-body">
				<article class="search-form popup-search-form">
					<div class="wrap box-style inner-width">
						<div class="form-group">
							<div class="row">
								<div class="item-box type-2">
									<div class="subject-box ess"><span class="txt">서비스기준명</span></div>
									<div class="con-box">
										<div class="ibox">
											<input type="text" placeholder="이름을 입력하세요." id="popSrvcrNm">
										</div>
									</div>
								</div>
								<div class="item-box type-2">
									<div class="subject-box ess"><span class="txt">서비스기준설명</span></div>
									<div class="con-box">
										<div class="ibox">
											<input type="text" placeholder="이름을 입력하세요." id="popSrvcrDc">
										</div>
									</div>
								</div>
                                
							</div>
                            <div class="row">
								<div class="item-box type-2">
									<div class="subject-box ess"><span class="txt">서비스기준뷰명</span></div>
									<div class="con-box">
										<div class="ibox">
											<input type="text" placeholder="이름을 입력하세요." id="popSrvcrViewNm">
										</div>
									</div>
								</div>
								<div class="item-box type-2">
									<div class="subject-box ess"><span class="txt">업무구분</span></div>
									<div class="con-box">
										<div class="sbox" >
											<select id='popTaskDivSclsCd'>
												<
											</select>
										</div>
									</div>
								</div>
							</div>
                            <div class="row">
								<div class="item-box type-2">
									<div class="subject-box ess"><span class="txt">사용시작일자</span></div>
									<div class="con-box">
										<div class="ibox">
											<input type="text" placeholder="이름을 입력하세요." class="date-picker" id="popSrvcrUseBgngYmd" >
										</div>
									</div>
								</div>
                                <div class="item-box type-2">
									<div class="subject-box ess"><span class="txt">사용종료일자</span></div>
									<div class="con-box">
										<div class="ibox">
											<input type="text"  placeholder="이름을 입력하세요." class="date-picker" id="popSrvcrUseEndYmd" >
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
					<a href="#none" class="btn type-1" id='btnSrvcrRegAply'>적용</a>
				</div>
			</div>
		</div>
<script>
$(document).ready(function(){
	datePicker();//달력 셋팅
	function initComponent(){
		setSelectComponent('popTaskDivSclsCd','TASK_DIV_SCLS_CD')
	}
	initComponent();
	//팝업 적용버튼 클릭시
	/*서비스기준 등록 팝업 script 시작*/
	$('#btnSrvcrRegAply').on('click',function(){
		
		
		if($('#popSrvcrNm').val()==''){
			var errorMessage = getErrorMessage('REQUIRED', '서비스기준명');
			alert(errorMessage);
			$('#popSrvcrNm').focus();
			return false;
		}
		if($('#popSrvcrDc').val()==''){
			var errorMessage = getErrorMessage('REQUIRED', '서비스기준설명');
			alert(errorMessage);
			$('#popSrvcrDc').focus();
			return false;
		}
		if($('#popSrvcrViewNm').val()==''){
			var errorMessage = getErrorMessage('REQUIRED', '서비스기준뷰명');
			alert(errorMessage);
			$('#popSrvcrViewNm').focus();
			return false;
		}
		if($('#popTaskDivSclsCd').val()==null || $('#popTaskDivSclsCd').val()==''){
			var errorMessage = getErrorMessage('REQUIRED', '업무구분');
			alert(errorMessage);
			$('#popTaskDivSclsCd').focus();
			return false;
		}
		if($('#popSrvcrUseBgngYmd').val()==''){
			var errorMessage = getErrorMessage('REQUIRED', '사용시작일자');
			alert(errorMessage);
			return false;
			$('#popSrvcrUseBgngYmd').focus();
		}
		if($('#popSrvcrUseEndYmd').val()==''){
			var errorMessage = getErrorMessage('REQUIRED', '사용종료일자');
			alert(errorMessage);
			$('#popSrvcrUseEndYmd').focus();
			return false;
		}
		if($('#popSrvcrUseBgngYmd').val()>$('#popSrvcrUseEndYmd').val()){
			alert('사용시작일자는 사용종료일자보다 작을수 없습니다');
			return false;
		}

		$('.container').removeClass('overlay');
		$('#popSrvcrRegPop').hide();
		var retData= {
			srvcrNm : $('#popSrvcrNm').val(),
			srvcrViewNm : $('#popSrvcrViewNm').val(),
			taskDivSclsCd : $('#popTaskDivSclsCd').val(),
			taskDivSclsNm : $('#popTaskDivSclsCd option:selected').text(),
			srvcrDc : $('#popSrvcrDc').val(),
			useBgngYmd : $('#popSrvcrUseBgngYmd').val(),
			useEndYmd : $('#popSrvcrUseEndYmd').val()
		}
		console.log(retData);

		$('#popSrvcrRegPop').data('callback')(retData);
		
	});
});
	
</script>		