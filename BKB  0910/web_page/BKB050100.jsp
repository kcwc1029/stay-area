<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
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
%>
<%
SQL01 = "SELECT * FROM BKA001"; //宣告SQL語法
RS01 = TAB01.buildMaps(SQL01);
%>
<%
String BKA001004S = "";
String BKA001006S = "";
String TT[][]  = new String[RS01.length+1][11];
String FNAME = "疫苗資訊清冊";
TT[0][0]= "疫苗類別";
TT[0][1]= "疫苗種類";
TT[0][2]= "年齡區間";
TT[0][3]= "前1劑種類";
TT[0][4]= "第0劑與第1劑間隔時間";
TT[0][5]= "第1劑與第2劑間隔時間";
TT[0][6]= "第2劑與第3劑間隔時間";
TT[0][7]= "第3劑與第4劑間隔時間";
TT[0][8]= "第4劑與第5劑間隔時間";
TT[0][9]= "第5劑與第6劑間隔時間";
TT[0][10]= "年次或足歲";
for(int A=0;A<RS01.length;A++){
	BKA001004S = RS01[A].get("BKA001004").toString();
	if(RS01[A].get("BKA001004").toString().equals("0")){
		BKA001004S = RS01[A].get("BKA001004").toString()+"."+RS01[A].get("BKA001005").toString();
	}
	BKA001006S = RS01[A].get("BKA001006").toString();
	if(RS01[A].get("BKA001006").toString().equals("0")){
		BKA001006S = RS01[A].get("BKA001006").toString()+"."+RS01[A].get("BKA001007").toString();
	}
	if(BKA001006S.equals("999")){
		BKA001006S = "無限期";
	}
	TT[A+1][0]= RS01[A].get("BKA001002").toString();
	TT[A+1][1]= RS01[A].get("BKA001003").toString();
	TT[A+1][2]= BKA001004S+"~"+BKA001006S;
	TT[A+1][3]= RS01[A].get("BKA001008").toString();
	TT[A+1][4]= RS01[A].get("BKA001009").toString()+"天";
	TT[A+1][5]= RS01[A].get("BKA001010").toString()+"天";
	TT[A+1][6]= RS01[A].get("BKA001011").toString()+"天";
	TT[A+1][7]= RS01[A].get("BKA001012").toString()+"天";
	TT[A+1][8]= RS01[A].get("BKA001013").toString()+"天";
	TT[A+1][9]= RS01[A].get("BKA001014").toString()+"天";
	TT[A+1][10]= RS01[A].get("BKA001015").toString();
	
}
session.setAttribute("TT_A", TT);
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
	<div class="container-fuild px-4">
		<h3 class="mt-4">疫苗資訊管理</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">疫苗資訊管理</li>
		</ol>
		
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						疫苗資訊維護
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-xl-12 mt-2">
								<label for="BKA001" class="form-label text-deepgreen fw-bold">請選擇匯入檔案<span class="text-danger ms-1">*</span></label>
								<div class="input-group">
									<input class="form-control validate[required]" accept=".xls,.xlsx" type="file" id="BKA001" name="BKA001">
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB050199','_self')"><i class="fa fa-plus me-1"></i>匯入</button>
								</div>
							</div>
						</div>

						<div class="row mt-3">
							<div class="col-xl-12 mt-3" align="right">
								<button type="button" class="btn btn-light border-secondary" onClick="outQfile()"><i class="far fa-arrow-alt-circle-down me-2"></i>匯出表單</button>
							</div>
						</div>
						
						<div class="table-responsive mt-1">
							<table class="table table-striped table-bordered">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">疫苗類別</th>
								  <th scope="col">疫苗種類</th>
								  <th scope="col">年齡區間</th>
								  <th scope="col">前1劑<br>種類</th>
								  <th scope="col">第0劑與第1劑<br>間隔時間</th>
								  <th scope="col">第1劑與第2劑<br>間隔時間</th>
								  <th scope="col">第2劑與第3劑<br>間隔時間</th>
								  <th scope="col">第3劑與第4劑<br>間隔時間</th>
								  <th scope="col">第4劑與第5劑<br>間隔時間</th>
								  <th scope="col">第5劑與第6劑<br>間隔時間</th>
								  <th scope="col">年次/足歲</th>
								</tr>
							  </thead>
							  <tbody align="center">
								<%
								for(int A=1;A<TT.length;A++){
								%>
								<tr>
								  <th scope="row"><%=TT[A][0]%></th>
								  <td><%=TT[A][1]%></td>
								  <td><%=TT[A][2]%>
								  <td><%=TT[A][3]%></td>
								  <td><%=TT[A][4]%></td>
								  <td><%=TT[A][5]%></td>
								  <td><%=TT[A][6]%></td>
								  <td><%=TT[A][7]%></td>
								  <td><%=TT[A][8]%></td>
								  <td><%=TT[A][9]%></td>
								  <td><%=TT[A][10]%></td>
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
<input type="hidden" name="FNAME" id="FNAME" value="<%=FNAME%>">
<input type="hidden" name="T1" id="T1" value="<%=TT.length%>">
<input type="hidden" name="T2" id="T2" value="<%=TT[0].length%>">
<input type="hidden" name="T3" id="T3" value="TT_A">
</form>

<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
	
<script type="text/javascript">
function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}
function SF02(A, B){
	var re = /\.(xls|xlsx)$/i;  //允許的副檔名
	if(!re.test(document.getElementById("BKA001").value)){
	  alert("允許上傳檔案(xls、xlsx)!!"); 
	  return;
	}
	if(form1.BKA001.value==""){
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
function outQfile(){
    form2.target = "_new";
    form2.action = "../web_script/outExcel.jsp";
    form2.submit();
}
</script>

</body>
</html>
