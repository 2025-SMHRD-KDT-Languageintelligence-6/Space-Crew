<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>영업 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <style>
        body { padding: 20px; font-family: 'Malgun Gothic'; }
        .popup-header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-close { margin-top: 20px; text-align: center; }
        .btn_s_blue { background: #5998eb !important; color: white !important; border: none !important; }
		.btn_s_red  { background: #f7928b !important; color: white !important; border: none !important; }
		.btn_s_gray { background: #666666 !important; color: white !important; border: none !important; }
		.btn_s_purple { background: #673AB7 !important; color: white !important; border: none !important; }
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
<body>
    <div class="popup-header">
        <h2>📂 영업 정보 : ${salesVO.salesTitle}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>고객사</th>
            <td>${salesVO.custNm}</td>
        </tr>
        <tr>
            <th>영업담당자</th>
            <td>${salesVO.salesNm}</td>
        </tr>
        <tr>
            <th>예상금액</th>
            <td><fmt:formatNumber value="${salesVO.expectedAmt}" pattern="#,###"/>원</td>
        </tr>
        <tr>
            <th>예상 수주 시기</th>
            <td>${salesVO.expectedDt}</td>
        </tr>
        <tr>
            <th>확률</th>
            <td>${salesVO.probability}</td>
        </tr>
        <tr>
            <th>상태</th>
            <td>${salesVO.status}</td>
        </tr>
        <tr>
            <th>영업추진내용</th>
            <td>${salesVO.salesContent}</td>
        </tr>
        </table>

	<div class="file-upload-wrapper" style="margin: 20px 0; padding: 15px; background: #f8f9fa; border: 1px dashed #ccc;">
	    <h4 style="font-size:15px;"><i class="fa fa-upload"></i> 파일 업로드</h4>
	    <div style="display: flex; gap: 10px; align-items: center;">
	        <input type="file" id="ajaxFileInput" name="file_1" multiple style="flex-grow: 1;" />
	        <button type="button" onclick="fn_file_ajax_upload();" class="btn_blue" style="padding: 5px 15px; white-space: nowrap; min-width: 45px;">업로드</button>
	    </div>
	    <small style="color: #666;">* 여러 파일을 한 번에 선택할 수 있습니다.</small>
	</div>
	
    <div id="file_list_area">
	    <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
	        <c:param name="param_atchFileId" value="${salesVO.atchFileId}" />
	        <c:param name="atchFileId" value="${salesVO.atchFileId}" />
	    </c:import>
	</div>


    <div class="btn-close">
    	<button type="button" onclick="fn_go_update_page('${salesVO.salesId}');" class="btn_s_blue">수정</button>
        <button type="button" onclick="window.close();" class="btn_s_gray">닫기</button>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js'></script>
    
    <script>
		function fn_go_update_page(id) {
		    if(!id || id === "") {
		        alert("ID 정보가 없어 수정 페이지로 이동할 수 없습니다.");
		        return;
		    }
	
		    if (!window.opener || window.opener.closed) {
		        alert("부모 창을 찾을 수 없습니다.");
		        return;
		    }
		    if (!confirm("수정 페이지로 이동하시겠습니까?\n(현재 팝업은 자동으로 닫힙니다)")) return;
		    
		    var updateUrl = "<c:url value='/pms/updateSalesView.do'/>?selectedId=" + id;
		    
		    try {
		        window.opener.location.href = updateUrl;
		        
		        setTimeout(function() {
		            window.close();
		        }, 100);
		    } catch (e) {
		        window.opener.location = updateUrl;
		        window.close();
		    }
		}
		
		function fn_file_ajax_upload() {
    	    var fileInput = document.getElementById('ajaxFileInput');
    	    if (fileInput.files.length === 0) {
    	        alert("파일을 선택해주세요.");
    	        return;
    	    }
    	    var formData = new FormData();
    	    for (var i = 0; i < fileInput.files.length; i++) {
    	        formData.append("file_" + i, fileInput.files[i]);
    	    }
    	    formData.append("salesId", "${salesVO.salesId}");
    	    formData.append("atchFileId", "${salesVO.atchFileId}");

    	    $.ajax({
    	        url: "<c:url value='/pms/uploadFileAjax.do'/>",
    	        type: "POST",
    	        data: formData,
    	        processData: false,
    	        contentType: false,
    	        success: function(data) {
    	            if(data.status === "success") {
    	                alert("파일이 성공적으로 업로드되었습니다.");
    	                location.reload(); 
    	            } else {
    	                alert("오류 발생: " + data.message);
    	            }
    	        },
    	        error: function() { alert("서버 통신 오류가 발생했습니다."); }
    	    });
    	}
    </script>
</body>
</html>