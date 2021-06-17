package cn.edu.njust.controller;

import cn.edu.njust.entity.Users;
import cn.edu.njust.service.UserService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import cn.edu.njust.utils.FileUploadTool;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.UUID;


@Controller
public class UpLoadController {
    private FileUploadTool fileUploadTool;
    @Autowired
    UserService userService;

    @RequestMapping(value = "/toUpload")
    public String toUpLoadPage(Model model)throws Exception{
        return "/page/imgUpload";
    }

//    上传文件控制器
    @RequestMapping(value = "/uploadImg")
    public String uploadImg(Model model, MultipartFile file,HttpServletRequest request)throws Exception{
        String pic_path=request.getServletContext().getRealPath("/static/upload/");
//        图片保存到路径下并且将返回文件的名称
        String avatar =translate(file,pic_path);
        model.addAttribute("image",avatar);
        //重定向到查询所有用户的Controller，测试图片回显
        return "page/test";
    }
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
