<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@page import="com.model2.mvc.framework.ActionServlet"%> --%>
<%--     <%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ page import="com.model2.mvc.common.*" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%List<Product> list= (List<Product>)request.getAttribute("list");
Page resultPage=(Page)request.getAttribute("resultPage");
String role="";
if(request.getSession().getAttribute("user") !=null){
	User user = 	(User)request.getSession().getAttribute("user");
	role=user.getRole();
}

Search search=(Search)request.getAttribute("search");
String searchCondition = CommonUtil.null2str(search.getSearchCondition());
String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
 %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<c:if test="${param.menu=='manage' }">
<title>��ǰ �����ȸ</title>
 </c:if>
 <c:if test="${param.menu=='search' }">
 <title>��ǰ ����</title>
 </c:if>	

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">

function fncGetPageList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${param.menu }" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					<c:if test="${param.menu== 'search'}">
						��ǰ �����ȸ
					</c:if>
					<c:if test="${param.menu=='manage' }">
						 ��ǰ ����
				 	</c:if>	
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
	<td align="right">
			<input type = "radio" name="order" value="priceDesc" ${search.order=='priceDesc' ? "checked" : "" }/>�������ݼ�
			<input type="radio" name="order" value = "priceAsc" ${search.order=='priceAsc' ? "checked" : "" }/>�������ݼ�
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			<c:if test="${!empty user && user.role == 'admin' }">
				<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				</c:if>
				<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
				<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
			</select>
			<input 	type="text" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword	 : "" }"  class="ct_input_g" 
							style="width:200px; height:20px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetPageList('1');">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}     ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		<c:if test="${!empty user && user.role == 'admin' }">
		<td class="ct_list_b" width="50">��ǰ��ȣ</td>
		<td class="ct_line02"></td>
		</c:if>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" >��ǰ�̹���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" >��ǰ�󼼼���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b"  width="150">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�������</td>
		<td class="ct_line02"></td>	
	</tr>
	<tr>
		<td colspan="15" bgcolor="808285" height="1"></td>
	</tr>
	<%-- <% 	
		for(int i=0; i<list.size(); i++) {
			Product vo = list.get(i);
			System.out.println("vo ����=========="+vo);
			System.out.println("�޴�����!!!!!!!====="+request.getParameter("menu"));
	%> --%>
	<c:set var="i" value="0"/>
		<c:forEach var="product" items="${list}">
			<c:set var ="i" value="${i+1 }"/>
		
	<tr class="ct_list_pop">
		<td align="center">${i }</td>
		<td></td>
		<c:if test="${!empty user && user.role == 'admin' }">
		<td align="left">${product.prodNo}</td>
		<td></td>
		</c:if>
		
		<td align="left">
		<c:if test="${param.menu=='search' }">
			<a href="/product/getProduct?prodNo=${product.prodNo }&menu=${param.menu}">${product.prodName }</a>
		</c:if>
		<c:if test = "${param.menu=='manage'}">
			<a href="/product/updateProduct?prodNo=${product.prodNo }&menu=${param.menu }%>">${product.prodName }</a>
		</c:if>
		</td>	
		
		<td></td>
		<td align="left">${product.fileName }</td>
		<td></td>
		<td align="left">${product.prodDetail }</td>
		<td></td>
		<td align="left">${product.price }</td>
		<td></td>
		<td align="left">${product.manuDate }</td>
		<td></td>
		<td align="left">
		
		<%-- <%if(role.equalsIgnoreCase("admin")) {%> --%>
		<%-- <%if(request.getParameter("menu").equals("manage")){ %> --%>
			<%-- <%=vo.getProTranCode() %> --%>
		<%-- <%if(vo.getProTranCode().equals("���ſϷ�")){ %> --%>
		<%-- <%}%> --%>
		<%-- <%} --%>
		<c:if test="${!empty user && user.role == 'admin' }">
		
			<c:if test="${param.menu=='manage' }">
			<c:choose>
				<c:when test = "${product.proTranCode =='1  '}">���ſϷ�<a href="/purchase/updateTranCodeActionByProd?prodNo=${product.prodNo}&tranCode=2&currentPage=${resultPage.currentPage}">����ϱ�</a></c:when>
				<c:when test = "${product.proTranCode =='2  '}">�����</c:when>
				<c:when test = "${product.proTranCode =='3  '}">��ۿϷ�</c:when>
	
				<c:otherwise>�Ǹ���	</c:otherwise>
			</c:choose>
					
				</c:if>
		
			<c:if test = "${param.menu=='search' }">
				<c:choose>
				<c:when test = "${product.proTranCode =='1  '}">���ſϷ�</c:when>
				<c:when test = "${product.proTranCode =='2  '}">�����</c:when>
				<c:when test = "${product.proTranCode =='3  '}">��ۿϷ�</c:when>
				<c:otherwise>�Ǹ���	</c:otherwise>
			</c:choose>
			</c:if>
			</c:if>
			
			<%-- else if(request.getParameter("menu").equals("search")) {%>
				<%=vo.getProTranCode() %>
			<%} %>
		<%} --%>
		<!-- else if(!role.equals("admin")){ %> -->
		<%-- <%if(request.getParameter("menu").equals("search")){ %> --%>
		<%-- <%if(vo.getProTranCode().equals("�Ǹ���")){ %> --%>
		<%-- <%=vo.getProTranCode() %> --%>
		<%-- <%}else{ %> --%>
			<%-- <%} %> --%>
			<%-- <%} %> --%>
			<%-- 	<%} %> --%>
		<c:if test="${!empty user && user.role != 'admin' }">	
			<c:if test="${param.menu=='search' }">	
				<c:if test="${product.proTranCode != '0  '}" >			
				<c:choose>
				<c:when test = "${product.proTranCode =='1  '}">���ſϷ�</c:when>
				<c:when test = "${product.proTranCode =='2  '}">�����</c:when>
				<c:when test = "${product.proTranCode =='3  '}">��ۿϷ�</c:when>
				<c:otherwise>�Ǹ���	</c:otherwise>
			</c:choose>				
				</c:if>			
			</c:if>
		</c:if>
		</td>	
	</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			<%--
			 <% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					�� ����
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">�� ����</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
					
			<% 	System.out.println("i�� ����Ѵ�!!--------"+i);}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					���� ��
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">���� ��</a>
			<% } %>
		 --%>
		 <jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
