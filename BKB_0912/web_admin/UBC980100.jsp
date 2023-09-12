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
String ST01 = "";
String ST02 = "";
String SQL01 = ""; //宣告SQL語法
String[] AS01=null;
Map[] RS01 = null; //將篩選出來的資料放到陣列中
Map[] RS02 = null; //將篩選出來的資料放到陣列中
Map[] RS03 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("BK");//宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();//宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table

SQL01 = "SELECT DISTINCT UBZ002001,UBZ002002,UBZ002006 FROM UBZ002 WHERE UBZ002015 <> '0'";
SQL01 = SQL01 + " ORDER BY UBZ002001,UBZ002002";

RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中
%>
<!doctype html>
<html>
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="form1" name="form1" method="post" action="">
<input name="PK01" type="hidden" id="PK01" value="" />
<input name="PK02" type="hidden" id="PK02" value="" />
<input name="PNO01" type="hidden" id="PNO01" value="" />
<!-- indexS -->
<%@ include file="../web_page/indexS.jsp"%>
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
						<li class="breadcrumb-item active">系統代碼維護</li>
					</ol>
				</div>
				<div class="container mb-3">
					<div>
					<table class="table table-bordered">
					<thead class="bg-light" align="center">
						<tr>
						  <td width="100%" align="center" nowrap class="c_brown"><strong>代碼類別</strong></td>
						  <td align="center" nowrap class="c_brown"><strong>顯示代碼數</strong></td>
						  <td align="center" nowrap class="c_brown"><strong>隱藏代碼數</strong></td>
						</tr>
					</thead>
					<%
					if(RS01.length > 0){
					for(int A=0;A<RS01.length;A++){
					%>
					<tr class="bg-secondary bg-opacity-75 text-light">
					  <td align="left" valign="top" class="c_brown_1eft" style="line-height:18px"><font class="txt_link">代碼項目<%=A+1%>：<%=RS01[A].get("UBZ002006").toString()%></font></td>
					  <td align="center" valign="top" nowrap="nowrap" class="c_brown">-</td>
					  <td align="center" valign="top" nowrap="nowrap" class="c_brown">-</td>
					</tr>
					<%
					//SQL01 = "SELECT DISTINCT UBZ002001,UBZ002002,UBZ002003,UBZ002007 FROM UBZ002 WHERE UBZ002015 <> '0' AND UBZ002001 = '"+RS01[A].get("UBZ002001").toString()+"' AND UBZ002002 = '"+RS01[A].get("UBZ002002").toString()+"' AND UBZ002011 = '0'";
					SQL01 = "SELECT DISTINCT UBZ002001,UBZ002002,UBZ002003,UBZ002007 FROM UBZ002 WHERE UBZ002001 = '"+RS01[A].get("UBZ002001").toString()+"' AND UBZ002002 = '"+RS01[A].get("UBZ002002").toString()+"' AND UBZ002010 = '0'";
					SQL01 = SQL01 + " ORDER BY UBZ002001,UBZ002002,UBZ002003";

					RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

					  if(RS02.length > 0){
					  for(int B=0;B<RS02.length;B++){
					%>
					<tr class="">
					  <td align="left" valign="top" style="line-height:18px"><a href="#" onClick="javascript:SF01('UBC980200','jsp','_self','<%=RS02[B].get("UBZ002001").toString()+RS02[B].get("UBZ002002").toString()+RS02[B].get("UBZ002003").toString()%>','');" title="瀏覽" class="otherlink_2"><%=RS02[B].get("UBZ002007").toString()%></a></td>
					<%
					ST01 = TAB01.getCol("UBZ002","COUNT(UBZ002004)","UBZ002001+UBZ002002+UBZ002003+UBZ002015","'"+RS02[B].get("UBZ002001").toString()+RS02[B].get("UBZ002002").toString()+RS02[B].get("UBZ002003").toString()+"1'");
					%>
					  <td align="center" valign="top" nowrap="nowrap" class="B1_orange"><%=((Integer.parseInt(ST01) > 0)?(Integer.parseInt(ST01)):ST01)%></td>
					  <td align="center" valign="top" nowrap="nowrap" class="B1_orange"><%=TAB01.getCol("UBZ002","COUNT(UBZ002004)","UBZ002004 <> '000' AND UBZ002001+UBZ002002+UBZ002003+UBZ002015","'"+RS02[B].get("UBZ002001").toString()+RS02[B].get("UBZ002002").toString()+RS02[B].get("UBZ002003").toString()+"0'")%></td>
					</tr>
					<%
					/*
					SQL01 = "SELECT DISTINCT UBZ002001,UBZ002002,UBZ002003,UBZ002007 FROM UBZ002 WHERE UBZ002015 <> '0' AND UBZ002001 = '"+RS02[B].get("UBZ002001").toString()+"' AND UBZ002002 = '"+RS02[B].get("UBZ002002").toString()+"' AND SUBSTRING(UBZ002011,1,7) = '"+RS02[B].get("UBZ002001").toString()+RS02[B].get("UBZ002002").toString()+RS02[B].get("UBZ002003").toString()+"'";
					SQL01 = SQL01 + " ORDER BY UBZ002001,UBZ002002,UBZ002003";

					RS03 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

						if(RS03.length > 0){
						for(int C=0;C<RS03.length;C++){
					*/
					%>
					<!--
					<tr class="">
					  <td align="left" valign="top" style="line-height:18px"><a href="#" onClick="javascript:SF01('UBC980200','jsp','_self','<%//=RS03[C].get("UBZ002001").toString()+RS03[C].get("UBZ002002").toString()+RS03[C].get("UBZ002003").toString()%>','');" title="瀏覽" class="otherlink_2"><%//=RS03[C].get("UBZ002007").toString()%></a></td>
					<%
					//ST01 = TAB01.getCol("UBZ002","COUNT(UBZ002004)","UBZ002001+UBZ002002+UBZ002003+UBZ002015","'"+RS03[C].get("UBZ002001").toString()+RS03[C].get("UBZ002002").toString()+RS03[C].get("UBZ002003").toString()+"1'");
					%>
					  <td align="center" valign="top" nowrap="nowrap" class="B1_titleorange"><%=((Integer.parseInt(ST01) > 0)?(Integer.parseInt(ST01)-1):ST01)%></td>
					  <td align="center" valign="top" nowrap="nowrap" class="B1_titleorange"><%//=TAB01.getCol("UBZ002","COUNT(UBZ002004)","UBZ002001+UBZ002002+UBZ002003+UBZ002015","'"+RS03[C].get("UBZ002001").toString()+RS03[C].get("UBZ002002").toString()+RS03[C].get("UBZ002003").toString()+"0'")%></td>
					</tr>
					-->
					<%
						//}
						//}
					  }
					  }
					}
					}else{
					%>
					<tr class="">
					  <td width="100%" colspan="5" align="center" class="txt_link">目 前 尚 無 資 料 !!</td>
					</tr>
					<%
					}
					%>
					</table>
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
</body>
</html>
<%
DB01.close();
%>
<script type="text/javascript">
function SF01(A,B,C,D,E){
	form1.PK01.value=D;
	form1.PK02.value=E;
	form1.target=C;
	form1.action=A+"."+B;
	form1.submit();
}
</script>