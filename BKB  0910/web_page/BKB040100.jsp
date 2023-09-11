<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>


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
		<h3 class="mt-4">報表匯出</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">報表匯出</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						場次維護
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl">
								<div class="input-group">
								  <div class="input-group-text">
									請選擇匯出報表
								  </div>
									<select class="form-select" onchange="SF01(value ,'content')">
									  <option selected>請選擇報表</option>
									  <option value="BKB040101">疫苗填報數量</option>
									  <option value="BKB040102">疫苗預約名單</option>
									</select>
								</div>
								<iframe name="content" id="content" onload="javascript:{dyniframesize('content');}" src="" width="100%" scrolling="no" style="border:none;"></iframe>
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
  form1.submit();
}
</script>

</body>
</html>
