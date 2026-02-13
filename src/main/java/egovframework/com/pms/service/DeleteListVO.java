package egovframework.com.pms.service;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class DeleteListVO extends egovframework.com.cmm.ComDefaultVO{
	private String targetType;
    private String targetId;
    private String title;
    private String delDt;
    private String delUsrId;
}
