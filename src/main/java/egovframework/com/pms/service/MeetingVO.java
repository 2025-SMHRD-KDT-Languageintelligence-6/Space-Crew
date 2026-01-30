package egovframework.com.pms.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MeetingVO implements Serializable {
	
    private static final long serialVersionUID = 1L;

    private int meetId;
    private String meetTitle;
    private String meetDt;
    private String contentFull;
    private String contentSum;
    private String actionItems;
    private String filePath;
    private String lastUpdusrId;
    private String lastUpdtPnttm;
    private String atchFileId;
    
    private String searchKeyword;
    
    private String searchStartDt;
    private String searchEndDt;
}