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
<%
//取得日期
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
%>
<%
String BKA004001 = URA001011C;  //操作人的十碼章
String BKA004002 = "";
String BKA004003 = "";
String BKA004004 = "";
String BKA004005 = "";
String BKA004901 = USERID;
String BKA004902 = SC01;
String BKA004903 = USERID;
String BKA004904 = SC01;
String BKA004905 = "";
String FTYPE = "A"; //這裡的A是新增的代號
SQL01 = "SELECT * FROM BKA004 WHERE BKA004001 = '"+BKA004001+"'";
RS01 = TAB01.buildMaps(SQL01);
//out.print(SQL01);  //印出訊息
if(RS01.length==1){
	BKA004002 = RS01[0].get("BKA004002").toString();
	BKA004003 = RS01[0].get("BKA004003").toString();
	BKA004004 = RS01[0].get("BKA004004").toString();
	BKA004005 = RS01[0].get("BKA004005").toString();
	BKA004901 = RS01[0].get("BKA004901").toString();
	BKA004902 = RS01[0].get("BKA004902").toString();
	BKA004903 = USERID;
	BKA004904 = SC01;
	BKA004905 = RS01[0].get("BKA004905").toString();
	FTYPE = "U"; //這裡的U是修改的代號
}
%>
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
<input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" />
<input type="hidden" name="SENDURL" value="BKB020300" >
<input name="BKA004001" type="hidden" id="BKA004001" value="<%=BKA004001%>" />
<input name="BKA004901" type="hidden" id="BKA004901" value="<%=BKA004901%>" />
<input name="BKA004902" type="hidden" id="BKA004902" value="<%=BKA004902%>" />
<input name="BKA004903" type="hidden" id="BKA004903" value="<%=BKA004903%>" />
<input name="BKA004904" type="hidden" id="BKA004904" value="<%=BKA004904%>" />
<input name="BKA004905" type="hidden" id="BKA004905" value="<%=BKA004905%>" />

	<div class="container px-4">
		<div class="d-flex justify-content-between">
		  <div>
			<h3 class="mt-4">預約方式維護</h3>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item" aria-current="page">量能管理</li>
			<li class="breadcrumb-item active" aria-current="page">預約方式維護</li>
			</ol>
		  </div>
		</div>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold h5">
						<i class="fas fa-file-import me-1"></i>
						預約方式維護
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-xl-12 mt-2">
								<label for="formFile" class="form-label text-deepgreen fw-bold">本場次提供預約方式<span class="text-danger ms-1">*</span></label>
							</div>
							<div class="col-xl-12 mt-2">
								<div class="form-check form-check-inline">
								  <input class="form-check-input validate[required,groupRequired[grp]]" type="checkbox" id="BKA00402" name="BKA004" value="1" <%=BKA004002.equals("1")?"checked":""%>>
								  <input type="hidden" id="BKA004002" name ="BKA004002" value="<%=BKA004002%>">
								  <label class="form-check-label" for="BKA00402">網路</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input validate[required,groupRequired[grp]]" type="checkbox" id="BKA00403" name="BKA004" value="1" <%=BKA004003.equals("1")?"checked":""%>>
								  <input type="hidden" id="BKA004003" name ="BKA004003" value="<%=BKA004003%>">
								  <label class="form-check-label" for="BKA00403">電話</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input validate[required,groupRequired[grp]]" type="checkbox" id="BKA00404" name="BKA004" value="1" <%=BKA004004.equals("1")?"checked":""%>>
								  <input type="hidden" id="BKA004004" name ="BKA004004" value="<%=BKA004004%>">
								  <label class="form-check-label" for="BKA00404">現場</label>
								</div>
							</div>
							<div class="col-xl-12 mt-2">
								<label for="BKA004005" class="form-label text-deepgreen fw-bold">備註</label>
								<div class="form-floating">
								  <textarea class="form-control" placeholder="Leave a comment here" id="BKA004005" name="BKA004005" style="height: 100px"><%=BKA004005%></textarea>
								</div>
							</div>
							<div class="col-xl-12 mt-3" align="center">
								<button type="button" class="btn btn-blue border-secondary" onClick="SF01('BKB020301','_self')">儲存</button>
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
  //form1.submit();
}
$("#BKA00402").click(function(){
  var checkis = $(this).is(":checked");
  if(checkis == true)form1.BKA004002.value = "1";
  if(checkis == false)form1.BKA004002.value = "";
});
$("#BKA00403").click(function(){
  var checkis = $(this).is(":checked");
  if(checkis == true)form1.BKA004003.value = "1";
  if(checkis == false)form1.BKA004003.value = "";
});
$("#BKA00404").click(function(){
  var checkis = $(this).is(":checked");
  if(checkis == true)form1.BKA004004.value = "1";
  if(checkis == false)form1.BKA004004.value = "";
});

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
