<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>

<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8" />
<title>匯入文字檔</title>
</head>
<%
//寫入門牌資料用
Database db = new Database("BK"); //宣告資料庫連線
Connection conn = db.getConn();  //宣告連線(可宣告或不宣告)
PreparedStatement preSMT01 = null;
Table TAB01 =new Table(conn); //宣告對應的table
String SQL01 = "";
boolean success = true;
String type = "";
String sendmsg="更新成功";
SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmss");
String SC01 = date.format(new Date());
String tname = "LI";
String fileName = "全國村里代碼.csv";
String path = "Z://CC//";
int count = 0;
int colnum = 0;
try{
	//取得檔案
	File f = new File(path, fileName);
	InputStreamReader isr = new InputStreamReader(new FileInputStream(f), "UTF-8"); 
	BufferedReader br = new BufferedReader(isr);
	String line = "";
	String cvsSplitBy = ",(?=([^\"]*\"[^\"]*\")*[^\"]*$)";
	//創造暫存表
	SQL01 = "TRUNCATE TABLE " + tname ;  
	preSMT01 = conn.prepareStatement(SQL01);
	preSMT01.executeUpdate();
	while((line=br.readLine()) != null){
		String[] data = line.replaceAll("\uFEFF", "").split(cvsSplitBy, -1);
		if(count == 0){  //第一筆
			colnum = data.length;
			out.print(colnum+"<br>");
			
		}else{  //第二筆以後
			if(colnum==data.length){
				SQL01 = "INSERT INTO " + tname + " VALUES (";
				for(int A=0; A<data.length; A++){
					SQL01 += "?, ";
				}
				SQL01 = SQL01.substring(0, SQL01.length() - 2);
				SQL01 += ")";
				preSMT01 = conn.prepareStatement(SQL01);
				for(int A=0; A<data.length; A++){
					preSMT01.setString(A+1, data[A].replace("'", "").replace("\"", "").replace("NULL", "").replace("null", ""));
				}
				preSMT01.executeUpdate();
				preSMT01.close();
			}else{
				out.println("第"+count+"筆資料欄位數目錯誤:" + data.length);
			}
		}
		count++;
	}
	//out.print(SQL01+"<br>");
}catch(SQLException e){
	e.printStackTrace();
	out.println("第"+count+"筆資料匯入錯誤:" + e);
}

db.close();

%>
<body>
<%=sendmsg%>
</body>
<script>
</script>
</html>

