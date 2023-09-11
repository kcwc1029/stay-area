<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
//取得日期
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
Map[] RS03 = null;
String SQL03 = "";
%>
<%
String BKA002001 = SQLIJ(request.getParameter("BKA002001"));
String BKA002002 = SQLIJ(request.getParameter("BKA002002"));
SQL01 = "SELECT * FROM BKA002 WHERE BKA002001 = '"+BKA002001+"' AND BKA002002 = '"+BKA002002+"' AND BKA002004 = '1'";  //只限開放
RS01 = TAB01.buildMaps(SQL01);
if(RS01.length==0){
	out.print("查無場次資料，請洽管理員");
	return;
}

//取得時間
SimpleDateFormat date02= new SimpleDateFormat("yyyyMMddHHmm");
String SC0102 = date02.format(new Date());
String CHK = "OFF";
if(Double.parseDouble(SC0102) >= Double.parseDouble(RS01[0].get("BKA002005").toString()) && Double.parseDouble(SC0102) <= Double.parseDouble(RS01[0].get("BKA002006").toString())){
	CHK = "ON";
}
//out.print(CHK);

String BKA003902 = "";
SQL02 = "SELECT * FROM BKA003 INNER JOIN BKA007 ON BKA003003 = BKA007001 WHERE BKA003002 = '"+BKA002001+"' AND BKA003003 = '"+URA001011C+"' ORDER BY BKA003004";  //只限開放
RS02 = TAB01.buildMaps(SQL02);
if(RS02.length!=0 && RS02[0].get("BKA003902").toString().length() >= 12){
	BKA003902 = EYC2(RS02[0].get("BKA003902").toString().substring(0,8))+"&emsp;"+RS02[0].get("BKA003902").toString().substring(8,10)+":"+RS02[0].get("BKA003902").toString().substring(10,12);
}	
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>
<body class="sb-nav-fixed">
<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
<input name="BKA002001" type="hidden" id="BKA002001" value="<%=BKA002001%>" />
<input name="BKA002002" type="hidden" id="BKA002002" value="<%=BKA002002%>" />

	<div class="container px-4">
		<div class="d-flex justify-content-between">
		  <div>
			<h3 class="mt-4">批次匯入接種數量</h3>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item" aria-current="page">選擇匯入場次</li>
			<li class="breadcrumb-item active" aria-current="page">批次匯入接種數量</li>
			</ol>
		  </div>
		  <div class="mt-5">
			<button type="button" class="btn btn-sm btn-light border-secondary" onClick="javascript:document.location.href='BKB020101.jsp'"><i class="fas fa-reply me-2"></i>回上頁</button>
		  </div>
		</div>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold h5">
						<i class="fas fa-file-import me-1"></i>
						匯入場次：<%=RS01[0].get("BKA002003").toString()%>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-xl-12 mt-2">
								<label for="formFile" class="form-label text-deepgreen fw-bold">請選擇匯入檔案<span class="text-danger ms-1">*</span></label>
								<div class="input-group">
									<a class="btn btn-danger border-secondary text-white" href="../web_download/疫苗預約系統2.0範例檔案.xlsx"><i class="fas fa-arrow-circle-down me-1"></i>下載範例檔案</a>
									<input class="form-control validate[required]" type="file" id="BKA003" name="BKA003" <%=CHK.equals("ON")?"":"disabled"%>>
									<button type="button" class="btn btn-green border-secondary" onClick="SF02('BKB020199','_self')" <%=CHK.equals("ON")?"":"disabled"%>><i class="fa fa-plus me-1"></i>匯入</button>
								</div>
							</div>
						</div>
						<div class="alert alert-secondary fw-bold" role="alert">
						  僅有匯入期間可批次匯入或單筆維護接種資料。<br>
						  <span class="text-danger">匯入時間截止後</span>，僅能針對未到達日期、時段進行<span class="text-danger">預約開關調整。</span>
						</div>
						<div class="row mt-5">
							<div class="col-xl fw-bold" align="left">匯入時間：<%=BKA003902%></div>
							<div class="col-xl" align="right">
								<%if(CHK.equals("ON")){%>
								<button type="button" class="btn btn-light border-secondary" onClick="SF01('BKB020102','_self')"><i class="fas fa-plus me-2"></i>單筆新增接種資料</button>
								<%}%>
								<button type="button" class="btn btn-primary border-secondary" onClick="SF05('BKB020105','_self')">儲存開放預約調整</button>
							</div>
						</div>
						<div class="table-responsive mt-1">
							<table class="table table-bordered table-hover">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">接種院所</th>
								  <th scope="col">接種日期</th>
								  <th scope="col">接種時段</th>
								  <th scope="col">疫苗類別</th>
								  <th scope="col">疫苗種類及年齡組別</th>
								  <th scope="col">數量</th>
								  <th scope="col">修改</th>
								  <th scope="col">刪除</th>
								  <th scope="col" width="8%">開放預約
									<div class="form-check form-switch">
									  <%
									  String CHKAll = "OFF";
									  SQL03 = "SELECT BKA003012 FROM BKA003 INNER JOIN BKA007 ON BKA003003 = BKA007001 WHERE BKA003002 = '"+BKA002001+"' AND BKA003003 = '"+URA001011C+"' GROUP BY BKA003012";  //只限開放
									  RS03 = TAB01.buildMaps(SQL03);
									  if(RS03.length == 1 && RS03[0].get("BKA003012").toString().equals("1")){
										  CHKAll = "ON";
									  }
									  %>
									  <input class="form-check-input" type="checkbox" id="CheckAll" name="CheckAll" <%=CHKAll.equals("ON")?"checked":""%>>
									</div>
								  </th>
								</tr>
							  </thead>
							  <tbody align="center">
								<%
								String BKA003004Y = "";
								String BKA003YH = "";
								for(int A=0;A<RS02.length;A++){
									BKA003004Y = RS02[A].get("BKA003004").toString();
									if(BKA003004Y.length() >= 8){
										BKA003004Y = EYC2(BKA003004Y);
									}
									BKA003YH = RS02[A].get("BKA003005").toString()+":"+RS02[A].get("BKA003006").toString()+"-"+RS02[A].get("BKA003007").toString()+":"+RS02[A].get("BKA003008").toString();
								%>
								<tr>
								  <th scope="row"><%=RS02[A].get("BKA007003").toString()%></th>
								  <td><%=BKA003004Y%></td>
								  <td><%=BKA003YH%></td>
								  <td><%=RS02[A].get("BKA003009").toString()%></td>
								  <td><%=RS02[A].get("BKA003010").toString()%></td>
								  <td><%=RS02[A].get("BKA003011").toString()%></td>
								  <td><%if(CHK.equals("ON")){%><button type="button" class="btn btn-warning btn-sm" onclick="SF03('BKB020102','_self','<%=RS02[A].get("BKA003001").toString()%>')"><i class="fas fa-pen"></i></button><%}%></td>
								  <td><%if(CHK.equals("ON")){%><button type="button" class="btn btn-danger btn-sm" onclick="SF04('BKB020104','_self','<%=RS02[A].get("BKA003001").toString()%>')"><i class="fas fa-minus"></i></button><%}%></td>
								  <td>
									<div class="form-check form-switch" align="center">
									  <input type="hidden" id="BKA003001S1<%=A+1%>" name="BKA003001S1" value="<%=RS02[A].get("BKA003001").toString()%>" >
									  <input class="form-check-input BKA003" type="checkbox" id="BKA003012S1<%=A+1%>" name="<%=RS02[A].get("BKA003001").toString()%>" value="1" <%=RS02[A].get("BKA003012").toString().equals("1")?"checked":""%>>
									</div>
								  </td>
								</tr>
								<%
								}
								%>
							  </tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
