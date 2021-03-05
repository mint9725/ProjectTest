<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<link href="<c:url value="/resources/css/imageStyle.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/divStyle.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/tableStyle.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/buttonStyle.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/anchorStyle.css" />" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/resources/assets/css/main.css" />
<noscript><link href="<c:url value="/resources/assets/css/noscript.css" />" rel="stylesheet"></noscript>
<head>
<link rel="icon" type="image/x-icon" sizes="16x16" href="/resources/image/titleImage.ico">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

<meta charset="UTF-8">
<title>자유 게시판</title>
</head>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<header id="header" class="alt">
			<a href = "/virtualHomePage" class = "imageLink"><img src = "/resources/image/home.png" class = "virtualHomePageImageSytle"/></a>
			<nav>
				<a href="#menu" style = "color:white;">Menu</a>
			</nav>
		</header>
		
		<!-- Menu -->
		<nav id="menu">
			<ul class="links">
				<li><a href="index">웹</a></li>
				<li><a href="/virtualHomePage">홈페이지</a></li>
			</ul>
			<ul class="actions stacked">
				<c:if test="${empty pageContext.request.userPrincipal}">
					<li><a href="/virtualHomePage/signUp"><button class="primaryFitbutton">회원가입</button></a></li>
					<li><a href="/virtualHomePage/loginPage"><button class="fitbutton">로그인</button></a></li>
				</c:if>
				<c:if test="${not empty pageContext.request.userPrincipal}">
					<li><a href = "/virtualHomePage/MemberInformation"><button class="fitbutton">${pageContext.request.userPrincipal.name}님</button></a></li>
					<li><a href="${pageContext.request.contextPath}/j_spring_security_logout"><button class="primaryFitbutton">로그아웃</button></a></li>
				</c:if>
			</ul>
		</nav>
		
		<!-- Banner -->
		<!-- Note: The "styleN" class below should match that of the header element. -->
		<section id="banner" class="style2">
			<div class="inner">
				<span class="image">
					<img src="/resources/image/pic07.jpg" alt="" />
				</span>
				<header class="major">
					<div align = "center">
						<h1 style = "color:white;">가상 홈페이지: 자유 게시판</h1>
					</div>
				</header>
			</div>
		</section>
		
		<!-- Main -->
		<div id="main">
			<!-- One -->
			<section id="one">
				<div class="inner" align = "center">
					<header>
						<div class = "bbsListDivStyle" align = "center">
							<br/>
							<table border = "1" cellpadding = "5" cellspacing = "0" class = "bbsListTableStyle">
								<thead>
									<tr>
										<td align = "center">번호</td>
										<td align = "center">제목</td>
										<td align = "center">작성자</td>
										<td align = "center">날짜</td>
										<td align = "center">조회</td>
									</tr>
								</thead>
								<!-- 게시글 목록 가져오기 -->
								<c:forEach items = "${list}" var = "vbbs">
									<tr>
										<td align = "center" style = "width:50px;">${vbbs.vNo}</td>
										<td contentView?vNo=${vbbs.vNo} style = "max-width:100px; overflow:hidden; text-overflow:ellipsis; white-space: nowrap;">&nbsp;&nbsp;&nbsp;
											<c:forEach begin = "1" end = "${vbbs.vIndent}">└</c:forEach>
											<c:if test="${not empty pageContext.request.userPrincipal}">
														<a class = "bbsList" href = "/virtualHomePage/virtualBulletinBoard/contentView?vNo=${vbbs.vNo}"><button class = "contentTextbutton">${vbbs.vSubject}</button></a>
														<a class = "bbsList" href = "/virtualHomePage/virtualBulletinBoard/contentView?vNo=${vbbs.vNo}#Comment"><button class = "contentTotalbutton">[${vbbs.vCommentCount}]</button></a>
													</c:if>
													<c:if test="${empty pageContext.request.userPrincipal}">
														<a class = "bbsList" href = "/virtualHomePage/virtualBulletinBoard/contentView?vNo=${vbbs.vNo}"><button class = "contentTextbutton" id = "logincheck" onClick = "memberCheck()">${vbbs.vSubject}</button></a>
														<a class = "bbsList" href = "/virtualHomePage/virtualBulletinBoard/contentView?vNo=${vbbs.vNo}#Comment"><button class = "contentTotalbutton" id = "logincheck" onClick = "memberCheck()">[${vbbs.vCommentCount}]</button></a>
													</c:if>
										</td>
										<td style = "width:100px;" align = "center"><a href = "/virtualHomePage/virtualMemberBulletinBoard?page=1&vId=${vbbs.vId}">${vbbs.vNickName}</a></td>
										<td align = "center" style = "width:180px;">
											<jsp:useBean id="now" class="java.util.Date" />
											<fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일" var="today" />
											<fmt:formatDate value="${vbbs.vDate}" pattern="yyyy년 MM월 dd일" var="write_dt"/>
											<c:if test="${today ne write_dt}">
												<label class = "TelIdFindResultLabel"><fmt:formatDate pattern="yyyy년MM월 dd일" value="${vbbs.vDate}"/></label>
											</c:if>
											<c:if test="${today eq write_dt}">
												<label class = "TelIdFindResultLabel"><fmt:formatDate pattern="HH:mm" value="${vbbs.vDate}"/></label>
											</c:if>
										</td>
										<td align = "center" style = "width:50px;">${vbbs.vHit}</td>
									</tr>
								</c:forEach>
								<tr>
									<td align = "right" colspan = "5" style = "border-bottom:none;">
										<br/>
										<c:if test = "${empty pageContext.request.userPrincipal}">
											<a href = "/virtualHomePage/virtualBulletinBoard/Write"><button class = "writebutton" id = "logincheck" onClick = "locheck()" ><img src="/resources/image/write.png" class = "writeImageStyle"/>글쓰기</button></a>
										</c:if>
										<c:if test="${not empty pageContext.request.userPrincipal}">
											<a href = "/virtualHomePage/virtualBulletinBoard/Write"><button class = "writebutton"><img src="/resources/image/write.png" class = "writeImageStyle"/>글쓰기</button></a>
										</c:if>
									</td>
								</tr>
							</table>
							<div>
								
								<c:if test = "${pagination.getTotalListCnt() ne 0}">
									<c:if test = "${pagination.getPage() ne 1}">
										<a href = "/virtualHomePage/virtualBulletinBoard?page=1"><button class = "listPagingbutton">처음</button></a>
										<a href = "/virtualHomePage/virtualBulletinBoard?page=${pagination.getPreBlock()}"><button class = "listPagingbutton">⏪</button></a>
									</c:if>
								</c:if>
								
								<c:forEach begin="${pagination.startPage}" end = "${pagination.endPage}" var = "pageNum">
									<a href = "/virtualHomePage/virtualBulletinBoard?page=${pageNum}"><button class = "listPagingbutton">${pageNum}</button></a>
								</c:forEach>
								
								<c:if test = "${pagination.getTotalListCnt() ne 0}">
									<c:if test = "${pagination.getPage() ne pagination.totalPageCnt}">
										<a href = "/virtualHomePage/virtualBulletinBoard?page=${pagination.getNextBlock()}"><button class = "listPagingbutton">⏩</button></a>
										<a href ="/virtualHomePage/virtualBulletinBoard?page=${pagination.getTotalPageCnt()}"><button class = "listPagingbutton">마지막</button></a>
									</c:if>
								</c:if> 
							</div>
						</div>
					</header>
				</div>
			</section>
		</div>
		
	</div>
	<!-- Scripts -->
	<script src="/resources/assets/js/jquery.min.js"></script>
	<script src="/resources/assets/js/jquery.scrolly.min.js"></script>
	<script src="/resources/assets/js/jquery.scrollex.min.js"></script>
	<script src="/resources/assets/js/browser.min.js"></script>
	<script src="/resources/assets/js/breakpoints.min.js"></script>
	<script src="/resources/assets/js/util.js"></script>
	<script src="/resources/assets/js/main.js"></script>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src='<c:url value="/resources/js/loginCheck.js"/>'></script>
</body>
</html>