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
String PK01 = SQLIJ(request.getParameter("PK01")); //案名或公告字號關鍵字
String KW01 = SQLIJ(request.getParameter("KW01")); //案名或公告字號關鍵字
String ST01 = "";
String ST02 = "";
String SQL01 = ""; //宣告SQL語法
String[] AS01=null;
Map[] RS01 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("CC"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table

SQL01 = "SELECT * FROM UBZ002 WHERE UBZ002004 <> '00' AND UBZ002001+UBZ002002+UBZ002003 = '"+PK01+"'";

//案名或公告字號關鍵字查詢
if (!KW01.equals("") && !KW01.equals("請輸入代碼名稱")){
SQL01 = SQL01 + " AND UBZ002008 LIKE '%"+KW01+"%'";
}

SQL01 = SQL01 + " ORDER BY UBZ002010 DESC";

RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中
%>
<%
//資料總筆數(必須轉換為數值)
int DTNUM01 = RS01.length;

//每頁顯示筆數
int PNUM01 = 20;

//總頁數(取整數部份)
int TPAGE01 = ((DTNUM01-1)/PNUM01)+1;

//頁碼
int PNO01 = 1;
if (request.getParameter("PNO01") != null && request.getParameter("PNO01") != ""){
PNO01 = Integer.parseInt(request.getParameter("PNO01"));
}

//起始筆數
int SNUM01 = (PNUM01*PNO01)-PNUM01;

//迄止筆數
int ENUM01;
if (PNO01 != TPAGE01){
ENUM01 = PNUM01*PNO01;
} else {
ENUM01 = DTNUM01;
}
%>
<!doctype html>
<html>
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="FM01" name="FM01" method="post" action="">
	<input name="PK01" type="hidden" id="PK01" value="">
	<input name="PK02" type="hidden" id="PK02" value="">
	<input name="PNO01" type="hidden" id="PNO01" value="" />
<div class="container">
	<div class="row">	
		<div class="text-dark font-weight-bold col-sm" align="left"><!--%=USERNAME%--> 您好</div>			    
	</div>	
	<div class="card shadow">
		<div class="card-body pb-0">
			<div class="d-flex justify-content-between">
				<div><h4 class="text-red2 font-weight-bold">系統代碼管理</h4></div>
			</div>
			<ol class="breadcrumb">
				<li class="breadcrumb-item">首頁</li>
				<li class="breadcrumb-item">資料維護</li>
				<li class="breadcrumb-item">系統代碼維護</li>
				<li class="breadcrumb-item active"><%=TAB01.getCol("UBZ002","UBZ002007","UBZ002001+UBZ002002+UBZ002003","'"+PK01+"'")%></li>
			</ol>
		</div>
		<div class="container mb-3">
			<table width="100%" border="0" cellpadding="2">
			  <tr>
				<td width="12%" height="40" nowrap class="RF_C10">關&nbsp;&nbsp;鍵&nbsp;&nbsp;字：</td>
				<td width="37%" height="40"><input name="KW01" type="text" id="KW01" value="<%=((!KW01.equals(""))?KW01:"請輸入代碼名稱")%>" class="RF_C9"></td>
				<td width="5%"><input type="button" name="button" id="button" value="查 詢" onClick="javascript:SF01('UBC980200','jsp','_self','<%=PK01%>','');"></td>
				<td width="46%"><input type="button" name="button" id="button" value="回代碼類別" onClick="javascript:SF01('UBC980100','jsp','_self','','');"></td>
			  </tr>
			</table>
			<div>
			<table width="100%" border="" align="center" cellspacing="1" class="B1_Grayline">
			  <tr class="RF_C6">
				<td align="center" nowrap class="c_brown"><strong>序位</strong></td>
				<td width="100%" align="center" nowrap class="c_brown"><strong>代碼名稱</strong></td>
				<td align="center" nowrap class="c_brown"><strong>識別碼</strong></td>
				<!--<td align="center" nowrap><strong>所屬類別</strong></td>-->
				<td align="center" nowrap class="c_brown"><strong>顯示狀態</strong></td>
				<td align="center" nowrap class="c_brown"><a href="#" onClick="javascript:SF01('UBC980300','jsp','_self','<%=PK01%>','UBC980301.jsp');" title="新增"><img src="../web_img/02.png" alt=""></a></td>
				<!--<td align="center">來　源</td>-->
			  </tr>
			<%
			if(RS01.length > 0){
			for(int A=SNUM01;A<ENUM01;A++){
			%>
			  <tr class="R_C1">
				<td align="center" valign="top" nowrap="nowrap"><%=RS01[A].get("UBZ002010").toString()%></td>
				<td align="left" valign="top" style="line-height:18px"><%=RS01[A].get("UBZ002008").toString()%></td>
				<td align="center" valign="top" nowrap="nowrap"><%=RS01[A].get("UBZ002009").toString()%></td>
				<!--<td align="center" valign="top" nowrap="nowrap"><%//=((RS01[A].get("UBZ002011").toString().equals("0"))?"主類別":TAB01.getCol("UBZ002","UBZ002007","UBZ002001+UBZ002002+UBZ002003+UBZ002004","'"+RS01[A].get("UBZ002011").toString()+"'"))%></td>-->
				<td align="center" valign="top" nowrap="nowrap"><%=((RS01[A].get("UBZ002015").toString().equals("1"))?"顯示":"隱藏")%></td>
				<td width="1%" align="center" valign="top" nowrap><a href="#" onClick="javascript:SF01('UBC980302','jsp','_self','<%=RS01[A].get("UBZ002001").toString()+RS01[A].get("UBZ002002").toString()+RS01[A].get("UBZ002003").toString()+RS01[A].get("UBZ002004").toString()%>','UBC980302.jsp');" title="修改"><img src="../web_img/11.png" alt=""></a></td>
			  </tr>
			  <%
			}
			}else{
			%>
			  <tr>
				<td width="100%" colspan="6" align="center" class="RF_C6">目 前 尚 無 資 料 !!</td>
			  </tr>
			  <%
			}
			%>
			</table>
			</div>
			<table width="100%" border="0" align="center" cellpadding="2" class="RF_C10">
			  <tr>
				<td align="center">目 前 共 有 <%=RS01.length%> 筆 紀 錄 ， 本 頁 顯 示 第 <%=SNUM01+1%> 到 <%=ENUM01%> 筆</td>
			  </tr>
			</table>
			<table width="70%" border="0" align="center" cellpadding="2" class="RF_C10">
			  <tr>
				<td nowrap="nowrap" class="text13"><a href="javascript:PG01('1');" onFocus="this.blur()">第 一 頁</a></td>
				<td nowrap="nowrap" class="text13"><% if (SNUM01 != 0){ %>
				  <a href="javascript:PG01('<%=PNO01-1%>');" onFocus="this.blur()">上 一 頁</a>
				  <% } %></td>
				<td width="100%" align="center" class="text13">　<font face="Arial, Helvetica, sans-serif">《 </font> <font face="Arial, Helvetica, sans-serif">
					<%
					for (int i=1;i<TPAGE01+1;i++){
					 if (i > PNO01-10 && i <= PNO01+10){
					   if (i != PNO01 && (i != TPAGE01 && i != PNO01+10)){
					%>
				  <a href="javascript:PG01('<%=i%>');" onFocus="this.blur()"><font color="#0000FF"><%=i%></font></a><font color="#0000FF"> | </font></font> <font face="Arial, Helvetica, sans-serif">
					<% } else if (i != PNO01 && (i == TPAGE01 || i == PNO01+10)){ %>
					<a href="javascript:PG01('<%=i%>');" onFocus="this.blur()"><font color="#0000FF"><%=i%></font></a>
					<% } else if (i == PNO01 && i == TPAGE01){ %>
					<font color="#333333"><%=i%></font></font> <font face="Arial, Helvetica, sans-serif">
					  <% } else { %>
					  <font color="#333333"><%=i%></font></font><font color="#0000FF" face="Arial, Helvetica, sans-serif"> | </font> <font face="Arial, Helvetica, sans-serif">
						<%
			   }
			 }
			}
			%>
						》</font></td>
				<td nowrap="nowrap" class="text13"><% if (ENUM01 != DTNUM01){ %>
				  <a href="javascript:PG01('<%=PNO01+1%>');" onFocus="this.blur()"><font color="#0066FF">下 一 頁</font></a>
				  <% } %></td>
				<td nowrap="nowrap" class="text13">　　<a href="javascript:PG01('<%=TPAGE01%>');" onFocus="this.blur()">最 末 頁</a></td>
			  </tr>
			</table>			
		</div>
	</div>
</div>
</form>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
</body>
<script type="text/JavaScript">
function PG01(a){
//alert("AA");
FM01.target="_self";
FM01.action="<%=request.getRequestURI()%>";
FM01.PNO01.value=a;
FM01.submit();
}
function SF01(A,B,C,D,E){
	FM01.PK01.value=D;
	FM01.PK02.value=E;
	FM01.target=C;
	FM01.action=A+"."+B;
	FM01.submit();
}
</script>
</html>
<%
DB01.close();
%>