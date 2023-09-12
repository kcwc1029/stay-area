<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>

<style>
.dropdown-menu li:hover .sub-menu {visibility: visible;}
.dropdown:hover .dropdown-menu {display: block;}
</style>

<a id="gotocenter" href="#C" title="跳到主要內容" class="sr-only sr-only-focusable" style="z-index:5;position:fixed">跳到主要內容</a>

<div class="pe-4" style="background-color:#4e4e4e">
	<div class="d-flex justify-content-end">
		<div class="mr-3 text-white">
			
			</%
			if(session.getAttribute("USERID")==null){
			%>
			<a class="transform1 text-white p-1" href="../web_page/memlogin.jsp" title="登入" style="text-decoration:none;">
				<small><i class="far fa-user-circle me-2"></i>登入</small>
			</a>
			<//%
			}else{
				//login_info = "("+session.getAttribute("USERNAME")+"/"+session.getAttribute("USERKIND")+"/"+session.getAttribute("URA001010")+")";
			%>
			<//%=URA001011N+USERNAME%> 您好｜
			<a class="transform1 text-white p-1" href="../web_page/logout.jsp" title="登出" style="text-decoration:none;">
				<small><i class="far fa-user-circle me-2"></i>登出</small>
			</a>
			<//%}%>
		</div>
	</div>
</div>

<nav class="navbar navbar-expand-lg border-bottom bg-light shadow">
	<div class="container-fluid">
		<a class="navbar-brand text-deepgreen fw-bold" title="" href="../index.jsp">
			<!--<img src="../web_img/LOGO-01.png" class="logosize" alt="" title="">-->
			疫苗接種預約管理系統2.0
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"  aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">			
			<ul class="navbar-nav mt-1 me-5">
				<li class="nav-item dropdown me-4">
					<a class="nav-link dropdown-toggle text-deepgreen fw-bold" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button"><i class="fas fa-cog me-2"></i>場次管理</a>
						<ul class="dropdown-menu" aria-labelledby="">
							<li><a class="dropdown-item" href="../web_page/BKB030100.jsp">場次管理</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB030200.jsp">場次量能查詢</a></li>
						</ul>
					</a>
				</li>
				<li class="nav-item dropdown me-4">
					<a class="nav-link dropdown-toggle text-deepgreen fw-bold" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button"><i class="fas fa-check-double me-2"></i>量能管理</a>
						<ul class="dropdown-menu" aria-labelledby="">
							<li><a class="dropdown-item" href="../web_page/BKB020101.jsp">維護接種量能</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB020300.jsp">預約方式維護</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB020200.jsp">預約查詢</a></li>
						</ul>
					</a>
				</li>
				<li class="nav-item dropdown me-4">
					<a class="nav-link dropdown-toggle text-deepgreen fw-bold" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button"><i class="fas fa-box-open me-2"></i>物資管理</a>
						<ul class="dropdown-menu" aria-labelledby="">
							<li><a class="dropdown-item text-success fw-bold disabled" href="#!">物資庫存</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB060100.jsp">庫存維護管理</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB060102.jsp">庫存匯入</a></li>
							<div class="dropdown-divider"></div>
							<li><a class="dropdown-item text-success fw-bold disabled" href="#!">物資撥出</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB060300.jsp">物資撥出管理</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB060200.jsp">物資撥出匯入</a></li>
							<div class="dropdown-divider"></div>
							<li><a class="dropdown-item text-success fw-bold disabled" href="#!">發放管理</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB060400.jsp">醫療院所發放數量匯入</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB060500.jsp">醫療院所發放數量管理</a></li>
						</ul>
					</a>
				</li>
				<li class="nav-item dropdown me-4">
					<a class="nav-link text-deepgreen fw-bold" href="BKB040100.jsp" role="button"><i class="fas fa-list-ul me-2"></i>報表匯出</a>
				</li>
				<li class="nav-item dropdown me-5">
					<a class="nav-link dropdown-toggle text-deepgreen fw-bold" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button"><i class="fas fa-users-cog me-2"></i>系統管理</a>
						<ul class="dropdown-menu" aria-labelledby="">
							<li><a class="dropdown-item" href="../web_page/CLA030103.jsp">院所資料</a></li>
							<li><a class="dropdown-item" href="../web_page/BKB050100.jsp">疫苗資訊管理</a></li>
							<li><a class="dropdown-item" href="../web_admin/THA210100.jsp">使用者權限管理</a></li>			  
							<li><a class="dropdown-item" href="../web_admin/THA210600.jsp">使用者紀錄</a></li>
						</ul>
					</a>
				</li>
			</ul>
		</div>
	</div>
<hr>
</nav>


<!--漢堡選單結束-->

<script type="text/javascript">
function SF99(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}
</script>