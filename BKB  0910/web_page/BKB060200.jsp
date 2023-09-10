<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>

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
	<div class="container px-4">
		<h3 class="mt-4">物資撥出匯入</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">物資撥出匯入</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						物資撥出匯入
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl">
								<div class="input-group">
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('','_self')"><i class="fas fa-file-download me-2"></i>範例下載</button>
									<input type="file" accept=".xls,.xlsx" class="form-control" value="" id="customFile" name="customFile">
									<button type="button" class="btn btn-outline-secondary" id="input-group-button-right" onclick="uploadFile()">匯入</button>
								</div>
							</div>
						</div>
						<div class="table-responsive mt-5">
							<table class="table table-striped table-bordered">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">撥出日期</th>
								  <th scope="col">撥出單位十碼章</th>
								  <th scope="col">撥出品項名稱</th>
								  <th scope="col">撥出數量</th>
								</tr>
							  </thead>
							  <tbody align="center">
								<tr>
								  <td class="fw-bold">2023/09/07</td>
								  <td>2302050015</td>
								  <td>酒精噴瓶</td>
								  <td>20</td>
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
</script>

</body>
</html>
