<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%
//取得帳號
String USERID = SQLIJ(request.getParameter("USERID"));
String UPWD = request.getParameter("UPWD");
String rand = (String)session.getAttribute("rand");
String verimg = SQLIJ(request.getParameter("verimg"));
String sendurl = "login.jsp";
//取得日期
SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmss");
String SC01 = date.format(new Date());
String CIP = request.getRemoteHost();
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Statement statement = CONN01.createStatement();//使用新增、修改、刪除語法的宣告
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL = "";
String SQL01 = "";
String loginmsg="";
String chkstatus = "error";
//計算半小時前的登入數據
Date date1=new Date();
long Time=(new Date().getTime()/1000)-60*30;
date1.setTime(Time*1000);
String SC02 = date.format(date1);
SQL01 = "SELECT URA004001 FROM URA004 WHERE URA004001 = '" + USERID + "' AND URA004002 >= '" + SC02 + "' AND URA004005 = '登入失敗'";
RS01 = TAB01.buildMaps(SQL01);  //如果是新增，RS01長度
if(RS01.length > 3){
  loginmsg="登入錯誤次數超過3次，請30分鐘後再重新登入";
}
//out.print(SQL01);  //印出訊息
//if(true)return;   //終止程式
SQL01 = "SELECT * FROM URA001 WHERE URA001001 = '" + USERID + "'";
RS01 = TAB01.buildMaps(SQL01);
//out.print(SQL01);  //印出訊息
//if(true)return;   //終止程式
String url="";
if(loginmsg.equals("")){
	if(rand.equals(verimg)){
		if(RS01.length > 0){
			//使用SHA512檢查
			String URA001006 = SHA512(UPWD);  //將UPWD進行MD5編碼
			if(RS01[0].get("URA001006").toString().equals(URA001006)){
				session.invalidate();
				session=request.getSession(true);
				String URA001016 = RS01[0].get("URA001016").toString();
				session.setAttribute("USERID", USERID);   //帳號 
				session.setAttribute("USERNAME", RS01[0].get("URA001002").toString());  //姓名
				session.setAttribute("USERKIND", RS01[0].get("URA001003").toString());  //角色別
				String URA001011C = RS01[0].get("URA001011").toString();  //十碼章
				String URA001011N = RS01[0].get("URA001011").toString();  //單位別
				URA001011N = TAB01.getCol("BKA007", "BKA007003", "BKA007001", "'"+URA001011N+"'");  //加入診所名稱
				String URA001012 = RS01[0].get("URA001012").toString();//職稱別
				//out.print(URA001011N);
				//if(true)return;
				String URA001010 = RS01[0].get("URA001010").toString(); //轄區
				session.setAttribute("URA001010",URA001010);  //轄區
				session.setAttribute("URA001011C",URA001011C);  //十碼章
				session.setAttribute("URA001011N",URA001011N);  //單位
				session.setAttribute("URA001012",URA001012);  //職稱別
				session.setAttribute("URA001016",URA001016);  //0停用,1啟用,2第一次登入
				//新增作業紀錄
				SQL = "insert into URA004 (URA004001,URA004002,URA004003,URA004004,URA004005,URA004006) VALUES ('"+USERID+"','"+SC01+"','','"+request.getRemoteHost()+"','登入成功','CRA_CHK')";
				statement.executeUpdate(SQL);
				if(URA001016.equals("0")){
					chkstatus = "error";
					loginmsg="帳號已停用，請洽系統管理員";
					sendurl= "login.jsp";
				}else if(URA001016.equals("1")){
					chkstatus = "success";
					loginmsg="登入成功";
					sendurl= "login_welcome.jsp";
				}else if(URA001016.equals("2")){
					chkstatus = "success";
					loginmsg="第一次登入，需立即修改密碼";
					sendurl= "../web_admin/THA210500.jsp";
				}else{
					chkstatus = "error";
					loginmsg="不明錯誤";
					sendurl= "login.jsp";
					session.invalidate();
					session=request.getSession(true);
				}
			}else{
				loginmsg="帳號密碼錯誤";
				SQL = "insert into URA004 (URA004001,URA004002,URA004003,URA004004,URA004005,URA004006) VALUES ('"+USERID+"','"+SC01+"','','"+request.getRemoteHost()+"','登入失敗','CRA_CHK')";
				statement.executeUpdate(SQL);
			}
		}else{
			loginmsg="帳號密碼錯誤"+USERID;
			SQL = "insert into URA004 (URA004001,URA004002,URA004003,URA004004,URA004005,URA004006) VALUES ('"+USERID+"','"+SC01+"','','"+request.getRemoteHost()+"','登入失敗','CRA_CHK')";
			statement.executeUpdate(SQL);
		}
	}else{
		loginmsg="驗證碼錯誤";
		SQL = "insert into URA004 (URA004001,URA004002,URA004003,URA004004,URA004005,URA004006) VALUES ('"+USERID+"','"+SC01+"','','"+request.getRemoteHost()+"','登入失敗','CRA_CHK')";
		statement.executeUpdate(SQL);
	}
}
%>
<!DOCTYPE html>
<html lang="zh">

<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body>
<form action="" method="post" name="form1" id="form1">
<%//=UPWD%>
</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
<script type="text/javascript">
Swal.fire({
  icon: '<%=chkstatus%>',
  title: '系統訊息',
  text: '<%=loginmsg%>',
  confirmButtonText:'進入系統歡迎頁',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	parent.location.href="<%=sendurl%>";
  } else if (result.isDenied) {
	parent.location.href="login_welcome.jsp";
  }
});
</script>
</body>
</html>
