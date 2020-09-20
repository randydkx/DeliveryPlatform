package cn.edu.njust.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;

@Controller
public class UpLoadController {
    public String toUpLoadPage(Model model)throws Exception{
        return "/imgUpload";
    }

//    上传文件控制器
    @RequestMapping(value = "uploadImg")
    public String uploadImg(Model model,  MultipartFile file)throws Exception{
        String originalFilename = file.getOriginalFilename();
        String newFileName = null;
        if(file != null && originalFilename!=null && originalFilename.length()>0){
            String pic_path="E:\\SSMProject\\DeliveryPlatform\\web\\static\\upload\\";
            newFileName= UUID.randomUUID().toString().replaceAll("-","")+
                    originalFilename.substring(originalFilename.lastIndexOf("."));
            File newFile = new File(pic_path+newFileName);
            System.out.println("文件名："+newFileName);
            file.transferTo(newFile);
        }
        model.addAttribute("image",newFileName);
        return "page/imgUpload";
    }
}
