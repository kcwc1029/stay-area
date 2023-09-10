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
		<h3 class="mt-4">物資撥出管理</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">物資撥出管理</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						物資撥出管理
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">撥出日期區間</label>
								<div class="input-group">
									<input type="text" class="form-control datepicker1" id="BKA002009" name="BKA002009" value="" placeholder="例如：2023/09/07">
									<span class="input-group-text" id="input-group-left-example">-</span>
									<input type="text" class="form-control datepicker" id="BKA002010" name="BKA002010" value="" placeholder="例如：2023/09/08">
								</div>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">撥出行政區</label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇行政區</option>
								  <option value="">三民區</option>
								  <option value="">左營區</option>
								</select>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">撥出單位</label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇衛生所</option>
								  <option value="">2302020017-高雄市鼓山區衛生所</option>
								  <option value="">0102020011-高雄市立聯合醫院</option>
								</select>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">品項大類</label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇類別</option>
								  <option value="">宣導品</option>
								  <option value="">衛教品</option>
								</select>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">品項小類</label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇類別</option>
								  <option value="">酒精</option>
								  <option value="">原子筆</option>
								  <option value="">鉛筆</option>
								</select>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">品項名稱</label>
								<div class="input-group">
								<input type="text" class="form-control" id="BKA002003" name="BKA002003" value="" placeholder="例如:酒精噴瓶">
								<button type="button" class="btn btn-green border-secondary" onClick="SF01('','_self')"><i class="fas fa-search me-2"></i>查詢</button>
								</div>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-xl-12 mt-3" align="right">
								<button type="button" class="btn btn-light border-secondary" onClick="SF01('BKB060301','_self')"><i class="fas fa-plus me-2"></i>新增入庫</button>
							</div>
						</div>
						
						<div class="table-responsive mt-1">
							<table class="table table-striped table-bordered">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">撥出日期</th>
								  <th scope="col">撥出行政區</th>
								  <th scope="col">撥出單位</th>
								  <th scope="col">品項大類-小類</th>
								  <th scope="col">品項名稱</th>
								  <th scope="col">撥出數量</th>
								  <th scope="col">庫存數量</th>
								  <th scope="col">修改</th>
								  <th scope="col">刪除</th>
								</tr>
							  </thead>
							  <tbody align="center">
								<tr>
								  <td class="fw-bold">2023/09/07</td>
								  <td>三民區</td>
								  <td>三民衛生所</td>
								  <td>宣導品-酒精</td>
								  <td>酒精噴瓶</td>
								  <td class="text-green fw-bold">20瓶</td>
								  <td class="text-danger fw-bold">40瓶</td>
								  <td><button type="button" class="btn btn-warning btn-sm" onclick="SF02('BKB060301','_self','')"><i class="fas fa-pen"></i></button></td>
								  <td><button type="button" class="btn btn-danger btn-sm" onclick="SF03('','_self','')"><i class="fas fa-minus"></i></button></td>
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
function SF02(A, B, C){
  form1.BKA002001.value = C;
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}


</script>

</body>
</html>
