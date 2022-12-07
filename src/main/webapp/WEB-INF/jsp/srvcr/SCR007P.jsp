<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="popup-wrap">
	<div class="popup-head">
		<div class="head-txt">서비스 기준 내용 등록 팝업</div>
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
							<div class="con-box" style="display:block" id="textBox">
								<div class="ibox">
									<input type="text" placeholder="" id="txtCritmVal" name="critmVal">
								</div>
							</div>
							<div class="con-box" style="display:none" id="selectBox" >
								<div class="sbox">
									<select id="selectCritmVal" name="critmVal">
										
									</select>
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
			<a href="#none" class="btn type-1" id="btnPopAply">적용</a>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	
	$('#btnPopAply').on('click', function(){
		var obj = $('.con-box:visible [name=critmVal]')[0];
		
		var val = $(obj).val();
		//연월일(달력)이면 '-' 제거해서 return;
		if($(obj).hasClass('date-picker')==true){
			val = val.replaceAll('-','');
		}
		$('.con-box:visible [name=critmVal]')[0].value = "";//초기화
		$('.container').removeClass('overlay');
		$('#popupRegCritmVal').hide();
		$('#popupRegCritmVal').data('callback')(val);
	});
	function init(){
		var cdvlTnm = '<c:out value="${cdvlTnm}"/>';//코드값유형명
		var dmnLgcNm = '<c:out value="${dmnLgcNm}"/>';
		var dmnPhyNm = '<c:out value="${dmnPhyNm}"/>';
		if(cdvlTnm==''){
			$('#textBox').show();
			$('#selectBox').hide();
			if(dmnLgcNm=='연월일C8'){
				$('#txtCritmVal').mask('0000-00-00');
				$('#txtCritmVal').addClass('date-picker');
				datePicker();//달력 셋팅
				// 아래 부분 원래 위치 및 로직오류여서 수정함
			}else if(dmnLgcNm=='여부C1' || dmnLgcNm=='유무C1'){
				$('#textBox').hide();
				$('#selectBox').show();
				$('#selectCritmVal').empty();
				$('#selectCritmVal').append('<option value="Y">Y</option>');
				$('#selectCritmVal').append('<option value="N">N</option>');
				console.log('여부/유무');
			}			
		}else if(cdvlTnm=='단순코드'){
			$('#textBox').hide();
			$('#selectBox').show();
			//ajax로 공통코드 조회
			$('#selectCritmVal').empty();
			setSelectComponent('selectCritmVal',dmnPhyNm, '');
			
			
		}else if(cdvlTnm=='목록코드'){
			$('#textBox').show();
			$('#selectBox').hide();
			alert('목록코드는 화면으로.....메인화면에서 분리해야겠다.');
		}
	}
	init();
	
});
	
</script>		