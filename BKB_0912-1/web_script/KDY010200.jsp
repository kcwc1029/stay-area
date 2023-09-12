<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ include file="WSA010400.jsp"%>
<%@ include file="WSA010500.jsp"%>
<%@ include file="WSA010700.jsp"%>
<%
String tabname=SQLIJ(request.getParameter("tabname"));
String sendmsg=SQLIJ(request.getParameter("sendmsg"));
String sendurl=SQLIJ(request.getParameter("sendurl"));
if(tabname.equals("") || sendurl.equals("")){
	out.print("嚴重錯誤請洽系統管理員");
	return;
}
String PK01=SQLIJ(request.getParameter("PK01"));
String PK02=SQLIJ(request.getParameter("PK02"));
String PK01V=SQLIJ(request.getParameter("PK01V"));
String PK02V=SQLIJ(request.getParameter("PK02V"));

//資料庫連線宣告
Database db =new Database("BK"); //宣告資料庫連線
Connection conn = db.getConn();  //宣告連線(可宣告或不宣告)
Statement statement = conn.createStatement();//使用新增、修改、刪除語法的宣告
try{
  //主鍵值  
  int indkey=Integer.parseInt(request.getParameter("indkey"));
  //int updatekey=Integer.parseInt(request.getParameter("updatekey"));
  int i=0;
  String SQL = "SELECT * FROM "+tabname+" where 1=2";
  ResultSet resultset = statement.executeQuery(SQL);
  ResultSetMetaData rsmd=resultset.getMetaData();
  int j =rsmd.getColumnCount()+1;
  String fname="";
  String dname="";
  String gname="";
  SQL="";
  
  for(i=indkey;i<j;i++){
   gname=SQLIJ(request.getParameter(rsmd.getColumnName(i)));
   if (gname==null){
     gname="";
   }
   if (rsmd.getColumnType(i)==12){
   SQL=SQL+","+rsmd.getColumnName(i)+"=N'"+gname+"'";
   }
   else if (rsmd.getColumnType(i)==-1){
   SQL=SQL+","+rsmd.getColumnName(i)+"=N'"+gname+"'";
   }
   else if (rsmd.getColumnType(i)==2005){
   SQL=SQL+","+rsmd.getColumnName(i)+"=N'"+gname+"'";
   }
   else
   {
   SQL=SQL+","+rsmd.getColumnName(i)+"="+gname;
   }
  }
  SQL=SQL.substring(1);
  String SQL1="";
  for(i=1;i<indkey;i++){
   gname=SQLIJ(request.getParameter(rsmd.getColumnName(i)));
   if (gname==null){
     gname="";
   }
   if (rsmd.getColumnType(i)==12){
   SQL1=SQL1+" and "+rsmd.getColumnName(i)+"='"+gname+"'";
   }
   else if (rsmd.getColumnType(i)==-1){
   SQL1=SQL1+" and "+rsmd.getColumnName(i)+"='"+gname+"'";
   }
   else if (rsmd.getColumnType(i)==2005){
   SQL1=SQL1+" and "+rsmd.getColumnName(i)+"='"+gname+"'";
   }
   else
   {
   SQL1=SQL1+" and "+rsmd.getColumnName(i)+"="+gname;
   }
  }
  
  SQL1=SQL1.substring(4);
  SQL = "update " + tabname + " set " + SQL + " where " + SQL1;
  //out.print(SQL);
  //if(true)return;   //終止程式
  statement.executeUpdate(SQL);
}catch (SQLException se){
	se.printStackTrace();
	sendmsg=se.toString().replace("'","");
}finally {
	db.close();
}  
%>
<!DOCTYPE html>
<html lang="zh"> 
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>
<body>
<form id="form1" name="form1" method="post" action="">
<input type="hidden" id="<%=PK01%>" name="<%=PK01%>" value="<%=PK01V%>">
<input type="hidden" id="<%=PK02%>" name="<%=PK02%>" value="<%=PK02V%>">
</form>

<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
</body>
</html>
<script language="javascript">
<% if (sendmsg.equals("修改成功") && sendurl!=null && sendurl!=""){ %>
Swal.fire({
  icon: 'success',
  title: '系統訊息',
  text: '<%=sendmsg%>',
  confirmButtonText:'回編輯頁',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	form1.action="<%=sendurl%>";
	form1.target="_self";
	form1.submit();
  } else if (result.isDenied) {
	form1.action="<%=sendurl%>";
	form1.target="_self";
	form1.submit();
  }
});
<%}else{%>
Swal.fire({
  icon: 'error',
  title: '系統訊息',
  text: '<%=sendmsg%>',
  confirmButtonText:'回編輯頁',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	form1.action="<%=sendurl%>";
	form1.target="_self";
	form1.submit();
  } else if (result.isDenied) {
	form1.action="<%=sendurl%>";
	form1.target="_self";
	form1.submit();
  }
});
<%}%>
</script>