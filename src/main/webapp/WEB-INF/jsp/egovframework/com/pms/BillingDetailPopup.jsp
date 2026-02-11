<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>청구 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com-billingdetailpopup.css'/>">
    <style>
	    .btn_s_blue { background: #5998eb !important; color: white !important; border: none !important; }
		.btn_s_red  { background: #f7928b !important; color: white !important; border: none !important; }
		.btn_s_gray { background: #666666 !important; color: white !important; border: none !important; }
		.btn_s_purple { background: #673AB7 !important; color: white !important; border: none !important; }
    .file-popover {
	    display: none; 
	    position: absolute; 
	    background: white; 
	    border: 1px solid #ccc;
	    box-shadow: 0 4px 10px rgba(0,0,0,0.2); 
	    border-radius: 8px; 
	    padding: 10px;
	    z-index: 9999; 
	    min-width: 250px;
	}
	.file-popover-close { float: right; cursor: pointer; color: #999; font-weight: bold; }    
    </style>
    <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
	
	<script type="text/javascript">
	    function fn_egov_downFile(atchFileId, fileSn) {
	        window.open("<c:url value='/cmm/fms/FileDown.do'/>?atchFileId="+atchFileId+"&fileSn="+fileSn);
	    }
	    
	    function fn_egov_deleteFile(atchFileId, fileSn) {
	        if(confirm("삭제하시겠습니까?")) {
	        }
	    }
	</script>
    
</head>
<body class="billing-popup">
    <div class="popup-header">
        <h2>📂 프로젝트명 : ${summary.projNm}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr><th>계약명</th><td>${summary.contNm}</td></tr>
        <tr><th>고객사명</th><td>${summary.custNm}</td></tr>
        <tr><th>계약담당자</th><td>${summary.picUserNm}</td></tr>
        
        <tr>
	        <td colspan="2" style="padding:0;">
	            <details style="padding: 10px; background: #f9f9f9; cursor: pointer;">
	                <summary style="font-size: 12px; color: #666; font-weight: bold;">
	                    더보기
	                </summary>
	                
	                <table class="w3-table" style="margin-top: 10px; background: #fff; border: 1px solid #ddd;">
	                    <colgroup>
	                        <col style="width:29%;">
	                        <col style="width:71%;">
	                    </colgroup>
				        <tr><th>영업건명</th><td>${summary.salesTitle}</td></tr>
				        <tr><th>영업담당자</th><td>${summary.salesUserNm}</td></tr>
				        <tr><th>프로젝트 주담당자</th><td>${summary.mainMgrNm}</td></tr>
				        <tr><th>프로젝트 부담당자</th><td>${summary.subMgrNm}</td></tr>
				        <tr><th>계약금액</th><td><fmt:formatNumber value="${summary.totalAmt}" pattern="#,###"/>원</td></tr>
				        <tr><th>영업메모</th><td>${summary.salesContent}</td></tr>
				        <tr><th>업무메모</th><td>${summary.contRemark}</td></tr>
	        		</table>
           	 </details>
        	</td>
	    </tr>
    </table>

    <div id="summaryArea" class="summary-box">
        <input type="hidden" id="rawTotalAmt" value="${summary.totalAmt}">
        <div>
            <span style="font-size: 14px; color: #666;">총 계약 금액</span><br>
            <strong style="font-size: 18px;"><fmt:formatNumber value="${summary.totalAmt}" pattern="#,###"/></strong>원
        </div>
        <div>
            <span style="font-size: 14px; color: #666;">누적 청구액</span><br>
            <strong id="totalBilledAmtDisplay" style="font-size: 18px;"><fmt:formatNumber value="${summary.totalBilledAmt}" pattern="#,###"/></strong>원
        </div>
        <div>
            <span style="font-size: 14px; color: #666;">실수금 합계</span><br>
            <strong id="totalPaidAmtDisplay" style="font-size: 18px; color: #28a745;"><fmt:formatNumber value="${summary.totalPaidAmt}" pattern="#,###"/></strong>원
        </div>
        <div>
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
                <th>세금계산서 발행일</th>
                <th>입금 예정일</th>
                <th>입금 확인일</th>
                <th>첨부</th>
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
                    <td>${bill.payDt != null ? bill.payDt : '-'}</td>
                    <td>
                        <c:choose>
                            <c:when test="${empty bill.actualPayDt || bill.actualPayDt == '-'}">
                                <input type="date" id="payDate_${bill.billId}" style="width:110px; font-size:11px;">
                                <button type="button" class="btn-blue" style="padding:2px 5px; font-size:11px;"
                                        onclick="fn_confirm_payment('${bill.billId}')">입금 확인</button>
                            </c:when>
                            <c:otherwise>
                                <div style="display: flex; justify-content: space-between; align-items: center; padding: 0 5px;">
                                    <span style="color:blue; font-weight:bold;"><i class="fa fa-check-circle"></i>${bill.actualPayDt}</span>
                                    <button type="button" style="border:none; background:none; color:gray; cursor:pointer; font-size:11px;"
                                            onclick="fn_cancel_payment('${bill.billId}')">취소</button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <%-- <td>
					    <div id="file_list_${bill.billId}">
					        <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
					            <c:param name="param_atchFileId" value="${bill.atchFileId}" />
					            <c:param name="atchFileId" value="${bill.atchFileId}" />
					        </c:import>
					    </div>
					    
					    <button type="button" class="btn_blue" style="font-size:11px; padding:2px 5px;"
					            onclick="fn_prepare_upload('${bill.billId}', '${bill.atchFileId}')">파일첨부</button>
					</td> --%>
                    <td>
					    <c:if test="${not empty bill.atchFileId}">
					        <span onclick="fn_open_file_popover(event, '${bill.atchFileId}')" 
					              style="cursor:pointer; color:#2196F3; font-weight:bold; font-size:16px;" title="파일보기">📎</span>
					    </c:if>
					    <button type="button" class="btn_s_purple" style="font-size:10px; padding:1px 4px; margin-left:5px;"
					            onclick="fn_prepare_upload('${bill.billId}', '${bill.atchFileId}')">추가</button>
					</td>
                    <td>
                        <button type="button" class="btn_yellow" style="padding:2px 5px; font-size:11px;"
                               onclick="fn_edit_billing('${bill.billId}', '${bill.billTitle}', '${bill.billAmt}', '${bill.taxBillDt}', '${bill.payDt}')">수정</button>
                        <button type="button" class="btn_red" style="padding:2px 5px;"
                                onclick="fn_delete_billing('${bill.billId}', ${bill.billAmt})">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="form-container">
        <form id="billingForm">
            <input type="hidden" name="billId" id="form_billId" value="">
            <input type="hidden" name="projId" value="${summary.projId}">
            <input type="hidden" name="lastUpdusrId" value="${loginVO.id}">

            <strong class="form-title" id="formTitle">📂 내역 추가</strong>

            <div class="form-row">
                <div class="form-group" style="flex: 1.5;">
                    <label>청구 명칭</label>
                    <input type="text" name="billTitle" id="billTitle" placeholder="예: 2차 중도금">
                </div>
                <div class="form-group">
                    <label>청구 금액 (원)</label>
                    <input type="number" name="billAmt" id="billAmt" placeholder="0">
                </div>
                <div class="form-group">
                    <label>발행일 (세금계산서)</label>
                    <input type="date" name="taxBillDt">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>입금 예정일</label>
                    <input type="date" name="payDt">
                </div>
                <div class="form-group" style="flex: 2;">
                    <label>비고 (메모)</label>
                    <input type="text" name="billRemark" placeholder="특이사항을 입력하세요">
                </div>
            </div>

            <div class="btn-area">
                <button type="button" id="btnCancel" class="btn_red" style="display:none; margin-right:5px;" onclick="fn_reset_form();">취소</button>
                <button type="button" id="btnSubmit" onclick="fn_save_billing();">내역 저장</button>
            </div>
        </form>
    </div>

    <div class="btn-close">
    	
        <button type="button" onclick="window.close();" class="btn_s_gray">닫기</button>
    </div>
	
	<div id="filePopover" class="file-popover">
	    <span class="file-popover-close" onclick="$('#filePopover').hide();">&times;</span>
	    <div id="popoverContent" style="margin-top:15px; font-size:12px;"></div>
	</div>
	
	<iframe id="hiddenDownFrame" name="hiddenDownFrame" style="display:none;"></iframe>
	
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js'></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

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
                success: function() { console.log("상태 자동 변경 성공"); }
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
                data: { "billId": billId, "actualPayDt": payDate, "projId": "${summary.projId}" },
                success: function() { alert("처리가 완료되었습니다."); location.reload(); }
            });
        }

        function fn_edit_billing(billId, title, amt, taxDate, payDate) {
            $("#form_billId").val(billId);
            $("#billTitle").val(title);
            $("#billAmt").val(amt);
            $("input[name='taxBillDt']").val(taxDate === '-' ? '' : taxDate);
            $("input[name='payDt']").val(payDate === '-' ? '' : payDate);
            $("#formTitle").text("내역 수정 : ").css("color", "orange");
            $("#btnSubmit").text("수정하기").removeClass("btn-blue").addClass("btn_yellow");
            $("#btnCancel").show();
            $("#billTitle").focus();
        }

        function fn_reset_form() {
            $("#form_billId").val("");
            $("#billingForm")[0].reset();
            $("#formTitle").text("내역 추가").css("color", "#333");
            $("#btnSubmit").text("내역 저장").removeClass("btn_yellow").addClass("btn-blue");
            $("#btnCancel").hide();
        }

        function fn_save_billing() {
            var billId = $("#form_billId").val();
            var title = $("#billTitle").val();
            var amt = parseInt($("#billAmt").val() || 0);
            var totalAmt = parseInt($("#rawTotalAmt").val());
            var billedDisplay = parseInt($("#totalBilledAmtDisplay").text().replace(/,/g, ''));
            var originalAmt = billId ? parseInt($("#row_" + billId + " .billed-value").attr("data-value") || 0) : 0;
            var currentBalance = totalAmt - (billedDisplay - originalAmt);

            if(!title) { alert("청구 명칭을 입력하세요."); return; }
            if(amt <= 0) { alert("금액을 정확히 입력하세요."); return; }
            if(amt > currentBalance) { alert("계약 잔액(" + currentBalance.toLocaleString() + "원)을 초과할 수 없습니다."); return; }

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
                        alert("저장에 실패했습니다: " + data.message);
                    }
                },
                error: function() { alert("서버 통신 오류가 발생했습니다."); }
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
        
        var currentTargetBillId = "";
        var currentTargetAtchId = "";

        function fn_prepare_upload(billId, atchId) {
            currentTargetBillId = billId;
            currentTargetAtchId = atchId;
            $("#commonFileInput").click();
        }

        function fn_handle_file_change() {
            var fileInput = document.getElementById('commonFileInput');
            if (fileInput.files.length === 0) return;

            var formData = new FormData();
            for (var i = 0; i < fileInput.files.length; i++) {
                formData.append("file_" + i, fileInput.files[i]);
            }
            
            formData.append("billId", currentTargetBillId);
            formData.append("atchFileId", currentTargetAtchId);

            $.ajax({
                url: "<c:url value='/pms/uploadFileAjax.do'/>",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    alert("파일이 성공적으로 업로드되었습니다.");
                    location.reload(); 
                }
            });
        }
        
        function fn_open_file_popover(e, atchFileId) {
            if(!atchFileId || atchFileId === "") return;
            if (e.stopPropagation) e.stopPropagation();

            var rect = e.target.getBoundingClientRect();
            $("#filePopover").css({
                top: (window.pageYOffset + rect.bottom + 5) + "px",
                left: (window.pageXOffset + rect.left - 150) + "px"
            }).show();

            $("#popoverContent").html("<div style='text-align:center; padding:10px;'>불러오는 중...</div>");

            $.ajax({
                url: "<c:url value='/cmm/fms/selectFileInfs.do'/>",
                data: { "param_atchFileId": atchFileId },
                dataType: "html", 
                success: function(html) {
                    $("#popoverContent").html(html);
                },
                error: function() {
                    $("#popoverContent").html("파일 목록을 불러오지 못했습니다.");
                }
            });
        }

        $(document).on("click", function(e) {
            if (!$(e.target).closest("#filePopover, span[onclick*='fn_open_file_popover']").length) {
                $("#filePopover").hide();
            }
        });
    </script>
    <input type="file" id="commonFileInput" style="display:none;" onchange="fn_handle_file_change();" multiple>
</body>
</html>