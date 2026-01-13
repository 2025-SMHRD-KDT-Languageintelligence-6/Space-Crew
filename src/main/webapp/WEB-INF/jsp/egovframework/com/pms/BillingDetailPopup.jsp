<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>청구 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <style>
        body { padding: 20px; font-family: 'Malgun Gothic'; }
        .popup-header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-close { margin-top: 20px; text-align: center; }
    </style>
</head>
<body>
    <div id="summaryArea" class="summary-box" style="background: #f9f9f9; padding: 15px; border-radius: 8px; border: 1px solid #ddd;">
        <h3>📊 정산 요약</h3>
        <input type="hidden" id="rawTotalAmt" value="${summary.totalAmt}">
        
        <p>총 계약 금액: <strong><fmt:formatNumber value="${summary.totalAmt}" pattern="#,###"/></strong>원</p>
        <p>기 청구 합계: <span id="totalBilledAmtDisplay" style="font-weight:bold;"><fmt:formatNumber value="${summary.totalBilledAmt}" pattern="#,###"/></span>원</p>
        <p style="color:red; font-weight:bold; border-top: 1px dashed #ccc; pt-10px; margin-top: 10px;">
            남은 청구 잔액: <c:set var="total" value="${summary.totalAmt != null ? summary.totalAmt : 0}" />
						<c:set var="billed" value="${summary.totalBilledAmt != null ? summary.totalBilledAmt : 0}" />
						<span id="balanceAmtDisplay"><fmt:formatNumber value="${total - billed}" pattern="#,###"/></span>원
        </p>
    </div>
	<hr>

    <h4>📜 세부 청구 내역</h4>
    <table class="w3-table-all" id="billingListTable">
        <thead>
            <tr class="w3-light-grey">
                <th>회차/명칭</th>
                <th>청구 금액</th>
                <th>발행일</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="bill" items="${billList}">
                <tr id="row_${bill.billId}">
                    <td>${bill.billTitle}</td>
                    <td class="billed-value" data-value="${bill.billAmt}">
                        <fmt:formatNumber value="${bill.billAmt}" pattern="#,###"/>원
                    </td>
                    <td>${bill.taxBillDt != null ? bill.taxBillDt : '-'}</td>
                    <td><button type="button" class="btn_red" style="padding:2px 5px;" onclick="fn_delete_billing('${bill.billId}', ${bill.billAmt})">삭제</button></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div style="margin-top:20px; padding:15px; border:1px solid #ddd; background:#fffef0;">
        <form id="billingForm">
            <input type="hidden" name="projId" value="${summary.projId}">
            <strong>➕ 내역 추가: </strong>
            <input type="text" name="billTitle" id="billTitle" placeholder="예: 2차 중도금" style="width:150px;">
            <input type="number" name="billAmt" id="billAmt" placeholder="청구 금액" style="width:120px;">
            <button type="button" class="btn-blue" onclick="fn_add_billing();">저장</button>
        </form>
    </div>

    <div class="btn-close">
        <button type="button" onclick="window.close();" class="btn_s">창 닫기</button>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script type="text/javascript">
        function fn_add_billing() {
            var title = $("#billTitle").val();
            var amt = parseInt($("#billAmt").val() || 0);
            
            var currentBalance = parseInt($("#balanceAmtDisplay").text().replace(/,/g, ''));

            if(!title) { alert("청구 명칭을 입력하세요."); return; }
            if(amt <= 0) { alert("금액을 정확히 입력하세요."); return; }
            
            if(amt > currentBalance) {
                alert("청구 잔액(" + currentBalance.toLocaleString() + "원)을 초과할 수 없습니다.");
                return;
            }

            var formData = $("#billingForm").serialize();

            $.ajax({
                url: "<c:url value='/pms/addBillingAjax.do'/>",
                type: "POST",
                data: formData,
                dataType: "json",
                success: function(data) {
                    if(data.status == "success") {
                        var newRow = "<tr>" +
                                     "<td>" + title + "</td>" +
                                     "<td>" + amt.toLocaleString() + "원</td>" +
                                     "<td>방금 전</td>" +
                                     "<td><span style='font-size:11px; color:gray;'>새로고침 후 삭제가능</span></td>" +
                                     "</tr>";
                        $("#billingListTable tbody").append(newRow);

                        updateSummary(amt);

                        $("#billTitle").val("");
                        $("#billAmt").val("");
                        alert("청구 내역이 추가되었습니다.");
                    } else {
                        alert("저장에 실패했습니다: " + data.message);
                    }
                },
                error: function() { alert("서버 통신 오류가 발생했습니다."); }
            });
        }

        function updateSummary(addedAmt) {
            var totalAmt = parseInt($("#rawTotalAmt").val());
            var prevBilled = parseInt($("#totalBilledAmtDisplay").text().replace(/,/g, ''));
            
            var newBilled = prevBilled + addedAmt;
            var newBalance = totalAmt - newBilled;

            $("#totalBilledAmtDisplay").text(newBilled.toLocaleString());
            $("#balanceAmtDisplay").text(newBalance.toLocaleString());
        }

        function fn_delete_billing(billId, amt) {
            if(!confirm("해당 청구 내역을 삭제하시겠습니까?")) return;

            $.ajax({
                url: "<c:url value='/pms/deleteBillingAjax.do'/>",
                type: "POST",
                data: { "selectedId": billId },
                dataType: "json",
                success: function(data) {
                    alert("삭제되었습니다.");
                    updateSummary(-amt);
                    $("#row_" + billId).remove();
                }
            });
        }
    </script>
</body>
</html>