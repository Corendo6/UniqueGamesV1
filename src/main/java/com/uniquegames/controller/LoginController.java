package com.uniquegames.controller;
import com.uniquegames.model.SessionConstants;
import com.uniquegames.repository.CompanyRepositoryMapper;
import com.uniquegames.repository.MemberRepositoryMapper;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.uniquegames.vo.CompanyVo;
import com.uniquegames.vo.MemberVo;

@Controller
public class LoginController {
	MemberRepositoryMapper memberRepositoryMapper;
	CompanyRepositoryMapper companyRepositoryMapper;

	@Autowired
	public LoginController(MemberRepositoryMapper memberRepositoryMapper,
			CompanyRepositoryMapper companyRepositoryMapper) {
		this.memberRepositoryMapper = memberRepositoryMapper;
		this.companyRepositoryMapper = companyRepositoryMapper;
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() {
		return "/login/login";
	}


	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String loginOk(@Validated @ModelAttribute MemberVo member, @Validated @ModelAttribute CompanyVo company,
			HttpServletRequest request, @RequestParam(defaultValue = "/") String redirectURL) {
		HttpSession session = request.getSession(); // 세션이 있으면 있는 세션 반환, 없으면 신규 세션을 생성하여 반환

//		MemberVo loginMember = memberRepositoryMapper.findById(member.getMember_id());
//		CompanyVo loginMemberCom = companyRepositoryMapper.findById(company.getCompany_id());

		session.setAttribute("login", "not");
		/* member */
		if (member != null && memberRepositoryMapper.passEqual(member) == 1) {
			// loginMember != null && loginMember.getPassword().equals(member.getPassword())
			session.setAttribute(SessionConstants.LOGIN_MEMBER, memberRepositoryMapper.findById(member.getMember_id()));
			session.setAttribute("login", "member");
			if (redirectURL.equals("notice_write.do") || redirectURL.equals("detail/insertIntro.do")) {
				return "redirect:/";
			}
		}
		/* company */
		else if (company != null && companyRepositoryMapper.passEqual(company) == 1) {
			session.setAttribute(SessionConstants.LOGIN_MEMBER,  companyRepositoryMapper.findById(company.getCompany_id())); // 세션에 로그인 회원 정보 보관
			session.setAttribute("login", "company");
		}
		
		System.out.println(session.getAttribute("login"));

		if (redirectURL.isEmpty()) {
			redirectURL = "/";
		}

		return "redirect:" + redirectURL;
	}

	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();

		return "redirect:/";
	}

	@RequestMapping("/session-info")
	public String sessionInfo(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session.getAttribute(SessionConstants.LOGIN_MEMBER) == null) {
			System.out.println("세션 X");
			return "세션 X";
		}
		// 세션 id와 저장된 객체 정보 출력
		System.out.println(session.getId() + ", " + session.getAttribute(SessionConstants.LOGIN_MEMBER));

		// 세션 데이터 출력
		Enumeration<String> attributeNames = session.getAttributeNames();
		while (attributeNames.hasMoreElements()) {
			String name = attributeNames.nextElement();
		}

		return "세션 출력";

	}

}
