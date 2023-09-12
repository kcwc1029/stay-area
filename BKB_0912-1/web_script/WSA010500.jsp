<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%
String TSQL01 = ""; //宣告SQL語法
Map[] TRS01 = null; //將篩選出來的資料放到陣列中
Map[] TRS02 = null; //將篩選出來的資料放到陣列中

//String USERID = "wholeway";
String USERID = (String)session.getValue("USERID");
String USERNAME = (String)session.getValue("USERNAME");
String USERKIND = (String)session.getValue("USERKIND");  //角色
String URA001016C = (String)session.getValue("URA001016");
String URA001010C = (String)session.getValue("URA001010");
String URA001011C = (String)session.getValue("URA001011C");  //十碼章
String URA001011N = (String)session.getValue("URA001011N");  //診所名稱
String URA001012C = (String)session.getValue("URA001012");
//out.print(USERID+"<br>");
String SA01 = "";
String SA02 = "";
String SA03 = "";
String SA04 = "";
String USS01=request.getRequestURI();
//out.print(USS01+"<br>");
if (USS01.lastIndexOf("/") != -1 && USS01.lastIndexOf(".") != -1){
	SA01=USS01.substring(USS01.lastIndexOf("/")+1,USS01.lastIndexOf("."));
}
//out.print(SA01+"<br>");

if(USERID==null){
%>
	<script type="text/javascript">
	alert("請 重 新 登 入 !!");
	window.location="../index.jsp";
	</script>
<%
	if(true){return;}
}else{

//資料庫連線宣告
  Database TDB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
  Connection TCONN01 = TDB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
  Table TTAB01 =new Table(TCONN01); //宣告對應的table
  
  TSQL01 = "SELECT WSA001001+WSA001002+WSA001003+WSA001004 AS FUNC01,WSA001011 FROM WSA001 WHERE WSA001016 = '1' AND SUBSTRING(WSA001010,1,9) = '"+SA01.substring(0,9)+"'";
  //out.print(TSQL01+"<br>");
  //TSQL01 = "SELECT * FROM URA002 WHERE URA002001 = '"+USERID+"' AND URA002002 IN (SELECT WSA001001+WSA001002+WSA001003+WSA001004 FROM WSA001 WHERE SUBSTRING(WSA001010,1,7) = '"+SA01.substring(0,7)+"') and URA002003 IN ('2','3')";
  TRS01 = TTAB01.buildMaps(TSQL01); //將篩選出來的資料放到陣列中 
  
if(TRS01.length != 0){
	SA02=TRS01[0].get("FUNC01").toString();
	SA03=TRS01[0].get("WSA001011").toString();
} else {
	TSQL01 = "SELECT WSA001001+WSA001002+WSA001003+WSA001004 AS FUNC01,WSA001011 FROM WSA001 WHERE WSA001016 = '1' AND SUBSTRING(WSA001010,1,7) = '"+SA01.substring(0,7)+"' ORDER BY WSA001003,WSA001004";
	//out.print(TSQL01+"<br>");
	TRS02 = TTAB01.buildMaps(TSQL01); //將篩選出來的資料放到陣列中 
	  if(TRS02.length != 0){
		  SA02=TRS02[0].get("FUNC01").toString();
		  SA03=TRS02[0].get("WSA001011").toString();
	  }
}
  //out.print(SA02+"<br>");
  if (!SA02.equals("")){
  TSQL01 = "SELECT * FROM URA002 WHERE URA002001 = '"+USERID+"' and URA002002 = '"+SA02+"' and URA002003 IN ('2','3')";
  //out.print(TSQL01+"<br>");
  //if(true){return;} 
  TRS01 = TTAB01.buildMaps(TSQL01); //將篩選出來的資料放到陣列中 
  //out.print(TRS01.length+"<br>");
  
    if(TRS01.length != 0){
    SA04=TRS01[0].get("URA002003").toString();
	  if (Integer.parseInt(SA04) >= Integer.parseInt(SA03)){
	  
	  } else {
%>  
    <script type="text/javascript">
    alert("您 的 權 限 不 足 ， 無 法 操 作 此 功 能 !!");
    window.location="javascript:history.back()";
    </script>
<%
	  if(true)return;
	  }
    }else{
%>  
    <script type="text/javascript">
    alert("無 操 作 此 功 能 權 限 !!");
    window.location="javascript:history.back()";
    </script>
<%
    if(true)return;
	}
  } else {
  
  }
  TDB01.close();
}
//TDB01.close();
%>