</form>
<form id="form2" name="form2" method="post" action="">
<input name="BKA002001" type="hidden" id="BKA002001" value="<%=BKA002001%>" />
<input name="BKA002002" type="hidden" id="BKA002002" value="<%=BKA002002%>" />
<input name="BKA003001" type="hidden" id="BKA003001" value="" />
<input name="SENDURL" type="hidden" id="SENDURL" value="BKB020100" />
<%for(int A=0;A<RS02.length;A++){%>
<input type="hidden" id="BKA003001S<%=A+1%>" name="BKA003001S" value="<%=RS02[A].get("BKA003001").toString()%>" >
<input class="form-check-input" type="hidden" id="BKA003012S<%=A+1%>" name="<%=RS02[A].get("BKA003001").toString()%>" value="<%=RS02[A].get("BKA003012").toString()%>">
<%}%>
</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
	
<script type="text/javascript">
function SF01(A, B){
  form2.target = B;
  form2.action = A + ".jsp";
  form2.submit();
}

function SF02(A, B){
	var re = /\.(xls|xlsx)$/i;  //允許的副檔名
	if(!re.test(document.getElementById("BKA003").value)){
	  alert("允許上傳檔案(xls、xlsx)!!"); 
	  return;
	}
	if(form1.BKA003.value==""){
		alert("請先選擇要匯入的檔案");
		return;
	}
	Swal.fire({
		position: 'center',
		title: '您確定要匯入嗎？',
		showDenyButton: true,
		//showCancelButton: true,
		denyButtonText:'取消匯入',
		confirmButtonText:'確定',
		allowEscapeKey: false,
		allowOutsideClick: false
	}).then((result) => {
		if (result.isConfirmed) {
			//document.getElementById("form1").enctype = "multipart/form-data";
			form1.target = B;
			form1.action = A + ".jsp";
			form1.submit();
		} else if (result.isDenied) {
			return;
		}
	});
}
function SF03(A, B, C){
  form2.BKA003001.value = C;
  form2.target = B;
  form2.action = A + ".jsp";
  form2.submit();
}
function SF04(A, B, C){
  Swal.fire({
		position: 'bottom',
		title: '您確定要刪除嗎？',
		showDenyButton: true,
		//showCancelButton: true,
		denyButtonText:'取消',
		confirmButtonText:'確定',
		allowEscapeKey: false,
		allowOutsideClick: false
	}).then((result) => {
		if (result.isConfirmed) {
			form2.BKA003001.value = C;
		    form2.target = B;
		    form2.action = A + ".jsp";
		    form2.submit();
		} else if (result.isDenied) {
			return;
		}
	});
}
<%for(int A=0;A<RS02.length;A++){%>
//form1 == form2
$("#BKA003012S1<%=A+1%>").click(function(){
	var checkis = $(this).is(":checked");
	if(checkis == true){
		//alert("123");
		form2.BKA003012S<%=A+1%>.value = form1.BKA003012S1<%=A+1%>.value;
	}else if(checkis == false){
		form2.BKA003012S<%=A+1%>.value = "0";
	}
});	
<%}%>
function SF05(A, B){
  form2.target = B;
  form2.action = A + ".jsp";
  form2.submit();
}

$("#CheckAll").click(function(){
	if($("#CheckAll").prop("checked")){//如果全選按鈕有被選擇的話（被選擇是true）
		$(".BKA003").each(function(){
			$(this).prop("checked",true);//把所有的核取方框的property都變成勾選
			<%for(int A=0;A<RS02.length;A++){%>
			form2.BKA003012S<%=A+1%>.value = form1.BKA003012S1<%=A+1%>.value;
			<%}%>
		})
	}else{
		$(".BKA003").each(function(){
			$(this).prop("checked",false);//把所有的核方框的property都取消勾選
			<%for(int A=0;A<RS02.length;A++){%>
			form2.BKA003012S<%=A+1%>.value = "0";
			<%}%>
		})
	}
})
function PG01(A,B){
	form2.PNO01.value=A;
	form2.target="_self";
	form2.action=B;
	form2.submit();
}
</script>

</body>
</html>
