<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
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

<body>
<form id="form1" name="form1" method="post" action="">
<!-- indexS -->
    <%@ include file="indexS.jsp"%>
			<div class="container">
			  <div class="row mt-5">
				<div class="col-lg-3"></div>
				<div class="col-lg-6">
					<div class="card">
					  <div class="card-header bg-green text-white" align="center">
						<h4>登入成功</h4>
					  </div>
					  <div class="card-body" class="align-items-center">
						
						<div class="row mt-3">
							<div class="col-lg-12" align="center">
								<h4><%=URA001011N+USERNAME%>您好</h4>
							</div>
						</div>
						
						<div class="row mt-3">
							<div class="col-lg-12" align="center">
								<button type="button" class="btn btn-outline-green" onclick="SF01('logout','_self')">登出</button>
							</div>
						</div>
					  </div>
					</div>
				</div>
				<div class="col-lg-3"></div>
			  </div>
			</div>
<!-- indexF -->
<%@ include file="indexF.jsp"%>

</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>

<script type="text/javascript">
$(function () {
	$('#myTab li:eq(1) a').tab('show');
});

function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}

</script>
</body>
</html>