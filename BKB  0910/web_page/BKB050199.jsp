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
Map[] RS02 = null; //將篩選出來的資料放到陣列中
String SQL01 = "";
String SQL02 = "";
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
String TBN = "BKA001";  //資料表名稱
String BKA001 = "";
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
			if(item.getFieldName().equals("BKA001")){
				BKA001=item.getString("UTF-8");
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
SQL01 = "SELECT * FROM "+TBN+" where 1=2";
ResultSet resultset = SMT01.executeQuery(SQL01);
ResultSetMetaData rsmd=resultset.getMetaData();
out.print(TBN+"欄位數："+rsmd.getColumnCount()+"</br>");
int j =rsmd.getColumnCount();
for(int k=0;k<j;k++){
	SQL02 += ",?";
}
SQL02 = SQL02.substring(1);
out.print(SQL02+"</br>");
//if(true)return;
//先清空資料庫TEMP
SQL01 = "TRUNCATE TABLE "+TBN;
SMT01.executeUpdate(SQL01);
//之後寫入資料庫

for(int i=1;i<str.length;i++){  //從第二筆開始
	if(str[i][1].equals("")){  //疫苗類別
		continue;  //跳過
	}
	str[i][0] = UUID.randomUUID().toString();  //UUID
	str[i][15] = USERID;  //建置人
	str[i][16] = SC01;  //建置時間
	str[i][17] = USERID;  //修改人
	str[i][18] = SC01;  //修改時間
	str[i][19] = "";
	//out.print("1."+str[i][0]);
	//if(true)return;
	try{
		SQL01 = "INSERT INTO "+TBN+" VALUES("+SQL02+") ";
		preSMT01 =  CONN01.prepareStatement(SQL01);
		for(int k=0;k<j;k++){
			preSMT01.setString(k+1, str[i][k]);
		}
		preSMT01.executeUpdate();
		preSMT01.close();
	}catch(SQLException e){
		e.printStackTrace();
		out.print(SQL01+"</br>");
		out.print("匯入"+TBN+"：出現"+e.toString()+"錯誤訊息</br>");
	}catch(Exception e){
		e.printStackTrace();
		out.print("匯入"+TBN+"：出現"+e.toString()+"錯誤訊息</br>");
	}
}
//if(true)return;
String sendurl = "BKB050100";
String sendmsg="資料匯入結束";
//if(true)return;
%>
<html lang="zh"> 
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>
<body>

<form id="form1" name="form1" method="post" action="">	
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