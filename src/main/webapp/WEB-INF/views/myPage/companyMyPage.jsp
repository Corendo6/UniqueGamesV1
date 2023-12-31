<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myPage</title>
	<link rel="stylesheet" href="http://localhost:9000/uniquegames/css/login.css">
	<script src="http://localhost:9000/uniquegames/js/jquery-3.6.4.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
	$(document).ready(function(){
		var password = "${companyVo.password}";
		var password = "${companyVo.password}";
		var phone1 = "${companyVo.phone1}";
		var phone2 = "${companyVo.phone2}";
		var phone3 = "${companyVo.phone3}";
		var email1 = "${companyVo.email1}";
		var email2 = "${companyVo.email2}";
		
		function emailCheck(asValue){
			var regex = /[A-za-z0-9]{4,20}$/;
			
			return regex.test(asValue);
		}
		
		function phoneCheck(asValue) {
			var regex = /^\d{3,4}$/;
			
			return regex.test(asValue);
		}
		
		$("#button-gradient-company").click(function(){
			
			if($("input[name='company_id']").val()==""){
				alert("회사 아이디는 필수 입력 항목입니다");
				$("input[name='company_id']").focus();
				return false;
			}else if($("#company-password").val()==""){
				alert("비밀번호는 필수 입력 항목입니다");
				$("#company-password").focus();
				return false;
			}else if($("#company-password").val() != password){
				alert("비밀번호가 일치하지 않습니다");
				$("#company-password").focus();
				return false;
			}else if($("#company-name").val()==""){
				alert("회사명은 필수 입력 항목입니다");
				$("#company-name").focus();
				return false;
			}else if($("#company-email1").val()==""){
				alert("이메일은 필수 입력 항목입니다");
				$("#company-email1").focus();
				return false;
			}else if(!emailCheck($("#company-email1").val())){
				alert("이메일은 영문 또는 숫자로 4자리 이상 입력해주세요");
				$("#company-email1").focus();
				return false;
			}else if($("#company-email2").val()=="" && $("#company-selectbox-email").val()=="choose" || $("#company-email2").val()=="" && $("#company-selectbox-email").val()=="direct"){
				alert("이메일 주소를 전부 작성해주세요");
				$("#company-email2").focus();
				return false;
			}else if($("#c-emailAuth").css("color") === "rgb(255, 0, 0)") {
				alert("이메일 인증번호를 확인해주세요");
				$("#email-auth-check").focus();
				return false;
			}else if($("#company-selectbox-mobile").val()=="choose") {
				alert("통신사를 선택해주세요");
				$("#selectbox-mobile").focus();
				return false;
			}else if($("#company-selectbox-phone").val()=="choose") {
				alert("대표 전화는 필수 입력 항목입니다");
				$("#company-selectbox-phone").focus();
				return false;
			}else if($("#company-phone2").val()=="") {
				alert("대표 전화는 필수 입력 항목입니다");
				$("#company-phone2").focus();
				return false;
			}else if(!phoneCheck($("#company-phone2").val())) {
				alert("대표 전화는 숫자 3,4자리로 입력해주세요");
				$("#company-phone2").focus();
				return false;
			}else if($("#company-phone3").val()=="") {
				alert("대표 전화는 필수 입력 항목입니다");
				$("input[name='phone3']").focus();
				return false;
			}else if(!phoneCheck($("#company-phone3").val())) {
				alert("대표 전화는 숫자 3,4자리로 입력해주세요");
				$("#company-phone3").focus();
				return false;
			}else if($("#c-phoneMsg").text() != ""){
				alert("휴대전화를 확인해주세요");
				$("#selectbox-phone").focus();
				return false;
			}else {
				companyMyPageForm.submit();
			}
		});
		
		$("#company-selectbox-email").change(function(){
			
			if($("#company-selectbox-email").val()=="choose") {
				$("#company-email2").val("");
				$("#emailMsg").text("이메일을 선택해주세요").css("color","red").css("font-size","11px").css("display","inline");
				$("#company-selectbox-email").focus();
				return false;
			}else if($("#company-selectbox-email").val()=="direct") {
				$("#company-email2").val("").focus();
			}else {
				$("#company-email2").val($("#company-selectbox-email").val());
			}
		});
		
		
		$("#pwd-check-img").change(function(){

			if($("#pwd-check-img").is(":checked") == false) {
				$("input[name='password']").attr("type","password");
			}else if($("#pwd-check-img").is(":checked") == true) {
				$("input[name='password']").attr("type","text");
			}
			
		});
		
		$("#pwd-check-img-1").change(function(){

			if($("#pwd-check-img-1").is(":checked") == false) {
				$("input[name='password-check']").attr("type","password");
			}else if($("#pwd-check-img-1").is(":checked") == true) {
				$("input[name='password-check']").attr("type","text");
			}
			
		});
		
		$("#link-changePassword").click(function(){
			
			if($("input[name='password']").val()==""){
				alert("비밀번호를 입력해주세요");
				$("input[name='password']").focus();
				return false;
			}else if($("input[name='password']").val() != password){
				alert("비밀번호가 일치하지 않습니다");
				$("input[name='password']").focus();
				return false;
			}
		});
		
		
		$("#company-address-btn-style").click(function(){
			 new daum.Postcode({
			        oncomplete: function(data) {
			        	$("#company-addr1").val("("+data.zonecode+") "+data.address);
			        	$("#company-addr2").focus();
			        }
			    }).open();
		});
		
		
		let code1 = "";
		  $("#c-email-btn-style").click(function(){
		  	const email = $("#company-email1").val() + "@" + $("#company-email2").val();
		  	//alert(email);
		  	
		  	$.ajax({
		  		url : "mailCheck.do",
		  		type: "POST",
		  		data: { email : email },
		  		
		  		success : function(data){
		  			alert("인증번호가 전송되었습니다");
		  			code1 = data;
		  			$('#c-email-auth-check').attr('disabled',false);
		  		}
		  	});
		});

		    	
	  	$('#c-email-auth-check').on("change",function () {

				const inputCode1 = $(this).val();
				const resultMsg1 = $('#c-emailAuth');
				
				if(inputCode1 === code1){
					resultMsg1.text('인증번호가 일치합니다.');
					resultMsg1.css("font-size","11px").css('color','blue').css("display","inline");
					$('#c-email-auth-check').attr('disabled',true);
					$('#company-email1').attr('readonly',true);
					$('#company-email2').attr('readonly',true);
					$('#company-selectbox-email').attr('disabled',true);
					$('#company-selectbox-email').attr('onFocus', 'this.initialSelect = this.selectedIndex');
			        $('#company-selectbox-email').attr('onChange', 'this.selectedIndex = this.initialSelect');
				}else{
					resultMsg1.text('인증번호가 불일치 합니다. 다시 확인해주세요!.');
					resultMsg1.css("font-size","11px").css('color','rgb(255, 0, 0)').css("display","inline");
				}
			  
		  });
		  	
	  	$("#company-email1, #company-email2, #company-selectbox-email").change(function() {
	  		if($("#c-email-auth-check").val() == ""){
	  			$("#c-emailAuth").css("font-size","11px").css('color','rgb(255, 0, 0)').css("display","inline").text('이메일 인증을 완료해주세요');
	  		}else {
	  			$("#c-emailAuth").css('color','rgb(0, 0, 255)').css("display","none");
	  		}
	  	});
	  	
		$("#company-email1, #company-email2, #company-selectbox-email").blur(function(){
		   		
		  		if($("#company-email1").val() == "" || $("#company-email2").val() == "") {
		  			$("#c-emailMsg").text("필수항목입니다").css("color","red").css("font-size","11px").css("display","inline");
		  			return false;
		  		}else {
		  			$.ajax({
		  				url : "c_email_check.do",
		  				type: "POST",
		  				data: {
		  					email1 : $("#company-email1").val(),
		  					email2 : $("#company-email2").val()
		  				},
		  				
		  				success : function(result) {
		  					if(result==1) {
		  						if($("#company-email1").val()==email1 && $("#company-email2").val()==email2) {
		  							$("#c-emailMsg").css("display","none");
		  							$("#c-emailAuth").css('color','rgb(0, 0, 255)').css("display","none");
		  							return false;
		  						}
		  						$("#c-emailMsg").text("중복된 이메일입니다").css("color","red").css("font-size","11px").css("display","inline");
		  						return false;
		  					}else {
		  						$("#c-emailMsg").text("").css("display","none");
		  					}
		  				}
		  			});
		  		}
		
		  	});
	  	
	  	$("#company-selectbox-mobile, #company-selectbox-phone, input[name='phone2'], input[name='phone3']").blur(function() {
	  	    if ($("#company-selectbox-mobile").val() == "default" || $("#company-selectbox-phone").val() == "default" || $("input[name='phone2']").val() == "" || $("input[name='phone3']").val() == "") {
	  			$("#phoneMsg").text("필수항목입니다").css("color","red").css("font-size","11px").css("display","inline");
	  		}else {
	  			$.ajax({
	  				url : "c_phone_check.do",
	  				type: "POST",
	  				data: {
	  					phone1 : $("#company-selectbox-phone").val(),
	  					phone2 : $("input[name='phone2']").val(),
	  					phone3 : $("input[name='phone3']").val()
	  				},
	  				
	  				success : function(result) {
	  					if(result==1) {
	  						if($("#company-selectbox-phone").val()==phone1 && $("input[name='phone2']").val()==phone2 && $("input[name='phone3']").val()==phone3){
	  							$("#c-phoneMsg").text("").css("display","none");
	  							return false;
	  						}
	  						$("#c-phoneMsg").text("이미 등록된 휴대전화입니다").css("color","red").css("font-size","11px").css("display","inline");
	  						return false;
	  					}else {
	  						$("#c-phoneMsg").text("").css("display","none");
	  					}
	  				}
	  			});
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
				<p id="top-title">My Page</p>
				<p id="top-subtitle">#마이페이지</p>
			</div>
		</div>
	</section>
	<section id="content-1">
		<p id="intro">마이페이지</p>
		<form action="companyMyPage_proc.do" name="companyMyPageForm" method="post" id="content-myPage">
			<div>
				<ul>
					<li id="must-insert">
						<p id="label-dot">*</p>
						<label>회사 아이디</label>
					</li>
					<li>
						<input type="text" id="input-common" name="company_id" value="${companyVo.company_id }" disabled>
						<input type="hidden" name="company_id" value="${companyVo.company_id }">
					</li>
					<li>
						<label>게임명</label>
					</li>
					<li>
						<input type="text" id="input-common" name="game" value="${companyVo.game }" disabled>
					</li>
					<li id="must-insert">
						<p id="label-dot">*</p>
						<label>비밀번호</label><span id="c-pwdMsg"></span>
					</li>
					<li>
						<input type="password" id="company-password" name="password">
						<input type="checkbox" id="pwd-check-img">
					</li>
					<li>
						<a href="CompanyPageChangePassword.do?company_id=${companyVo.company_id }" id="link-changePassword">
							<span>비밀번호 변경 ></span>
						</a>
					</li>
					<li id="must-insert">
						<p id="label-dot">*</p>
						<label>회사명</label>
					</li>
					<li>
						<input type="text" id="company-name" name="name" value="${companyVo.name }">
					</li>
					<li id="must-insert">
						<p id="label-dot">*</p>
						<label>회사 이메일</label>
						<span id="c-emailMsg"></span>
						<span id="c-emailAuth"></span>
					</li>
					<li>
						<input type="text" id="company-email1" name="email1" value="${companyVo.email1 }">
						@
						<input type="text" id="company-email2" name="email2" value="${companyVo.email2 }">
						<select id="company-selectbox-email" name="email3">
							<option value="choose">선택</option>
							<option value="naver.com" ${companyVo.email3  == 'naver.com' ? 'selected' : ''}>naver.com</option>
							<option value="gmail.com" ${companyVo.email3  == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
							<option value="daum.net" ${companyVo.email3  == 'daum.net' ? 'selected' : ''}>daum.net</option>
							<option value="direct">직접입력</option>
						</select>
						<button type="button" id="c-email-btn-style">인증 번호</button>
						<input type="text" name="email-auth-check" id="c-email-auth-check" placeholder="인증번호 6자리" disabled="disabled">
					</li>
					<li>
						<label>주소</label>
					</li>
					<li>
						<input type="text" id="company-addr1" name="addr1" value="${companyVo.addr1 }">
						<button type="button" id="company-address-btn-style">주소 검색</button>
					</li>
					<li class="address-input">
						<label>상세 주소</label>
					</li>
					<li>
						<input type="text" id="company-addr2" name="addr2" value="${companyVo.addr2 }">
					</li>
					<li id="must-insert">
						<p id="label-dot">*</p>
						<label>대표전화</label><span id="c-phoneMsg"></span>
					</li>
					<li>
						<select name="tel" id="company-selectbox-mobile">
							<option value="choose">선택</option>
							<option value="SKT" ${companyVo.tel == 'SKT' ? 'selected' : '' }>SKT</option>
							<option value="KT" ${companyVo.tel == 'KT' ? 'selected' : '' }>KT</option>
							<option value="LGU+" ${companyVo.tel == 'LGU+' ? 'selected' : '' }>LGU+</option>
							<option value="MVNO" ${companyVo.tel == 'MVNO' ? 'selected' : '' }>알뜰폰</option>
						</select> 
						<select name="phone1" id="company-selectbox-phone">
							<option value="choose">선택</option>
							<option value="010" ${companyVo.phone1 == '010' ? 'selected' : ''}>010</option>
    						<option value="011" ${companyVo.phone1 == '011' ? 'selected' : ''}>011</option>
    						<option value="012" ${companyVo.phone1 == '012' ? 'selected' : ''}>012</option>
						</select>
						-
						<input type="text" id="company-phone2" name="phone2" value="${companyVo.phone2 }">
						-
						<input type="text" id="company-phone3" name="phone3" value="${companyVo.phone3 }">
					</li>
					<li>
						<button type="button" id="button-gradient-company">수정하기</button>
					</li>
					<li>
						<a href="donation_detail.do" id="link-donation">
							<span>후원금 정산 내역 ></span>
						</a>
						<a href="deletePwd.do?company_id=${companyVo.company_id }" id="link-deleteAccount">
							<span>회원탈퇴 ></span>
						</a>
					</li>
				</ul>
			</div>
		</form>
	</section>

	<jsp:include page="../main/footer.jsp"></jsp:include>

</body>
</html>