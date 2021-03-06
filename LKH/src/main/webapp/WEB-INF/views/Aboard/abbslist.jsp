<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../main_top.jsp" flush="false"/>
<jsp:include page="../main_sidebar.jsp" flush="false"/>
<script>
 $(function(){
	 $("#write").on("click",function(e){
		 e.preventDefault();
		 location.href="${pageContext.request.contextPath }/Aboard/write"; 			 	 
	 });	

	 //검색버튼 클릭
	 
	 $("#searchbtn").on("click", function(){
			if($("#keyword").val().trim().length == 0){
				alert('검색어를 입력하세요.');
				return;
			}
			else{
				var searchType = $("#searchType").val();
				var keyword = $("#keyword").val().trim();
				console.log(searchType);
				console.log(keyword);
				$("form").submit();
			}
		})

 });
</script>
<body>
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	<div
		class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
		<h1 class="h2">대나무숲</h1>
		<h6 class="h6">하고 싶은 말을 자유롭게 적어주세요.</h6>
		<div class="btn-toolbar mb-2 mb-md-0">
			<div class="btn-toolbar mb-2 mb-md-0">
			
		        <form  action="/Aboard/list" method="post">
		       	<div class="row">
		          <label class="col-sm-1 col-form-label col-form-label-sm px-0 mx-1" for="searchType">검색</label>
		          <select class="col-sm-4 custon-select custom-select-sm px-1 mr-1" name="searchType" id="searchType">
		            <option value="TC"
		            	<c:out value="${pc.searchType == 'TC' ? 'selected' :'' }"/>>제목+내용</option>
		            <option value="T"
		            	<c:out value="${pc.searchType == 'T' ? 'selected' :'' }"/>>제목</option>
		            <option value="C"
		            	<c:out value="${pc.searchType == 'C' ? 'selected' :'' }"/>>내용</option>
		           	<option value="N"
		            	<c:out value="${pc.searchType == 'N' ? 'selected' :'' }"/>>이름</option>
		          </select>
		          <input class="col-sm form-control form-control-sm px-1 mr-1" type="search" name="keyword" id="keyword" value = "${pc.keyword }" >
		          <input class="btn btn-sm btn-outline-primary px-1 mx-0" class="button" type="button" value="검색" id="searchbtn">
		        </div>
		        </form>
     		 
		</div>
		</div>
	</div>
	
	<div class="table-responsive">
		<table class="table table-striped table-sm">
			<thead>

				<tr>
				<th scope="col">글번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성일</th>
				<th scope="col">조회수</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="abbsdto">
				<c:if test="${abbsdto.isdel eq 'Y'}">
					<tr>
						<td>${abbsdto.num}</td>

						<td>
						
          					삭제된 게시물입니다
          				</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</c:if>
				<c:if test="${abbsdto.isdel ne 'Y'}">
					<tr>
						<td>${abbsdto.num }</td>
						 <td>
							<c:forEach begin="1" end="${abbsdto.indent }">&nbsp;&nbsp;</c:forEach>
	           			 <c:if test="${abbsdto.indent > 0 }">
	            		<img src="${pageContext.request.contextPath }/resources/images/re.png" width="20" style="dispaly=inline" >
	            		</c:if>				
						<a href="/Aboard/view?num=${abbsdto.num }&${pc.makeSearchURL(pc.recordCriteria.reqPage)} " class="text-decoration-none text-reset text-danger" >${abbsdto.title }</a>
						</td>
						<td>${abbsdto.cdate }</td>
						<td>${abbsdto.hit }</td>
					</tr>
				</c:if>
				</c:forEach>
				<tr style="background-color:white">
					<td colspan="10" align="right">
						<button id="write" type="button" class="btn btn-sm btn-outline-dark">글쓰기</button>					
					</td>
				</tr>
			</tbody>
			</tr> 
			</tbody>
		</table>
	</div>
	
	<ul class="pagination pagination-sm justify-content-center">

		<c:if test="${pc.prev }">
			<li class="page-item"><a class="page-link"
				href="/Aboard/list?${pc.makeSearchURL(1) }&searchType=${pc.searchType}&keyword=${pc.keyword}">처음</a></li>
			<li class="page-item"><a class="page-link"
				href="/Aboard/list?${pc.makeSearchURL(pc.startPage - 1) }&searchType=${pc.searchType}&keyword=${pc.keyword}">이전</a></li>
		</c:if>



		<c:forEach begin="${pc.startPage }" end="${pc.endPage }" var="pageNum">
			<!-- 현재페이지와 요청페이지가 다르면 -->
			<c:if test="${pc.recordCriteria.reqPage != pageNum }">
				<li class="page-item"><a class="page-link"
					href="/Aboard/list${pc.makeSearchURL(pageNum) }&searchType=${pc.searchType}&keyword=${pc.keyword}">${pageNum }</a>
				</li>
			</c:if>

			<!-- 현재페이지와 요청'페이지가 같으면 강조표시 -->
			<c:if test="${pc.recordCriteria.reqPage == pageNum }">
				<li class="page-item active"><a class="page-link"
					href="/Aboard/list${pc.makeSearchURL(pageNum) }&searchType=${pc.searchType}&keyword=${pc.keyword}">${pageNum }</a>
				</li>
			</c:if>
			
		</c:forEach>


		<c:if test="${pc.next }">
			<li class="page-item"><a class="page-link"
				href="/Aboard/list${pc.makeSearchURL(pc.endPage + 1) }&searchType=${pc.searchType}&keyword=${pc.keyword}">다음</a></li>
			<li class="page-item"><a class="page-link"
				href="/Aboard/list${pc.makeSearchURL(pc.finalEndPage) }&searchType=${pc.searchType}&keyword=${pc.keyword}">마지막</a></li>
		</c:if>
	</ul>

	
	</main>
</body>
</html>