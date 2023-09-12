<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%
String PK01 = SQLIJ(request.getParameter("PK01"));
String UBZ002008 = "";
String UBZ002009 = "";
String UBZ002010 = "";
String UBZ002011 = "";
String UBZ002015 = "";
String ST01 = ""; //暫存用變數
String ST02 = ""; //暫存用變數
String ST03 = ""; //暫存用變數
String SQL01 = ""; //宣告SQL語法
Map[] RS01 = null; //將篩選出來的資料放到陣列中
Map[] RS02 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table
SQL01 = "SELECT * FROM UBZ002 WHERE UBZ002001+UBZ002002+UBZ002003+UBZ002004 = '"+PK01+"'";
//out.print(SQL01+"<br>");
//if(true){return;} 
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

if (RS01.length != 0){
UBZ002008 = RS01[0].get("UBZ002008").toString();
UBZ002009 = RS01[0].get("UBZ002009").toString();
UBZ002010 = RS01[0].get("UBZ002010").toString();
UBZ002011 = RS01[0].get("UBZ002011").toString();
UBZ002015 = RS01[0].get("UBZ002015").toString();
}
%>
<%
String CT01 = TAB01.getCol("UBZ002", "UBZ002011", "UBZ002001 + UBZ002002 + UBZ002003 + '000'", "'" + PK01.substring(0, 7) + "000'");
%>
<!doctype html>
<html>
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- indexS -->
<%@ include file="../web_page/indexS.jsp"%>
<form id="form1" name="form1" method="post" action="">
<input name="PK01" type="hidden" id="PK01" value="">
<input name="PK02" type="hidden" id="PK02" value="">
<div id="layoutSidenav">
	<div id="layoutSidenav_content">
	<main>
		<div class="container">
			<div class="row d-none">	
				<div class="text-dark fw-bold col-sm" align="left"><!--%=USERNAME%--> 您好</div>			    
			</div>	
			<div class="card shadow">
				<div class="card-body pb-0">
					<div class="d-flex justify-content-between">
						<div><h4 class="text-red2 fw-bold">系統代碼管理</h4></div>
					</div>
					<ol class="breadcrumb">
						<li class="breadcrumb-item">首頁</li>
						<li class="breadcrumb-item">系統管理</li>
						<li class="breadcrumb-item">系統代碼維護</li>
						<li class="breadcrumb-item active">代碼資訊修改</li>
					</ol>
				</div>
				<div class="container">
					<table class="table table-bordered">
						<thead class="bg-deepgreen text-light" align="center">
							<tr>
								<td colspan="2" align="center">代碼資訊修改</td>
							</tr>
						</thead>
					  <tr>
						<td width="20%" align="right">      代碼類別：　</td>
						<td width="531" valign="top"><%=TAB01.getCol("UBZ002","UBZ002007","UBZ002001+UBZ002002+UBZ002003","'"+PK01.substring(0,7)+"'")%>
						  <!--
						  <input name="UBZ002011" type="hidden" id="UBZ002011" value="<%=UBZ002011%>">
						  -->
						</td>
					  </tr>
<%
if (!CT01.equals("0")){
%>
					  <tr>
						<td align="right">所屬分類：　     </td>
						<td valign="top">
						  <select name="UBZ002011" id="UBZ002011" class="form-control">
						    <option value="">-請選擇-</option>
<%
SQL01 = "SELECT UBZ002001+UBZ002002+UBZ002003+UBZ002004 AS T01,UBZ002008 AS T02 FROM UBZ002 WHERE UBZ002015 = '1' AND UBZ002001+UBZ002002+UBZ002003 = '"+CT01+"' AND UBZ002004 <> '000' ORDER BY UBZ002010"; //宣告SQL語法
RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

if (RS02.length != 0){
for (int A=0;A<RS02.length;A++){
ST01 = RS02[A].get("T01").toString();
ST02 = RS02[A].get("T02").toString();
%>
						    <option value="<%=ST01%>" <%=((UBZ002011.equals(ST01))?"selected=\"selected\"":"")%>><%=ST02%></option>
<%
}
}
%>
						  </select>
						</td>
					  </tr>
<%
} else {
%>
                      <tr>
						<td align="right">所屬分類：　     </td>
						<td valign="top">主分類
						  <input name="UBZ002011" type="hidden" id="UBZ002011" value="0">
						</td>
					  </tr>
<%
}
%>
					  <tr>
						<td align="right" valign="top">
						  　代碼名稱：　      </td>
						<td valign="top"><input name="UBZ002008" type="text" class="form-control" id="UBZ002008" value="<%=UBZ002008%>"></td>
					  </tr>
					  <tr>
						<td align="right" valign="top">      識&nbsp;&nbsp;別&nbsp;&nbsp;碼：　      </td>
						<td valign="top"><input name="UBZ002009" type="text" class="form-control" id="UBZ002009" style="width:50px" maxlength="3" value="<%=UBZ002009%>"></td>
					  </tr>
					  <tr>
						<td align="right" valign="top">      序&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：　      </td>
						<td valign="top"><input name="UBZ002010" type="text" class="form-control" id="UBZ002010" style="width:50px" maxlength="11" value="<%=UBZ002010%>"></td>
					  </tr>
					  <tr>
						<td align="right" valign="top">
						  顯示狀態：　      </td>
						<td valign="top"><input type="radio" name="UBZ002015" id="UBZ" class="form-check-input" <%=((UBZ002015.equals("1"))?"checked=\"checked\"":"")%> value="1">
					顯示
					  <input type="radio" name="UBZ002015" id="UBZ002015" class="form-check-input" <%=((UBZ002015.equals("0"))?"checked=\"checked\"":"")%> value="0">
					隱藏</td>
					  </tr>
					</table>
					<div class="row mb-3">
						<div class="col-sm" align="center">
							<button type="button" class="btn btn-light border-secondary" onClick="SF01('UBC980200','jsp','_self','<%=PK01.substring(0,7)%>','')"><i class="fas fa-reply-all mr-2"></i>回上一頁</button>
						</div>
						<div class="col-sm" align="center">
							<button type="button" class="btn btn-light border-secondary" onClick="SF01('UBC980203','jsp','_self','<%=PK01%>','B')"><i class="fa fa-edit pr-2"></i>儲存</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		</main>
	<!-- indexF -->
	<%@ include file="../web_page/indexF.jsp"%>
	</div>
</div>
</form>
<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
<script type="text/JavaScript">
function SF01(A,B,C,D,E){
	form1.PK01.value=D;
	form1.PK02.value=E;
	form1.target=C;
	form1.action=A+"."+B;
	form1.submit();
}
</script>

</body>
</html>
<%
DB01.close();
%>