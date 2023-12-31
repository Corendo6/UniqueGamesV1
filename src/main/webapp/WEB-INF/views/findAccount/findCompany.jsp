<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findAccount</title>
<link rel="stylesheet" href="http://localhost:9000/uniquegames/css/login.css">
<script src="http://localhost:9000/uniquegames/js/jquery-3.6.4.min.js"></script>
<script>
//JavaScript 코드
document.addEventListener('DOMContentLoaded', function() {
    // URL에서 selectedTab 파라미터 값을 가져옴
    var urlParams = new URLSearchParams(window.location.search);
    var selectedTab = urlParams.get('selectedTab');
    
    
    // 선택한 탭을 표시
    if (selectedTab) {
        document.getElementById(selectedTab).checked = true;
    }
});

	let c = "${find_result }";
	if(c == "fail"){
		alert("등록된 회원정보가 없습니다");
		location.href="findCompany.do";
	}
</script>
<script>
	$(document).ready(function(){
		 
	$("#button-gradient").click(function(){
			
			if($("input[name='name']").val()==""){
				alert("이름을 입력해주세요");
				$("input[name='name']").focus();
				return false;
			}else if($("input[name='phone_num']").val()==""){
				alert("휴대전화를 입력해주세요");
				$("input[name='phone_num']").focus();
				return false;
			}else {
				$.ajax({
					url : "cfindId_check.do",
					type : "POST",
					data : {
						name : $("input[name='name']").val(),
						phone_num :$("input[name='phone_num']").val()
					},
					
					success : function(result) {
						if(result=="") {
							$("#modal2").show();
							$("#agreement-content1").html($(".find-id-none").html());
						}else {
							$("#modal2").show();
							$("#find-id-result").html(result);
							$("#agreement-content1").html($(".deleteComplete").html());
						}
					}
				});
			}
		});
		
	$("#button-gradient-findPwd").click(function(){
			
			if($("input[name='company_id']").val()==""){
				alert("아이디를 입력해주세요");
				$("input[name='company_id']").focus();
				return false;
			}else if($("#input-common-name").val()==""){
				alert("이름을 입력해주세요");
				$("#input-common-name").focus();
				return false;
			}else if($("#input-common-phone").val()==""){
				alert("휴대전화를 입력해주세요");
				$("#input-common-phone").focus();
				return false;
			}else {
				cfindPwdForm.submit();
			}
		});
		
		
		$(document).on("click", "#button-gradient-gotoFind", function(event){

			$("#modal2").hide();
			$("input[name='name']").val("").focus();
			$("input[name='member_id']").val("").focus();
			$("input[name='phone_num']").val("");
			
			
			});
		
		$(document).on("click", "#button-gradient-gotoPwd", function(event){

			$("#modal2").hide();
			location.href="http://localhost:9000/uniquegames/findCompany.do?selectedTab=findPwd";
			
			});
		$(document).on("click", "#button-gradient-gotoLogin", function(event){

			$("#modal2").hide();
			location.href="http://localhost:9000/uniquegames/login.do?selectedTab=company-login";
			
			});
		
		$(document).on("click", "#button-gradient-gotoJoin", function(event){

			$("#modal2").hide();
			location.href="http://localhost:9000/uniquegames/join.do?selectedTab=company";
			
			});
		
	})

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
	<section id="content-1"><!-- find-id -->
		<p id="intro">법인 회원</p>
			<input id="findId" type="radio" name="findAccount" checked>
			<label for="findId" id="findId-tab">아이디 찾기</label>
			<input id="findPwd" type="radio" name="findAccount">
			<label for="findPwd" id="findPwd-tab">비밀번호 찾기</label>
			
			<form action="cfindId_check.do" name="cfindIdForm" method="post" id="findIdForm">
				<ul>
					<li>
						<input type="text" id="input-common" name="name" placeholder="이름">
						<span id="msgName"></span>
					</li>
					<li>
						<input type="text" id="input-common" name="phone_num" placeholder="휴대전화">
						<span id="msgPhone"></span>
					</li>
					<li>
						<button type="button" id="button-gradient">아이디 찾기</button>
					</li>
				</ul>
			</form>
			
			<form action="cfindPwd_check.do" name="cfindPwdForm" method="post" id="findPwdForm">
				<p id="intro-2">비밀번호를 찾으려는 아이디</p>
				<ul>
					<li>
						<input type="text" id="input-common" name="company_id" placeholder="아이디">
						<span id="msgId"></span>
					</li>
					<li>
						<input type="text" id="input-common-name" name="name" placeholder="이름">
						<span id="msgName1"></span>
					</li>
					<li>
						<input type="text" id="input-common-phone" name="phone_num" placeholder="휴대전화">
						<span id="msgPhone1"></span>
					</li>
					<li>
						<button type="button" id="button-gradient-findPwd">비밀번호 찾기</button>
					</li>
				</ul>
			</form>
	</section>
	
	<div id="modal2">
		<div class="agreement2" id="agreement-findId">
			<div id="agreement-content1">
			</div>
		</div>
	</div>
	
	<div class="deleteComplete">
		<p id="agreement-title">아이디 찾기</p>
		<span id="delete-span">아이디 : 
		<span id="find-id-result"></span>
		</span>
		<ul>
			<li>
				<button type="button" id="button-gradient-gotoLogin" name="btn-agreement">로그인 하러가기</button>
				<button type="button" id="button-gradient-gotoPwd" name="btn-agreement">비밀번호 찾기</button>
			</li>
		</ul>
	</div>
	<div class="find-id-none">
		<p id="agreement-title">아이디 찾기</p>
		<span id="delete-span">등록된 아이디가 없습니다</span>
		<ul>
			<li>
				<button type="button" id="button-gradient-gotoFind" name="btn-agreement">다시입력</button>
				<button type="button" id="button-gradient-gotoJoin" name="btn-agreement">회원가입</button>
			</li>
		</ul>
	</div>
	
	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>