<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Guard: nếu mở thẳng thanks.jsp mà không có survey -> quay về form -->
<c:if test="${empty survey}">
  <c:redirect url="${pageContext.request.contextPath}/survey"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Thank you!</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/survey.css">
  <style>
    .success { display:flex; align-items:center; gap:12px; margin-bottom:16px }
    .success .badge { width:36px; height:36px; border-radius:50%; background:#16a34a22;
                      display:grid; place-items:center; font-size:18px; color:#16a34a }
    .kv .k { color:#64748b } .kv .v { font-weight:600 }
    .actions { margin-top: 20px; display:flex; gap:12px }
    .btn { padding:.6rem 1rem; border-radius:10px; border:1px solid #e5e7eb; background:#fff }
    .btn.primary { background:#ef4444; color:#fff; border-color:#ef4444 }
  </style>
</head>
<body>
  <div class="container">
    <div class="success">
      <div class="badge">✓</div>
      <h1>Thank you!</h1>
    </div>

    <div class="card section">
      <h2>Your information</h2>
      <div class="kv">
        <div class="k">Full name</div>
        <div class="v">${survey.fullName}</div>

        <div class="k">Email</div>
        <div class="v">${survey.email}</div>

        <!-- Định dạng DOB: nếu parse được yyyy-MM-dd thì in dd/MM/yyyy, ngược lại in raw -->
        <c:choose>
          <c:when test="${not empty survey.dob}">
            <fmt:parseDate value="${survey.dob}" pattern="yyyy-MM-dd" var="dobDate" />
            <div class="k">Date of Birth</div>
            <div class="v">
              <c:choose>
                <c:when test="${not empty dobDate}">
                  <fmt:formatDate value="${dobDate}" pattern="dd/MM/yyyy" />
                </c:when>
                <c:otherwise>${survey.dob}</c:otherwise>
              </c:choose>
            </div>
          </c:when>
          <c:otherwise>
            <div class="k">Date of Birth</div><div class="v">—</div>
          </c:otherwise>
        </c:choose>

        <div class="k">Heard from</div>
        <div class="v">${survey.heardFrom}</div>

        <div class="k">Contact via</div>
        <div class="v">${survey.contactVia}</div>

        <div class="k">Receive updates</div>
        <div class="v">
          <c:choose>
            <c:when test="${survey.updates}">Yes</c:when>
            <c:otherwise>No</c:otherwise>
          </c:choose>
        </div>

        <c:if test="${not empty survey.comments}">
          <div class="k">Comments</div>
          <div class="v"><c:out value="${survey.comments}"/></div>
        </c:if>
      </div>

      <div class="actions">
        <a class="btn" href="${pageContext.request.contextPath}/survey">Back to form</a>
        <a class="btn primary" href="${pageContext.request.contextPath}/">Submit another response</a>
      </div>
    </div>
  </div>
</body>
</html>
