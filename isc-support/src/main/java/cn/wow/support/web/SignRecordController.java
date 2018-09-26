package cn.wow.support.web;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.wow.common.domain.Combo;
import cn.wow.common.domain.SignRecord;
import cn.wow.common.service.ComboService;
import cn.wow.common.service.SignRecordService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "signRecord")
public class SignRecordController  extends AbstractController{

    private static Logger logger = LoggerFactory.getLogger(SignRecordController.class);

    @Autowired
    private SignRecordService signRecordService;
    @Autowired
    private ComboService comboService;

    @RequestMapping(value = "/list")
    public String list(HttpServletRequest httpServletRequest, Model model, Long appId, Integer type, Date effectiveDate, Date expireDate) {
       
    	Map<String, Object> map = new PageMap(httpServletRequest);
		map.put("custom_order_sql", "create_time desc");
		map.put("appId", appId);
        List<SignRecord> dataList = signRecordService.selectAllList(map);

        model.addAttribute("dataList", dataList);
        return "/signrecord/signrecord_list";
    }

    @RequestMapping(value = "/detail")
    public String detail(HttpServletRequest request, Model model, String id){
        if(StringUtils.isNotBlank(id)){
            SignRecord signRecord = signRecordService.selectOne(Long.parseLong(id));
            model.addAttribute("facadeBean", signRecord);
        }

        model.addAttribute("mode", request.getParameter("mode"));
        return "signrecord_detail";
    }

    @ResponseBody
    @RequestMapping(value = "/save")
    public AjaxVO save(HttpServletRequest request, Model model, String id, Integer type, Long comboId, Long appId){
    	AjaxVO vo = new AjaxVO();
		vo.setSuccess(true);
        SignRecord signRecord = null;

        try{
        	Combo combo = comboService.selectOne(comboId);
        	
            if(StringUtils.isNotBlank(id)){
                signRecord = signRecordService.selectOne(Long.parseLong(id));
                signRecord.setType(type);
                signRecord.setComboId(comboId);
                signRecord.setPrice(combo.getPrice());
                
                Date date = new Date();
                signRecord.setEffectiveDate(date);
                signRecord.setExpireDate(date);
                
                signRecord.setAppId(appId);
                signRecord.setCreateTime(date);
                signRecordService.update(getCurrentUserName(), signRecord);
                
                vo.setMsg("编辑成功");
            }else{
                signRecord = new SignRecord();
                signRecord.setType(type);
                signRecord.setComboId(comboId);
                signRecord.setPrice(combo.getPrice());
                
                Date date = new Date();
                signRecord.setEffectiveDate(date);
                signRecord.setExpireDate(date);
                
                signRecord.setAppId(appId);
                signRecord.setCreateTime(date);
                signRecordService.save(getCurrentUserName(), signRecord);

                vo.setMsg("新增成功");
            }
        }catch(Exception ex){
        	logger.error("签名记录保存失败", ex);
			vo.setMsg("保存失败，系统异常");
			vo.setSuccess(false);
			return vo;
        }

        return vo;
    }

    @ResponseBody
    @RequestMapping(value = "/delete")
    public AjaxVO delete(HttpServletRequest request, String id){
        AjaxVO vo = new AjaxVO();

        try{
        	SignRecord signRecord = signRecordService.selectOne(Long.parseLong(id));

            if(signRecord != null){
            	signRecordService.deleteByPrimaryKey(getCurrentUserName(), signRecord);
            }else{
            	vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
            }
        }catch(Exception ex){
        	ex.printStackTrace();
			logger.error("签名记录删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
        }

        return vo;
    }
}