<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="zh">
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>
<body class="sb-nav-fixed">
<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="form1" name="form1" method="post" action="">
<input name="TUA001002" type="hidden" id="TUA001002" value="" />
<input name="PNO01" type="hidden" id="PNO01" value="" />
	<div class="container px-4">
		<h3 class="mt-4">施打站維護</h3>
		<div class="d-flex justify-content-between">
		  <div>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
				<li class="breadcrumb-item" aria-current="page">施打站管理</li>
				<li class="breadcrumb-item active" aria-current="page">施打站維護</li>
			</ol>
		  </div>
		  <div>
			<button type="button" class="btn btn-sm btn-outline-dark" onClick="javascript:document.location.href='BKB010100.jsp'"><i class="fas fa-reply me-2"></i>回查詢頁</button>
		  </div>
		</div>	
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-pen me-1"></i>
						施打站維護
					</div>
					<div class="card-body">
						<p class="h5 mt-3 text-danger fw-bold">施打站資訊</h5>
						<div class="row">
							<div class="col-xl-4 mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">醫療院所<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="TUA001001" name="TUA001001">
								  <option value="">請選擇</option>
								  <option value="1">One</option>
								  <option value="2">Two</option>
								  <option value="3">Three</option>
								</select>
							</div>
							<div class="col-xl-4 mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">施打站名稱<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="TUA001001" name="TUA001001" maxlength="30" placeholder="例：民生醫院A站">
							</div>
						</div>
						<div class="row">
							<div class="col-xl mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">聯絡電話<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="TUA001001" name="TUA001001" maxlength="10" placeholder="例：079538758">
							</div>
							<div class="col-xl mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">行政區<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="TUA001001" name="TUA001001">
								  <option value="">請選擇</option>
								  <option value="1">One</option>
								  <option value="2">Two</option>
								  <option value="3">Three</option>
								</select>
							</div>
							<div class="col-xl mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">地址<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="TUA001001" name="TUA001001" maxlength="100" placeholder="例：凱旋二路132-1號">
							</div>
						</div>
						<div class="row">
							<div class="col-xl-12 mt-2">
								<div class="form-floating">
								  <textarea class="form-control" placeholder="Leave a comment here" id="TUA001029" name="TUA001029" maxlength="200" style="height: 100px"></textarea>
								  <label for="floatingTextarea">備註</label>
								</div>
							</div>
						</div>
						<p class="h5 mt-3 text-danger fw-bold">施打時段</h5>
						<div class="row">
							<div class="col-xl-6 mt-2">
								<label for="DHA005002" class="form-label text-deepgreen fw-bold">上午時段<span class="text-danger ms-1">*</span></label>
								<input type="hidden" class="form-control validate[required]" id="DHA005002" name="DHA005002" value="09:00-11:30" placeholder="EX：09:00-11:30">
								<div class="input-group">
									<select class="form-select" name="DHA005002S1" id="DHA005002S1">
										<option value="08">08</option>
										<option value="09" selected>09</option>
										<option value="10">10</option>
										<option value="11">11</option>
									</select>
									<span class="input-group-text">:</span>
									<select class="form-select" name="DHA005002S2" id="DHA005002S2">
										<option value="00" selected>00</option>
										<option value="30" >30</option>
									</select>
									<span class="input-group-text">-</span>
									<select class="form-select" name="DHA005002E1" id="DHA005002E1">
										<option value="08" >08</option>
										<option value="09" >09</option>
										<option value="10" >10</option>
										<option value="11" selected>11</option>
									</select>
									<span class="input-group-text">:</span>
									<select class="form-select" name="DHA005002E2" id="DHA005002E2">
										<option value="00" >00</option>
										<option value="30" selected>30</option>
									</select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xl-6 mt-2">
								<label for="DHA005002" class="form-label text-deepgreen fw-bold">下午時段<span class="text-danger ms-1">*</span></label>
								<input type="hidden" class="form-control validate[required]" id="DHA005002" name="DHA005002" value="09:00-11:30" placeholder="EX：09:00-11:30">
								<div class="input-group">
									<select class="form-select" name="DHA005002S1" id="DHA005002S1">
										<option value="08">08</option>
										<option value="09" selected>09</option>
										<option value="10">10</option>
										<option value="11">11</option>
									</select>
									<span class="input-group-text">:</span>
									<select class="form-select" name="DHA005002S2" id="DHA005002S2">
										<option value="00" selected>00</option>
										<option value="30" >30</option>
									</select>
									<span class="input-group-text">-</span>
									<select class="form-select" name="DHA005002E1" id="DHA005002E1">
										<option value="08" >08</option>
										<option value="09" >09</option>
										<option value="10" >10</option>
										<option value="11" selected>11</option>
									</select>
									<span class="input-group-text">:</span>
									<select class="form-select" name="DHA005002E2" id="DHA005002E2">
										<option value="00" >00</option>
										<option value="30" selected>30</option>
									</select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xl-6 mt-2">
								<label for="DHA005002" class="form-label text-deepgreen fw-bold">晚上時段<span class="text-danger ms-1">*</span></label>
								<input type="hidden" class="form-control validate[required]" id="DHA005002" name="DHA005002" value="09:00-11:30" placeholder="EX：09:00-11:30">
								<div class="input-group">
									<select class="form-select" name="DHA005002S1" id="DHA005002S1">
										<option value="08">08</option>
										<option value="09" selected>09</option>
										<option value="10">10</option>
										<option value="11">11</option>
									</select>
									<span class="input-group-text">:</span>
									<select class="form-select" name="DHA005002S2" id="DHA005002S2">
										<option value="00" selected>00</option>
										<option value="30" >30</option>
									</select>
									<span class="input-group-text">-</span>
									<select class="form-select" name="DHA005002E1" id="DHA005002E1">
										<option value="08" >08</option>
										<option value="09" >09</option>
										<option value="10" >10</option>
										<option value="11" selected>11</option>
									</select>
									<span class="input-group-text">:</span>
									<select class="form-select" name="DHA005002E2" id="DHA005002E2">
										<option value="00" >00</option>
										<option value="30" selected>30</option>
									</select>
								</div>
							</div>
						</div>
						<div class="row mb-2 mt-3">
							<div class="col-lg" align="center">
							  <button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB010102','_self')"><i class="fa fa-plus me-1"></i>儲存</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
</form>
	<!-- indexJS -->
	<%@ include file="indexJS.jsp"%>
	
<script type="text/javascript">
function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  $("#form1").submit();
}

function SF02(A, B, C){
  form1.TUA001002.value = C;
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}
function PG01(A,B){
	form1.PNO01.value=A;
	form1.target="_self";
	form1.action=B;
	form1.submit();
}
</script>

</body>
</html>
