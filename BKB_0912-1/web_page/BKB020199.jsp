<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.io.FilenameUtils"%>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%@ include file="../web_script/rwxls.jsp"%>
<%
Map[] RS01 = null; //將篩選出來的資料放到陣列中
String SQL01 = "";
Map[] RS02 = null; //將篩選出來的資料放到陣列中
String SQL02 = "";
Map[] RS03 = null; //將篩選出來的資料放到陣列中
String SQL03 = "";
//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)
//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table
Statement SMT01 = CONN01.createStatement(); //使用新增、修改、刪除語法的宣告
String sfname = "";
%>
<%
//計算日期
out.print("資料擷取日："+TDATE+"</br>");

//先取得檔案
String BKA002001 = "";
String BKA002002 = "";
String TBN = "BKA003";  //資料表名稱
String BKA003 = "";
String Path = "";
String fileName = "";
FileItemFactory fileItemFactory = new DiskFileItemFactory();
ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
servletFileUpload.setHeaderEncoding("UTF-8");
try{
	List<FileItem> items = servletFileUpload.parseRequest(request);//把request parse成FileItem List
    Iterator<FileItem> it = items.iterator();
    while(it.hasNext()){
		FileItem item = (FileItem) it.next();
        if(item.isFormField()){
			if(item.getFieldName().equals("BKA003")){
				BKA003=item.getString("UTF-8");
			}else if(item.getFieldName().equals("BKA002001")){
				BKA002001=item.getString("UTF-8");
			}else if(item.getFieldName().equals("BKA002002")){
				BKA002002=item.getString("UTF-8");
			}
        }else{
			Path = "D:\\BKDATA\\"+TBN+"\\";
			//out.print(Path);
			if(!item.getName().equals("")){
				fileName = item.getName();
				//要存放檔案的路徑及目錄
				File saveFile = new File(Path,fileName);
				//如果目錄不存在.則會自動建立
				saveFile.getParentFile().mkdirs();
				//讀出輸入串流
				InputStream in = item.getInputStream();
				//寫入輸出串流
				OutputStream writer = new FileOutputStream(saveFile);
				//寫入檔案
				byte[] tmp = new byte[1024];
				int len;
				while((len = in.read(tmp)) != -1){
					writer.write(tmp, 0, len);
				}
				writer.flush();
				writer.close();
				in.close();
			}
		}
   	}
}catch (Exception e) {
	out.print(e.toString());
}
//out.print(Path);
//if(true)return;
%>
<%
PreparedStatement preSMT01 = null;

//先取得檔案
File file = new File(Path+fileName);
Workbook workbook = getWorkbook(file);

//之後讀取excel
String[][] str = parse_excel(workbook);
out.print("總筆數："+str.length+"</br>");

//if(true)return;
//取得資料表欄位總數
SQL01 = "SELECT * FROM BKA003TEMP where 1=2";
ResultSet resultset = SMT01.executeQuery(SQL01);
ResultSetMetaData rsmd=resultset.getMetaData();
out.print(TBN+"TEMP欄位數："+rsmd.getColumnCount()+"</br>");

//if(true)return;
//先清空資料庫診所TEMP
SQL01 = "DELETE FROM BKA003TEMP WHERE BKA003001 = '"+URA001011C+"'";
SMT01.executeUpdate(SQL01);
//之後寫入資料庫

for(int i=1;i<str.length;i++){  //從第二筆開始
	if(str[i][0].equals("")){  //診所十碼章
		continue;  //跳過
	}
	//out.print("1."+str[i][0]);
	//if(true)return;
	try{
		SQL01 = "INSERT INTO BKA003TEMP VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
		preSMT01 =  CONN01.prepareStatement(SQL01);
		preSMT01.setString(1, str[i][0]);
		preSMT01.setString(2, str[i][1].replace("/",""));
		preSMT01.setString(3, str[i][2]);
		preSMT01.setString(4, str[i][3]);
		preSMT01.setString(5, str[i][4]);
		preSMT01.setString(6, str[i][5]);
		preSMT01.setString(7, str[i][6]);
		preSMT01.setString(8, str[i][7]);
		preSMT01.setString(9, str[i][8]);
		preSMT01.setString(10, (str[i][9].equals("開")?"1":"0"));
		preSMT01.setString(11, USERID);
		preSMT01.setString(12, SC01);
		preSMT01.setString(13, USERID);
		preSMT01.setString(14, SC01);
		preSMT01.setString(15, "");
		preSMT01.executeUpdate();
		preSMT01.close();
	}catch(SQLException e){
		e.printStackTrace();
		out.print(SQL01+"</br>");
		out.print("匯入BKA003TEMP：出現"+e.toString()+"錯誤訊息</br>");
	}catch(Exception e){
		e.printStackTrace();
		out.print("匯入BKA003TEMP：出現"+e.toString()+"錯誤訊息</br>");
	}
}

