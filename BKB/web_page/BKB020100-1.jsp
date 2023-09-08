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
		<div class="d-flex justify-content-between">
		  <div>
			<h3 class="mt-4">批次匯入接種數量</h3>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item" aria-current="page">選擇匯入場次</li>
			<li class="breadcrumb-item active" aria-current="page">批次匯入接種數量</li>
			</ol>
		  </div>
		  <div class="mt-5">
			<button type="button" class="btn btn-sm btn-light border-secondary" onClick="javascript:document.location.href='BKB020101.jsp'"><i class="fas fa-reply me-2"></i>回上頁</button>
		  </div>
		</div>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold h5">
						<i class="fas fa-file-import me-1"></i>
						匯入場次：第97期場次
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-xl-12 mt-2">
								<label for="formFile" class="form-label text-deepgreen fw-bold">請選擇匯入檔案<span class="text-danger ms-1">*</span></label>
								<div class="input-group">
									<button type="button" class="btn btn-danger border-secondary" onClick="SF02('../web_download/疫苗預約系統2.0範例檔案.xlsx','_new')"><i class="fas fa-arrow-circle-down me-1"></i>下載範例檔案</button>
									<input class="form-control validate[required]" type="file" id="formFile" name="" disabled>
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB020100','_self')"><i class="fa fa-plus me-1"></i>匯入</button>
								</div>
							</div>
						</div>
						<div class="alert alert-secondary fw-bold" role="alert">
						  僅有匯入期間可批次匯入或單筆維護接種資料。<br>
						  <span class="text-danger">匯入時間截止後</span>，僅能針對未到達日期、時段進行<span class="text-danger">預約開關調整。</span>
						</div>
						<div class="row mt-5">
							<div class="col-xl fw-bold" align="left">匯入時間:111/05/29　09:00</div>
							<div class="col-xl" align="right">
								<button type="button" class="btn btn-primary border-secondary" onClick="SF01('#','_self')">儲存開放預約調整</button>
							</div>
						</div>
						<div class="table-responsive mt-1">
							<table class="table table-bordered table-hover">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">接種院所</th>
								  <th scope="col">接種日期</th>
								  <th scope="col">接種時段</th>
								  <th scope="col">疫苗類別</th>
								  <th scope="col">組別</th>
								  <th scope="col">數量</th>
								  <th scope="col">修改</th>
								  <th scope="col">刪除</th>
								  <th scope="col" width="8%">開放預約
									<div class="form-check form-switch">
									  <input class="form-check-input" type="checkbox" id="formSwitchCheckChecked" checked="" disabled>
									</div>
								  </th>
								</tr>
							  </thead>
							  <tbody align="center">
								<tr>
								  <th scope="row">民生醫院</th>
								  <td>111/06/01</td>
								  <td>08:00-11:00</td>
								  <td>BNT</td>
								  <td>6個月到4歲</td>
								  <td>10</td>
								  <td></td>
								  <td></td>
								  <td>
									<div class="form-check form-switch" align="center">
									  <input class="form-check-input" type="checkbox" id="formSwitchCheckChecked" checked="" disabled>
									</div>
								  </td>
								</tr>
								<tr>
								  <th scope="row">民生醫院</th>
								  <td>111/06/01</td>
								  <td>08:00-11:00</td>
								  <td>BNT</td>
								  <td>12歲以上</td>
								  <td>10</td>
								  <td></td>
								  <td></td>
								  <td>
									<div class="form-check form-switch" align="center">
									  <input class="form-check-input" type="checkbox" id="formSwitchCheckChecked" checked="" disabled>
									</div>
								  </td>
								</tr>
								<tr>
								  <th scope="row">民生醫院</th>
								  <td>111/06/01</td>
								  <td>08:00-11:00</td>
								  <td>莫德納次世代雙價(BA.1)</td>
								  <td>18歲以上</td>
								  <td>10</td>
								  <td></td>
								  <td></td>
								  <td>
									<div class="form-check form-switch" align="center">
									  <input class="form-check-input" type="checkbox" id="formSwitchCheckChecked" checked="" disabled>
									</div>
								  </td>
								</tr>
								<tr>
								  <th scope="row">民生醫院</th>
								  <td>111/06/01</td>
								  <td>08:00-11:00</td>
								  <td>莫德納次世代雙價(BA.4/5)</td>
								  <td>18歲以上</td>
								  <td>10</td>
								  <td></td>
								  <td></td>
								  <td>
									<div class="form-check form-switch" align="center">
									  <input class="form-check-input" type="checkbox" id="formSwitchCheckChecked" disabled>
									</div>
								  </td>
								</tr>
							  </tbody>
							</table>
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
  form1.submit();
}

function SF02(A, B){
  form1.target = B;
  form1.action = A;
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
