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
		<h3 class="mt-4">醫療院所發放數量管理</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">醫療院所發放數量管理</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						發放數量維護管理
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">發放日期區間</label>
								<div class="input-group">
									<input type="text" class="form-control datepicker1" id="BKA002009" name="BKA002009" value="" placeholder="例如：1111114">
									<span class="input-group-text" id="input-group-left-example">-</span>
									<input type="text" class="form-control datepicker" id="BKA002010" name="BKA002010" value="" placeholder="例如：1111120">
								</div>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">行政區</label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇行政區</option>
								  <option value="">三民區</option>
								  <option value="">左營區</option>
								</select>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">醫療院所</label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇醫療院所</option>
								  <option value="">三民區</option>
								  <option value="">左營區</option>
								</select>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">品項類別</label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇類別</option>
								  <option value="">宣導品</option>
								  <option value="">衛教品</option>
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
								<button type="button" class="btn btn-light border-secondary" onClick="SF01('BKB060501','_self')"><i class="fas fa-plus me-2"></i>新增發放</button>
							</div>
						</div>
						
						<div class="table-responsive mt-1">
							<table class="table table-striped table-bordered">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">行政區</th>
								  <th scope="col">合約醫療所代碼(10碼)</th>
								  <th scope="col">醫療院所</th>
								  <th scope="col">品項類別</th>
								  <th scope="col">品項名稱</th>
								  <th scope="col">品項數量</th>
								  <th scope="col">單位</th>
								  <th scope="col">發放日期</th>
								  <th scope="col">修改</th>
								  <th scope="col">刪除</th>
								</tr>
							  </thead>
							  <tbody align="center">
								<tr>
								  <td>三民區</td>
								  <td>3351234567</td>
								  <td>兒科診所</td>
								  <td>宣導品</td>
								  <td>酒精噴瓶</td>
								  <td>10</td>
								  <td>瓶</td>
								  <td>1120910</td>
								  <td><button type="button" class="btn btn-warning btn-sm" onclick="SF02('BKB060501','_self','')"><i class="fas fa-pen"></i></button></td>
								  <td><button type="button" class="btn btn-danger btn-sm" onclick="SF03('','_self','')"><i class="fas fa-minus"></i></button></td>
								</tr>
								<tr>
								  <td>三民區</td>
								  <td>1502050045</td>
								  <td>德謙醫院</td>
								  <td>宣導品</td>
								  <td>酒精噴瓶</td>
								  <td>5</td>
								  <td>瓶</td>
								  <td>1120910</td>
								  <td><button type="button" class="btn btn-warning btn-sm" onclick="SF02('BKB060501','_self','')"><i class="fas fa-pen"></i></button></td>
								  <td><button type="button" class="btn btn-danger btn-sm" onclick="SF03('','_self','')"><i class="fas fa-minus"></i></button></td>
								</tr>
								<tr>
								  <td>三民區</td>
								  <td>1502050045</td>
								  <td>南山醫院</td>
								  <td>宣導品</td>
								  <td>酒精噴瓶</td>
								  <td>8</td>
								  <td>瓶</td>
								  <td>1120910</td>
								  <td><button type="button" class="btn btn-warning btn-sm" onclick="SF02('BKB060501','_self','')"><i class="fas fa-pen"></i></button></td>
								  <td><button type="button" class="btn btn-danger btn-sm" onclick="SF03('','_self','')"><i class="fas fa-minus"></i></button></td>
								</tr>
								<tr>
								  <td>三民區</td>
								  <td>1502050045</td>
								  <td>祐生醫院</td>
								  <td>宣導品</td>
								  <td>酒精噴瓶</td>
								  <td>10</td>
								  <td>瓶</td>
								  <td>1120910</td>
								  <td><button type="button" class="btn btn-warning btn-sm" onclick="SF02('BKB060501','_self','')"><i class="fas fa-pen"></i></button></td>
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
