<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
 
	<script src="../web_js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="../web_js/jquery.3.1.0.validationEngine.min.js" type="text/javascript" ></script>
    <script src="../web_js/jquery.3.1.0.validationEngine-zh_TW.js" type="text/javascript"></script>
    <script src="../web_js/bootstrap.bundle.min.js"></script>
	<script src="../web_js/scripts.js"></script>
    <script src="../web_js/jquery-ui.js"></script>
	<script src="../web_js/ChineseYearDatepicker.js"></script>
    <script src="../web_js/sweetalert2.all.min.js"></script>
	<script src="../web_js/pdfjs/build/pdf.js"></script>
	<script src="../web_js/web_basic.js" type="text/javascript"></script>
	<script src="../web_js/aos-master/dist/aos.js" type="text/javascript"></script>
	<script src="../web_js/loaders.css.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		//表單驗證
		jQuery(document).ready(function(){
		// binds form submission and fields to the validation engine
			jQuery('#form1').validationEngine();
		});
	</script>