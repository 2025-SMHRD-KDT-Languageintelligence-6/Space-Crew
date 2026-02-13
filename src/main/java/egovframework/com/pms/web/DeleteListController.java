package egovframework.com.pms.web;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.pms.service.DeleteListService;
import egovframework.com.pms.service.DeleteListVO;

@Controller
public class DeleteListController {
	
	@Resource(name = "DeleteListService")
    private DeleteListService deleteListService;

    @RequestMapping("/pms/restoreDataAjax.do")
    @ResponseBody
    public String restoreDataAjax(@ModelAttribute("vo") DeleteListVO vo) {
        try {
            deleteListService.restoreData(vo);
            return "SUCCESS";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }
    
    @RequestMapping("/pms/deleteList.do")
    public String selectDeleteList(@ModelAttribute("searchVO") DeleteListVO vo, ModelMap model) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(vo.getPageIndex());
        paginationInfo.setRecordCountPerPage(vo.getPageUnit());
        paginationInfo.setPageSize(vo.getPageSize());

        vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        vo.setLastIndex(paginationInfo.getLastRecordIndex());
        vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        List<DeleteListVO> resultList = deleteListService.selectDeleteList(vo);
        model.addAttribute("resultList", resultList);

        int totCnt = deleteListService.selectDeleteListTotCnt(vo);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/DeleteList";
    }
}
