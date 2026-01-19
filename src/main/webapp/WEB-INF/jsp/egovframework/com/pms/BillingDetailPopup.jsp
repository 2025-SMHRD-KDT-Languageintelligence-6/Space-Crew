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
	<div class="popup-header">
        <h2>📂 청구 정보 : ${summary.projNm}</h2>
    </div>
	<table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>고객사명</th>
            <td>${summary.custNm}</td>
        </tr>
        <tr>
            <th>영업건명</th>
            <td>${summary.salesTitle}</td>
        </tr>
        <tr>
            <th>영업담당자</th>
            <td>${summary.salesUserNm}</td>
        </tr>
        <tr>
            <th>계약명</th>
            <td>${summary.contNm}</td>
        </tr>
        <tr>
            <th>계약담당자</th>
            <td>${summary.picUserNm}</td>
        </tr>
        <tr>
            <th>주담당자</th>
            <td>${summary.mainMgrNm}</td>
        </tr>
        <tr>
            <th>부담당자</th>
            <td>${summary.subMgrNm}</td>
        </tr>
        <tr>
            <th>계약금액</th>
            <td>${summary.totalAmt}</td>
        </tr>
        <tr>
            <th>영업메모</th>
            <td>${summary.salesContent}</td>
        </tr>
        <tr>
            <th>업무메모</th>
            <td>${summary.contRemark}</td>
        </tr>
   	</table>

    <div id="summaryArea" class="summary-box" style="background: #f1f3f5; padding: 20px; border-radius: 12px; border: 1px solid #dee2e6; display: flex; justify-content: space-around; text-align: center;">
	    <input type="hidden" id="rawTotalAmt" value="${summary.totalAmt}"> <div>
	        <span style="font-size: 14px; color: #666;">총 계약 금액</span><br>
	        <strong style="font-size: 18px;"><fmt:formatNumber value="${summary.totalAmt}" pattern="#,###"/></strong>원
	    </div>
	    
	    <div style="border-left: 1px solid #ccc; padding-left: 20px;">
	        <span style="font-size: 14px; color: #666;">누적 청구액</span><br>
	        <strong id="totalBilledAmtDisplay" style="font-size: 18px; color: #333;"><fmt:formatNumber value="${summary.totalBilledAmt}" pattern="#,###"/></strong>원
	    </div>
	
	    <div style="border-left: 1px solid #ccc; padding-left: 20px;">
	        <span style="font-size: 14px; color: #666;">실수금 합계</span><br>
	        <strong id="totalPaidAmtDisplay" style="font-size: 18px; color: #28a745;"><fmt:formatNumber value="${summary.totalPaidAmt}" pattern="#,###"/></strong>원
	    </div>
	
	    <div style="border-left: 1px solid #ccc; padding-left: 20px;">
	        <span style="font-size: 14px; color: #666;">미수금 잔액</span><br>
	        <strong id="balanceAmtDisplay" style="font-size: 18px; color: #dc3545;">
	            <fmt:formatNumber value="${summary.totalAmt - summary.totalPaidAmt}" pattern="#,###"/>
	        </strong>원
	    </div>
	</div>
	<hr>

    <h4>📜 세부 청구 내역</h4>
    <table class="w3-table-all" id="billingListTable">
        <thead>
            <tr class="w3-light-grey">
                <th>회차/명칭</th>
                <th>청구 금액</th>
                <th>발행일</th>
                <th>입금 확인일</th>
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
                    <td>
					    <c:choose>
					        <c:when test="${bill.actualPayDt == null || bill.actualPayDt == '' || bill.actualPayDt == '-'}">
					        	<div style="display: flex; gap: 5px; align-items: center;">
					            <input type="date" id="payDate_${bill.billId}" style="width:110px; font-size:11px;">
					            <button type="button" class="btn-blue" style="padding:2px 5px; font-size:11px;" 
					                    onclick="fn_confirm_payment('${bill.billId}')">확인</button>
					            </div>
					        </c:when>
					        <c:otherwise>
					        	<div style="display: flex; justify-content: space-between; align-items: center; padding: 0 5px;">
					            <span style="color:blue; font-weight:bold;">
				            		<i class="fa fa-check-circle"></i>${bill.actualPayDt}
					            </span>
					            <button type="button" style="border:none; background:none; color:gray; cursor:pointer; font-size:11px;" 
					                    onclick="fn_cancel_payment('${bill.billId}')">취소</button>
			                    </div>
					        </c:otherwise>
					    </c:choose>
					</td>
					<td>
					    <button type="button" class="btn_yellow" style="padding:2px 5px; font-size:11px;" 
						        onclick="fn_edit_billing('${bill.billId}', '${bill.billTitle}', '${bill.billAmt}', '${bill.taxBillDt}')">수정</button>
					    <button type="button" class="btn_red" style="padding:2px 5px;" 
					            onclick="fn_delete_billing('${bill.billId}', ${bill.billAmt})">삭제</button>
					</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div style="margin-top:20px; padding:15px; border:1px solid #ddd; background:#fffef0;">
        <form id="billingForm">
        	<input type="hidden" name="billId" id="form_billId" value="">
        	
            <input type="hidden" name="projId" value="${summary.projId}">
            <input type="hidden" name="lastUpdusrId" value="${loginVO.id}">
            
            <strong>내역 추가 : </strong>
            <table style="width:100%; margin-top:10px;">
	            <tr>
	                <td>명칭: <input type="text" name="billTitle" id="billTitle" placeholder="2차 중도금" style="width:120px;"></td>
	                <td>금액: <input type="number" name="billAmt" id="billAmt" style="width:100px;"></td>
	                <td>발행일: <input type="date" name="taxBillDt" style="width:130px;"></td>
	            </tr>
	            <tr>
	                <td>입금예정: <input type="date" name="payDt" style="width:130px;"></td>
	                <td>메모: <input type="text" name="billRemark" placeholder="특이사항" style="width:200px;"></td>
	            </tr>
	        </table>
            <div style="text-align:right; margin-top:10px;">
            	<button type="button" id="btnSubmit" class="btn-blue" onclick="fn_save_billing();">저장</button>
    
   				<button type="button" id="btnCancel" class="btn_red" style="display:none; padding: 6px 12px; border-radius: 4px; cursor: pointer;" onclick="fn_reset_form();">취소</button>
            </div>
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
            if (newBalance === 0) {
                $("#balanceAmtDisplay").css("color", "blue").text("0 (청구완료)");
                fn_auto_status_update(); 
            } else if (newBalance < 0) {
                $("#balanceAmtDisplay").css("color", "red");
            }
        }
		
        function fn_auto_status_update() {
            $.ajax({
                url: "<c:url value='/pms/updateProjectStatusComplete.do'/>",
                type: "POST",
                data: { "projId": "${summary.projId}" },
                success: function() {
                    console.log("프로젝트 정산 상태가 자동으로 '완료' 변경되었습니다.");
                }
            });
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
        
        function fn_confirm_payment(billId) {
            var payDate = $("#payDate_" + billId).val();
            if(!payDate) { alert("입금 날짜를 선택해주세요."); return; }

            if(!confirm("입금 확인 처리를 하시겠습니까?")) return;
            
            $.ajax({
                url: "<c:url value='/pms/updateActualPayDtAjax.do'/>",
                type: "POST",
                data: { 
                    "billId": billId, 
                    "actualPayDt": payDate,
                    "projId": "${summary.projId}"
                },
                success: function(data) {
                    alert("입금 확인 처리가 완료되었습니다.");
                    location.reload();
                }
            });
        }
        
        function fn_edit_billing(billId, title, amt, taxDate) {
            $("#form_billId").val(billId);
            $("#billTitle").val(title);
            $("#billAmt").val(amt);
            $("input[name='taxBillDt']").val(taxDate === '-' ? '' : taxDate);
            
            $("#formTitle").text("내역 수정 : ").css("color", "orange");
            $("#btnSubmit").text("수정하기").removeClass("btn-blue").addClass("btn-yellow");
            $("#btnCancel").show();
            
            $("#billTitle").focus();
        }

        function fn_reset_form() {
            $("#form_billId").val("");
            $("#billingForm")[0].reset();
            $("#formTitle").text("내역 추가 : ").css("color", "black");
            $("#btnSubmit").text("저장").removeClass("btn-yellow").addClass("btn-blue");
            $("#btnCancel").hide();
        }

        function fn_save_billing() {
            var billId = $("#form_billId").val();
            var title = $("#billTitle").val();
            var amt = parseInt($("#billAmt").val() || 0);
            
            var totalAmt = parseInt($("#rawTotalAmt").val());
            var billedDisplay = parseInt($("#totalBilledAmtDisplay").text().replace(/,/g, ''));
            
            var originalAmt = 0;
            if(billId) {
                originalAmt = parseInt($("#row_" + billId + " .billed-value").attr("data-value") || 0);
            }
            
            var currentBalance = totalAmt - (billedDisplay - originalAmt);

            if(!title) { alert("청구 명칭을 입력하세요."); return; }
            if(amt <= 0) { alert("금액을 정확히 입력하세요."); return; }
            
            if(amt > currentBalance) {
                alert("계약 잔액(" + currentBalance.toLocaleString() + "원)을 초과할 수 없습니다.");
                return;
            }
            
            var url = billId ? "<c:url value='/pms/updateBillingAjax.do'/>" : "<c:url value='/pms/addBillingAjax.do'/>";

            $.ajax({
                url: url,
                type: "POST",
                data: $("#billingForm").serialize(),
                dataType: "json",
                success: function(data) {
                    if(data.status == "success") {
                        alert(billId ? "수정되었습니다." : "추가되었습니다.");
                        location.reload();
                    } else {
                        alert("처리 실패: " + data.message);
                    }
                }
            });
        }
        
        function fn_cancel_payment(billId) {
            if(!confirm("입금 확인을 취소하시겠습니까?")) return;
            $.ajax({
                url: "<c:url value='/pms/updateActualPayDtAjax.do'/>",
                type: "POST",
                data: { "billId": billId, "actualPayDt": "", "projId": "${summary.projId}" },
                success: function() { location.reload(); }
            });
        }
        
    </script>
</body>
</html>