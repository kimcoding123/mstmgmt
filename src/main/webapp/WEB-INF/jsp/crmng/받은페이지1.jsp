<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
</script>
<%--서비스기준관리 화면--%>
<div class="page-wrap">
	<article class="page-head">
		<div class="head-box inner-width">
			<div class="tit-box">
				<a href="#none" class="like-btn"></a>
				<div class="tit-txt">서비스기준관리</div>
				<div class="sub-txt">01000 (SCROO1M)</div>
			</div>
		</div>
	</article>
	<article class="search-form">
		<div class="wrap box-style inner-width">
			<div class="form-group">
				<div class="row">
					<div class="item-box type-3">
						<div class="subject-box ess"><span class="txt">업무구분</span></div>
						<div class="con-box">
							<div class="ibox">
								<input type="text" placeholder="이름을 입력하세요.">
							</div>
						</div>
					</div>
					<div class="item-box type-3">

						<div class="subject-box"><span class="txt">업무구분</span></div>
						<div class="con-box">
							<div class="ibox">
								<input type="text" placeholder="이름을 입력하세요.">
							</div>
						</div>
					</div>
					<div class="item-box type-3">
						<div class="subject-box"><span class="txt">업무구분</span></div>
						<div class="con-box">
							<div class="sbox">
								<select>
									<option>소득재산</option>
									<option>소득재산</option>
									<option>소득재산</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="item-box type-4">
						<div class="subject-box"><span class="txt">업무구분</span></div>
						<div class="con-box">
							<div class="ibox">
								<input type="text" placeholder="이름을 입력하세요.">
							</div>
						</div>
					</div>
					<div class="item-box type-4">
						<div class="subject-box ess"><span class="txt">업무구분</span></div>
						<div class="con-box">
							<div class="ibox">
								<input type="text" placeholder="이름을 입력하세요.">
							</div>
						</div>
					</div>
					<div class="item-box type-4">
						<div class="subject-box"><span class="txt">업무구분</span></div>
						<div class="con-box">
							<div class="sbox">
								<select>
									<option>소득재산</option>
									<option>소득재산</option>
									<option>소득재산</option>
								</select>
							</div>
						</div>
					</div>
					<div class="item-box type-4">

						<div class="subject-box"><span class="txt">업무구분</span></div>
						<div class="con-box">
							<div class="sbox">
								<select>
									<option>소득재산</option>
									<option>소득재산</option>
									<option>소득재산</option>
								</select>
							</div>
						</div>
					</div>

				</div>

				<div class="row">

					<div class="item-box type-2">

						<div class="subject-box"><span class="txt">종료일자</span></div>
						<div class="con-box">
							<div class="ibox">
								<input type="text" placeholder="2020-01-01" class="date-picker" readonly>
							</div>
						</div>
					</div>

					<div class="item-box type-2">

						<div class="subject-box ess"><span class="txt">시작일자</span></div>
						<div class="con-box">
							<div class="ibox">
								<input type="text" placeholder="2020-01-01" class="date-picker" readonly>
							</div>
						</div>
					</div>


				</div>

				<div class="row">

					<div class="item-box type-1">
						<div class="subject-box"><span class="txt">서비스 설명</span></div>
						<div class="con-box">
							<div class="ibox">
								<input type="text" placeholder="이름을 입력하세요.">
							</div>
						</div>
					</div>



				</div>

			</div>

			<div class="menu-group">

				<a href="#none" class="menu-btn type-2">초기화</a>
				<a href="#none" class="menu-btn">검색</a>

			</div>


		</div>

	</article>


	<article class="table-list">

		<article class="page-head">
			<div class="head-box">
				<div class="tit-box">
					<div class="tit-txt">서비스 기준</div>
				</div>

				<div class="menu-box">
					<a href="#none" class="menu-btn">행 추가</a>
					<a href="#none" class="menu-btn type-2">행 삭제</a>
					<a href="#none" class="menu-btn type-3">엑셀 저장</a>
				</div>
			</div>



		</article>

		<div class="inner-width">
			<article class="list-table">
				<div class="table-box">
					<table>
						<colgroup>
							<col style="width: 10%;">
						</colgroup>
						<thead>
						<tr>
							<th>구분 / 순번</th>
							<th>1</th>
							<th>2</th>
							<th>3</th>
							<th>4</th>
							<th>5</th>
							<th>6</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>물리명</td>
							<td>LINK_ID</td>
							<td>INCPR_VRFC_ITM_NO</td>
							<td>VLD_END_DT</td>
							<td>VLD_BGNG_DT</td>
							<td>VRFC_ITM_NM</td>
							<td>USE_YN</td>
						</tr>
						<tr>
							<td>항목명</td>
							<td>연계ID</td>
							<td>소득재산검증항목번호</td>
							<td>유효종료일시</td>
							<td>유효시작일시</td>
							<td>검증항목명</td>
							<td>사용여부</td>
						</tr>
						<tr>
							<td>식별항목여부</td>
							<td>Y</td>
							<td>Y</td>
							<td>Y</td>
							<td>Y</td>
							<td>N</td>
							<td>N</td>
						</tr>

						<tr>
							<td>사용시작일자</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
						</tr>

						<tr>
							<td>사용종료일자</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
							<td>2021-01-01</td>
						</tr>
						</tbody>
					</table>

				</div>

			</article>
		</div>


	</article>

	<article class="table-list">

		<article class="page-head">
			<div class="head-box">
				<div class="tit-box">
					<div class="tit-txt">서비스기준 내역</div>
					<div class="sub-txt">(총 107건)</div>
				</div>
			</div>
		</article>

		<div class="inner-width">
			<article class="list-table">
				<div class="table-box">
					<table>
						<colgroup>
							<col style="width: 5%;">
						</colgroup>
						<thead>
						<tr>
							<th>번호</th>
							<th>연계ID</th>
							<th>소득재산검증항목번호</th>
							<th>유효종료일시</th>
							<th>검을항목명</th>
							<th>사용여부</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>
								<div class="rbox">
									<label>
										<input type="radio" name="r"><i></i>
									</label>
								</div>
							</td>
							<td>NTS003CU001</td>
							<td>04</td>
							<td>9999-12-31 12:12:12</td>
							<td>1990-01-01 00:00:00</td>
							<td>Y</td>
						</tr>
						<tr>
							<td>
								<div class="rbox">
									<label>
										<input type="radio" name="r"><i></i>
									</label>
								</div>
							</td>
							<td>NTS003CU001</td>
							<td>04</td>
							<td>9999-12-31 12:12:12</td>
							<td>1990-01-01 00:00:00</td>
							<td>Y</td>
						</tr>
						<tr>
							<td>
								<div class="cbox">
									<label>
										<input type="checkbox" name="c"><i></i>
									</label>
								</div>
							</td>
							<td>NTS003CU001</td>
							<td>04</td>
							<td>9999-12-31 12:12:12</td>
							<td>1990-01-01 00:00:00</td>
							<td>Y</td>
						</tr>

						<tr>
							<td>
								<div class="cbox">
									<label>
										<input type="checkbox" name="c"><i></i>
									</label>
								</div>
							</td>
							<td>NTS003CU001</td>
							<td>04</td>
							<td>9999-12-31 12:12:12</td>
							<td>1990-01-01 00:00:00</td>
							<td>Y</td>
						</tr>

						<tr>
							<td>
								<div class="cbox">
									<label>
										<input type="checkbox" name="c"><i></i>
									</label>
								</div>
							</td>
							<td>NTS003CU001</td>
							<td>04</td>
							<td>9999-12-31 12:12:12</td>
							<td>1990-01-01 00:00:00</td>
							<td>N</td>
						</tr>
						</tbody>
					</table>

				</div>

			</article>
		</div>

		<article class="table-bottom-menu">

			<article class="page-selector">


				<div class="sbox small">
					<select>
						<option>20</option>
						<option>50</option>
						<option>100</option>
					</select>
				</div>

			</article>


			<article class="paging">

				<ul>
					<li class="first"><a href="#none" class=""></a></li>
					<li class="prev"><a href="#none" class=""></a></li>
					<li class="num current"><a href="#none" class="">1</a></li>
					<li class="num"><a href="#none" class="">2</a></li>
					<li class="num"><a href="#none" class="">3</a></li>
					<li class="num"><a href="#none" class="">4</a></li>
					<li class="num"><a href="#none" class="">5</a></li>
					<li class="next"><a href="#none" class=""></a></li>
					<li class="last"><a href="#none" class=""></a></li>


				</ul>
			</article>

		</article>


	</article>



</div>