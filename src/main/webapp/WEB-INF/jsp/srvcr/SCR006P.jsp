<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="popup-wrap" >

	<div class="popup-head">

		<div class="head-txt">표준 서비스기준 항목 수정 팝업</div>

		<a href="#none" class="popup-close-btn" onclick="popupCloseDirect(this)"></a>
	</div>

	<div class="popup-body">
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
									<select id="popSrvcrItmMod_IdnfItmYn">
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
									<input type="text" id="popSrvcrItmMod_UseBgngYmd" value="" class="date-picker"  data-position='top left' >
								</div>
							</td>
						</tr>
						<tr>
							<th><div class="subject-box ess">사용종료일자</div></th>
							<td class="left">
								<div class="ibox">
									<input type="text" id="popSrvcrItmMod_UseEndYmd"  value="9999-12-31" class="date-picker" data-position='top left' >
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
			<a href="#none" class="btn type-1" id="popSrvcrItmMod_BtnAply">적용</a>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	datePicker();
	$('#popSrvcrItmMod_BtnAply').on('click', function(){
		var data = {
			'idnfItmYn':$('#popSrvcrItmMod_IdnfItmYn').val(),
			'useBgngYmd':$('#popSrvcrItmMod_UseBgngYmd').val(),
			'useEndYmd':$('#popSrvcrItmMod_UseEndYmd').val()
		}
		$('.container').removeClass('overlay');
		$('#popSrvcrItmMod').hide();
		$('#popSrvcrItmMod').data('callback')(data);
	});
});
	
</script>		