String sendurl = "BKB020100";
String sendmsg = "資料匯入發生錯誤";

//判斷BKA003TEMP匯入是否有誤
SQL01 = "SELECT BKA003001 FROM BKA003TEMP GROUP BY BKA003001";
RS01 = TAB01.buildMaps(SQL01);
if(RS01.length==1 && RS01[0].get("BKA003001").toString().equals(URA001011C)){  //只會有一筆對應十碼章且要等於正在匯入診所的十碼章
	String BKA002009 = "";
	String BKA002010 = "";
	SQL02 = "SELECT * FROM BKA002 WHERE BKA002001 = '"+BKA002001+"'";  //取得場次接種日期
	RS02 = TAB01.buildMaps(SQL02);
	if(RS02.length==1){
		BKA002009 = RS02[0].get("BKA002009").toString();
		BKA002010 = RS02[0].get("BKA002010").toString();
		
		//判斷日期是否有在接種時間內
		SQL03 = "SELECT BKA003002,TT FROM (SELECT BKA003002,CASE WHEN BKA003002 BETWEEN '"+BKA002009+"' AND '"+BKA002010+"' THEN '符合' ELSE '不符合' END AS 'TT' FROM BKA003TEMP)TAB01 WHERE TT = '不符合'";
		RS03 = TAB01.buildMaps(SQL03);
		if(RS03.length==0){
			//資料無誤，開始寫入BKA003
			try{
				//刪除原有的診所場次
				SQL01 = "DELETE FROM BKA003 WHERE BKA003002 = '"+BKA002001+"' AND BKA003003 = '"+URA001011C+"'";
				//out.print(SQL01);
				//if(true)return;
				preSMT01 =  CONN01.prepareStatement(SQL01);
				preSMT01.executeUpdate();
				preSMT01.close();
				
				SQL01 = "INSERT INTO BKA003 ";
				SQL01 += "SELECT ";
				SQL01 += "NEWID(),";  //產生SQL UUID
				SQL01 += "N'" + BKA002001 + "',";  //場次UUID
				SQL01 += "BKA003001,";  //十碼章
				SQL01 += "BKA003002,";  //接種日期
				SQL01 += "BKA003003,";  //開始時段-時
				SQL01 += "BKA003004,";  //開始時段-分
				SQL01 += "BKA003005,";  //結束時段-時
				SQL01 += "BKA003006,";  //開始時段-分
				SQL01 += "BKA003007,";  //類別
				SQL01 += "BKA003008,";  //疫苗種類及年齡組別
				SQL01 += "BKA003009,";  //數量
				SQL01 += "BKA003010,";  //是否開放
				SQL01 += "N'" + USERID + "',";  //建立者
				SQL01 += "N'" + SC01 + "',";
				SQL01 += "N'" + USERID + "',";  //最後修改者
				SQL01 += "N'" + SC01 + "',";
				SQL01 += "N'' ";  //備註
				SQL01 += "FROM BKA003TEMP";   //新增有寫入BKA003TEMP
				preSMT01 =  CONN01.prepareStatement(SQL01);
				preSMT01.executeUpdate();
				preSMT01.close();
				
				sendmsg = "資料匯入結束";
				
			}catch(SQLException e){
				e.printStackTrace();
				out.print(SQL01+"</br>");
				out.print("匯入BKA003：出現"+e.toString()+"錯誤訊息</br>");
			}catch(Exception e){
				e.printStackTrace();
				out.print("匯入BKA003：出現"+e.toString()+"錯誤訊息</br>");
			}
			
		}else{
			sendmsg="接種日期不符合，請檢視資料正確性";
		}
	}else{
		sendmsg="查無對應場次，請檢視資料正確性";
	}
	
}else{  //兩筆以上錯誤，不讓他匯
	sendmsg="資料十碼章有誤，請檢視資料正確性";
}

//if(true)return;
%>
<html lang="zh"> 
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>
<body>

<form id="form1" name="form1" method="post" action="">	
<input name="BKA002001" type="hidden" id="BKA002001" value="<%=BKA002001%>" />
<input name="BKA002002" type="hidden" id="BKA002002" value="<%=BKA002002%>" />

資料匯入結束，如有錯誤訊息請洽系統管理員
</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
<script>
Swal.fire({
	position: 'center',
	title: '<%=sendmsg%>',
	//showDenyButton: true,
	//showCancelButton: true,
	//denyButtonText:'',
	confirmButtonText:'返回匯入頁面',
	allowEscapeKey: false,
	allowOutsideClick: false
}).then((result) => {
	if (result.isConfirmed) {
		form1.target = "_self";
		form1.action = "<%=sendurl%>.jsp";
		form1.submit();
	} else if (result.isDenied) {
		return;
	}
});
</script>
</body>
</html>
<%
DB01.close();
%>