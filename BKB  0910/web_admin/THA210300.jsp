<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<% 
String PK01 = SQLIJ(request.getParameter("PK01"));
String PK02 = SQLIJ(request.getParameter("PK02"));
String URA001001 = "";
String URA001002 = "";
String URA001013 = "";
String TD01 = ""; //宣告SQL語法
String ST01 = ""; //宣告SQL語法
String ST02 = ""; //宣告SQL語法
String ST03 = ""; //宣告SQL語法
String SQL01 = ""; //宣告SQL語法
String SQL02 = ""; //宣告SQL語法
String[] AS01 = null;
Map[] RS01 = null; //將篩選出來的資料放到陣列中
Map[] RS02 = null; //將篩選出來的資料放到陣列中
Map[] RS03 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table

if (!PK01.equals("")){
URA001001 = PK01;
URA001002 = TAB01.getCol("URA001","URA001002","URA001001","'"+URA001001+"'");
URA001013 = TAB01.getCol("URA001","URA001013","URA001001","'"+URA001001+"'");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>
<body>
<!-- indexS -->
<%@ include file="../web_page/indexS.jsp"%>
<form id="FM01" name="FM01" method="post" action="">
	<input name="PK01" type="hidden" id="PK01" value="" />
	<input name="PK02" type="hidden" id="PK02" value="" />
<br><br>
<div class="container">
	<div class="card shadow">
		<div class="card-body pb-0">
			<div class="d-flex justify-content-between">
				<div><h4 class="text-red2 font-weight-bold">使用者權限管理</h4></div>
			</div>
			<ol class="breadcrumb">
				<li class="breadcrumb-item">首頁</li>
				<li class="breadcrumb-item">資料維護</li>
				<li class="breadcrumb-item">使用者帳號權限管理</li>
				<li class="breadcrumb-item active">使用者帳號權限變更</li>
			</ol>
		</div>	
		<div class="container-fluid mt-2">
			<div class="alert alert-success" role="alert"><strong>群組權限管理</strong></div>
			<div class="row">
				<div class="col-sm">
					<label for="" class="col-form-label">名稱 / 帳號</label>
					<input type="text" class="form-control" value="<%=URA001002%> / <%=PK01%>" readonly/>
					<input name="URA002001" type="hidden" id="URA002001" value="<%=PK01%>" />
					<input name="URA002007" type="hidden" id="URA002007" value="1" />
				</div>
				<div class="col-sm">
					<label for="" class="col-form-label">群組類別</label>
					<input type="text" class="form-control"name="" id="" value="<%=URA001013%>" readonly/>
				</div>
				<%
				SQL01 = "SELECT DISTINCT WSA001001,WSA001002,WSA001003,WSA001004,WSA001006,WSA001010,WSA001013 FROM WSA001 WHERE WSA001016 <> '0' AND WSA001012 = 'A' ORDER BY WSA001013";				
				RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

				if(RS01.length > 0){
				for(int A=0;A<RS01.length;A++){

				ST01 = RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString();

				ST02 = TAB01.getCol("URA002","URA002003","URA002001+URA002002","'"+PK01+ST01+"'");
				ST03 = RS01[A].get("WSA001010").toString();
				%>
				  <%
				SQL01 = "SELECT DISTINCT WSA001001,WSA001002,WSA001003,WSA001004,WSA001007,WSA001013 FROM WSA001 WHERE WSA001016 <> '0' AND WSA001012 = '"+RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString()+"' ORDER BY WSA001013";

				RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

				  if(RS02.length > 0){
				  for(int B=0;B<RS02.length;B++){

				  ST01 = RS02[B].get("WSA001001").toString()+RS02[B].get("WSA001002").toString()+RS02[B].get("WSA001003").toString()+RS02[B].get("WSA001004").toString();

				  ST02 = TAB01.getCol("URA002","URA002003","URA002001+URA002002","'"+PK01+ST01+"'");
				%>
				  <%
				  SQL01 = "SELECT DISTINCT WSA001001,WSA001002,WSA001003,WSA001004,WSA001008,WSA001013 FROM WSA001 WHERE WSA001016 <> '0' AND WSA001012 = '"+RS02[B].get("WSA001001").toString()+RS02[B].get("WSA001002").toString()+RS02[B].get("WSA001003").toString()+RS02[B].get("WSA001004").toString()+"' ORDER BY WSA001013";

				  RS03 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

					if(RS03.length > 0){
					for(int C=0;C<RS03.length;C++){

					ST01 = RS03[C].get("WSA001001").toString()+RS03[C].get("WSA001002").toString()+RS03[C].get("WSA001003").toString()+RS03[C].get("WSA001004").toString();

					ST02 = TAB01.getCol("URA002","URA002003","URA002001+URA002002","'"+PK01+ST01+"'");
				%>
				  <%
					}
					}
				  }
				  }
				}
				}else{
				%>
				  <%
				}
				%>
			</div>
			<div class="alert alert-success mt-4" role="alert"><strong>後台功能權限管理</strong></div>
			  <table width="100%" cellspacing="1" class="table">
			  <%
			SQL01 = "SELECT DISTINCT WSA001001,WSA001002,WSA001003,WSA001004,WSA001006,WSA001010,WSA001013 FROM WSA001 WHERE WSA001016 <> '0' AND WSA001012 = 'A' ORDER BY WSA001013";	
			RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

			if(RS01.length > 0){
			for(int A=0;A<RS01.length;A++){

			ST01 = RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString();

			ST02 = TAB01.getCol("URA002","URA002003","URA002001+URA002002","'"+PK01+ST01+"'");
			ST03 = RS01[A].get("WSA001010").toString();
			%>
			  <tr class="R_C1">
				<td width="70" height="30">　<%=(A+1)%>　</td>
				<td width="182">　<font color="#000080"><%=RS01[A].get("WSA001006").toString()%></font></td>
				<td width="432"><% if (!ST03.equals("")){ %>
				  <table width="50" align="center">
					<tr>
					  <td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="3" <%=((ST02.equals("3"))?"checked=\"checked\"":"")%> /></td>
					  <td nowrap="nowrap" class="B2_color01_left">新增、修改、刪除</td>
					  <td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="2" <%=((ST02.equals("2"))?"checked=\"checked\"":"")%> /></td>
					  <td nowrap="nowrap" class="B2_color01_left">檢視、查詢</td>
					  <td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="0" <%=((ST02.equals("0") || ST02.equals(""))?"checked=\"checked\"":"")%> /></td>
					  <td nowrap="nowrap" class="B2_color01_left">無</td>
					</tr>
				  </table>
				  <% } else { %>
				  &nbsp;
				  <% } %></td>
			  </tr>
			    <%
				//SQL01 = "SELECT DISTINCT WSA001001,WSA001002,WSA001003,WSA001004,WSA001007,WSA001013 FROM WSA001 WHERE WSA001016 <> '0' AND WSA001012 = '"+RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString()+"' ORDER BY WSA001013";
				if(!USERID.equals("wholeway")){
					SQL02 = " AND WSA001001+WSA001002+WSA001003+WSA001004 IN (SELECT URA002002 FROM URA002 WHERE URA002003 <> '0' AND URA002001 = '"+USERID+"') ";
				}
				SQL01 = "SELECT DISTINCT WSA001001,WSA001002,WSA001003,WSA001004,WSA001007,WSA001013 FROM WSA001 WHERE WSA001016 <> '0' "+SQL02+" AND WSA001012 = '"+RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString()+"' ORDER BY WSA001013";
				//out.print(SQL01);
				RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

				  if(RS02.length > 0){
				  for(int B=0;B<RS02.length;B++){

				  ST01 = RS02[B].get("WSA001001").toString()+RS02[B].get("WSA001002").toString()+RS02[B].get("WSA001003").toString()+RS02[B].get("WSA001004").toString();

				  ST02 = TAB01.getCol("URA002","URA002003","URA002001+URA002002","'"+PK01+ST01+"'");
				%>
			  <tr class="R_C1">
				<td height="30" class="txt_data_left">　<%=(A+1)+"-"+(B+1)%>　</td>
				<td class="txt_data_left">　　<font color="#0000FF"><%=RS02[B].get("WSA001007").toString()%></font></td>
				<td class="txt_data_left"><table width="50" align="center">
				  <tr>
					<td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="3" <%=((ST02.equals("3"))?"checked=\"checked\"":"")%> /></td>
					<td nowrap="nowrap" class="txt_data_left">新增、修改、刪除</td>
					<td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="2" <%=((ST02.equals("2"))?"checked=\"checked\"":"")%> /></td>
					<td nowrap="nowrap" class="txt_data_left">檢視、查詢</td>
					<td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="0" <%=((ST02.equals("0") || ST02.equals(""))?"checked=\"checked\"":"")%> /></td>
					<td nowrap="nowrap" class="txt_data_left">無</td>
				  </tr>
				</table></td>
			  </tr>
			  <%
			  SQL01 = "SELECT DISTINCT WSA001001,WSA001002,WSA001003,WSA001004,WSA001008,WSA001013 FROM WSA001 WHERE WSA001016 <> '0' "+SQL02+" AND WSA001012 = '"+RS02[B].get("WSA001001").toString()+RS02[B].get("WSA001002").toString()+RS02[B].get("WSA001003").toString()+RS02[B].get("WSA001004").toString()+"' ORDER BY WSA001013";

			  RS03 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

				if(RS03.length > 0){
				for(int C=0;C<RS03.length;C++){

				ST01 = RS03[C].get("WSA001001").toString()+RS03[C].get("WSA001002").toString()+RS03[C].get("WSA001003").toString()+RS03[C].get("WSA001004").toString();

				ST02 = TAB01.getCol("URA002","URA002003","URA002001+URA002002","'"+PK01+ST01+"'");
			%>
			  <tr class="R_C1">
				<td height="30" class="txt_data_left">　<%=(A+1)+"-"+(B+1)+"-"+(C+1)%>　</td>
				<td class="txt_data_left">　　　<font color="#0066FF"><%=RS03[C].get("WSA001008").toString()%></font></td>
				<td class="txt_data_left"><table width="50" align="center">
				  <tr>
					<td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="3" <%=((ST02.equals("3"))?"checked=\"checked\"":"")%> /></td>
					<td nowrap="nowrap" class="txt_data_left">新增、修改、刪除</td>
					<td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="2" <%=((ST02.equals("2"))?"checked=\"checked\"":"")%> /></td>
					<td nowrap="nowrap" class="txt_data_left">檢視、查詢</td>
					<td><input name="<%=ST01%>" type="radio" id="<%=ST01%>" value="0" <%=((ST02.equals("0") || ST02.equals(""))?"checked=\"checked\"":"")%> /></td>
					<td nowrap="nowrap" class="txt_data_left">無</td>
				  </tr>
				</table></td>
			  </tr>
			  <%
				}
				}
			  }
			  }
			}
			}else{
			%>
			  <tr>
				<td height="30" colspan="3" class="txt_data">目 前 尚 無 權 限 項 目 可 供 設 定 !!</td>
			  </tr>
			  <%
			}
			%>
			</table>
			<!-- 按鈕 -->
			<div class="row mt-4 mb-3">
				<div class="col-sm" align="center">
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:SF01('THA210100','jsp','_self','','');">回上一頁</button>
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:SF01('THA210301','jsp','_self','','A');">儲存</button>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
<!-- indexF -->
<%@ include file="../web_page/indexF.jsp"%>
<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
<script type="text/javascript">
function SF01(A,B,C,D,E){
	FM01.PK01.value=D;
	FM01.PK02.value=E;
	FM01.target=C;
	FM01.action=A+"."+B;
	FM01.submit();
}
</script>
</body>
</html>
<%
DB01.close();
%>
