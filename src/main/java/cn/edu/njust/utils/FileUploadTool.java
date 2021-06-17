package cn.edu.njust.utils;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.UUID;

public class FileUploadTool {
    //    文件写入并且返回文件名称以及扩展名
   public String translate(MultipartFile file, String pic_path)throws Exception{
        String name = UUID.randomUUID().toString().replaceAll("-", "");
        //获取文件的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
//       將圖片保存在out目錄中
        file.transferTo(new File(pic_path+"/"+name + "." + ext));
        return name + "." + ext;
    }
    public String getUploadPath(HttpServletRequest request){
        return request.getServletContext().getRealPath("/static/upload/");
    }
}
