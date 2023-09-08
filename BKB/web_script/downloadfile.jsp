<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="java.io.*,java.net.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%
//取得帳號
String USERID = (String)session.getAttribute("UID");
String UNAME = (String)session.getAttribute("UNAME");

%>
<%

String PK01 = SQLIJ(request.getParameter("PK01"));   //目錄1
String PK02 = SQLIJ(request.getParameter("PK02"));   //目錄2
String PK03 = SQLIJ(request.getParameter("PK03"));   //檔名
String path = "D:/TFADATA/"+PK01+"/"+PK02+"/"; //檔案主要放置目錄
String filename = PK03; //檔案名
//欲下載再 D:/demo.pdf 之檔案。
//filename = new String(filename.getBytes("ISO-8859-1"),"utf-8");
File file = new File(path+filename);
//if(true)return;
out.println(path+filename+"<br/>");
if(file.exists()){//檢驗檔案是否存在
try{
response.reset();     
response.setContentType("application/octet-stream; charset=utf-8;");
response.setHeader("Content-Disposition","attachment; filename=\"" + URLEncoder.encode(filename, "utf-8") + "\""); 
OutputStream output = response.getOutputStream();
output.flush();
InputStream in = new FileInputStream(file);
byte[] b = new byte[2048];
int len;

while((len = in.read(b))>0){
output.write(b,0,len);
}
in.close();
output.flush();
output.close(); //關閉串流
out.clear();
out = pageContext.pushBody();
}catch(Exception ex){
out.println("Exception : "+ex.toString());
out.println("<br/>");
}
}else{
out.println(filename+" : 此檔案不存在");
out.println("<br/>");
}
%>