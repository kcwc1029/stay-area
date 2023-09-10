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
	<div class="container px-4">
		<h3 class="mt-4">施打站管理</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">施打站管理</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-search me-1"></i>
						施打站資訊
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-xl mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">施打站名稱</label>
								<input type="text" class="form-control" id="TUA001001" name="TUA001001" placeholder="請輸入施打站關鍵字">
							</div>
							<div class="col-xl mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">行政區</label>
								<select class="form-select" aria-label="Default select" id="TUA001001" name="TUA001001">
								  <option value="">請選擇</option>
								  <option value="1">One</option>
								  <option value="2">Two</option>
								  <option value="3">Three</option>
								</select>
							</div>
							<div class="col-xl mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">醫療院所</label>
								<div class="input-group">
									<select class="form-select" aria-label="Default select" id="TUA001001" name="TUA001001">
									  <option value="">請選擇</option>
									  <option value="1">One</option>
									  <option value="2">Two</option>
									  <option value="3">Three</option>
									</select>
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB010100','_self')"><i class="fas fa-search me-1"></i>查詢</button>
								</div>
							</div>
						</div>
						<div class="row mb-2 mt-5">
							<div class="col-lg" align="right">
							  <button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB010101','_self')"><i class="fa fa-plus me-1"></i>新增施打站</button>
							</div>
						</div>
						<div class="table-responsive mt-3">
							<table class="table table-striped table-bordered">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">施打站編號</th>
								  <th scope="col">施打站名稱</th>
								  <th scope="col">地址</th>
								  <th scope="col">醫療院所</th>
								  <th scope="col">修改</th>
								  <th scope="col">刪除</th>
								</tr>
							  </thead>
							  <tbody align="center">
								<tr>
								  <th scope="row">1234567891001</th>
								  <td>民生醫院A站</td>
								  <td>高雄市苓雅區凱旋二路134-10號</td>
								  <td>高雄市立民生醫院</td>
								  <td><button type="button" class="btn btn-success btn-sm" onclick="SF02('BKB010101','_self')"><i class="fas fa-pen"></i></button></td>
								  <td><button type="button" class="btn btn-danger btn-sm" onclick="SF02('#','_self')"><i class="fas fa-minus"></i></button></td>
								</tr>
								<tr>
								  <th scope="row">1234567891002</th>
								  <td>民生醫院B站</td>
								  <td>高雄市苓雅區凱旋二路134-10號</td>
								  <td>高雄市立民生醫院</td>
								  <td><button type="button" class="btn btn-success btn-sm" onclick="SF02('BKB010101','_self')"><i class="fas fa-pen"></i></button></td>
								  <td><button type="button" class="btn btn-danger btn-sm" onclick="SF02('#','_self')"><i class="fas fa-minus"></i></button></td>
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
  form1.action = A + ".jsp";
  form1.submit();
}
</script>

</body>
</html>
