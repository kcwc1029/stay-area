<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="jxl.*" %>
<%@ page import="jxl.write.*" %>
<%@ page import="jxl.write.biff.RowsExceededException" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%
try{
int T1 = Integer.parseInt(SQLIJ(request.getParameter("T1")));  //T1
int T2 = Integer.parseInt(SQLIJ(request.getParameter("T2")));  //T2
String T3 = SQLIJ(request.getParameter("T3"));  //T3
String FNAME = SQLIJ(request.getParameter("FNAME"));
String[][] TT = (String[][])session.getAttribute(T3);

// 直接下載最重要的兩行
    response.reset();     
    response.setContentType("application/octet-stream; charset=utf-8;");
	response.setHeader("Content-disposition","attachment; filename="+URLEncoder.encode(FNAME, "UTF-8")+".xls");

    OutputStream os = response.getOutputStream();
	os.flush();
    WritableWorkbook workbook = Workbook.createWorkbook(os);
    WritableSheet sheet = workbook.createSheet("Sheet1", 0);
	Label cell ;
	for(int A=0; A<T1; A++){
		for(int B=0; B<T2; B++){
			cell = new Label(B, A, TT[A][B]);
			sheet.addCell(cell);
		}
	}
    workbook.write();
    workbook.close();
    os.flush();
    os.close();
	os=null;  
	response.flushBuffer();  
	out.clear();  
	out = pageContext.pushBody(); 
}catch(Exception e){
    out.print(e);
}
%>



