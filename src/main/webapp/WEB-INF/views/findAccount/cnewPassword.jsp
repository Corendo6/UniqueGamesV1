<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/uniquegames/css/login.css">
<script src="http://localhost:9000/uniquegames/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	
	var password = "${password}";
	
	
	$("#button-gradient").click(function(){
		
		if($("input[name='cnewpassword']").val()==""){
			alert("새 비밀번호를 입력하세요");
			$("input[name='cnewpassword']").focus();
			return false;
		}else if($("input[name='cnewpassword-check']").val()==""){
			alert("새 비밀번호 확인칸을 입력하세요");
			$("input[name='cnewpassword-check']").focus();
			return false;
		}else if($("input[name='cnewpassword']").val() != $("input[name='cnewpassword-check']").val()){
			alert("비밀번호가 동일하지 않습니다");
			$("input[name='cnewpassword-check']").focus();
			return false;
		}else if($("input[name='cnewpassword']").val() && $("input[name='cnewpassword-check']").val() === password){
			alert("기존 비밀번호와 동일하게 변경할 수 없습니다");
			$("input[name='cnewpassword']").focus();
			return false;
		}else {
			cChangePassword.submit();
		}
	
	});
	
	$("#pwd-check-img").change(function(){

		if($("#pwd-check-img").is(":checked") == false) {
			$("input[name='cnewpassword']").attr("type","password");
		}else if($("#pwd-check-img").is(":checked") == true) {
			$("input[name='cnewpassword']").attr("type","text");
		}
		
	});
	
	$("#pwd-check-img-1").change(function(){

		if($("#pwd-check-img-1").is(":checked") == false) {
			$("input[name='cnewpassword-check']").attr("type","password");
		}else if($("#pwd-check-img-1").is(":checked") == true) {
			$("input[name='cnewpassword-check']").attr("type","text");
		}
		
	});
	
});
</script>
</head>
<body>
	<header>
		<jsp:include page="../main/header.jsp"></jsp:include>	
	</header>
	<section id="top-bg">
		<div id="base-layer">
			<div id="top-bg-textarea">
				<p id="top-title">Login</p>
				<p id="top-subtitle">#로그인</p>
			</div>
		</div>
	</section>
	<section id="content-1">
		<p id="intro">법인 회원</p>
		<form action="cChangePassword.do" name="cChangePassword" method="post" id="newPasswordForm">
			<ul>
				<li>
					<input type="password" id="input-common" name="cnewpassword" placeholder="새로운 비밀번호">
					<input type="checkbox" id="pwd-check-img">
					<input type="hidden" name="company_id" value="${company_id }">
				</li>
				<li>
					<input type="password" id="input-common" name="cnewpassword-check" placeholder="새로운 비밀번호 확인">
					<input type="checkbox" id="pwd-check-img-1">
					<span id="msgPassword"></span>
				</li>
				<li>
					<button type="button" id="button-gradient">수정하기</button>
				</li>
			</ul>
		</form>
	</section>

	<jsp:include page="../main/footer.jsp"></jsp:include>

</body>
</html>