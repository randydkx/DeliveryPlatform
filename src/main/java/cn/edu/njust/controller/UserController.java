package cn.edu.njust.controller;

import cn.edu.njust.entity.Users;
import cn.edu.njust.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.ui.Model;


//用户请求控制器
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/toLogin")
    public String toLoginPage(){
        return "page/user/login";
    }

    @RequestMapping("/login")
    public String login(@RequestParam String userName, @RequestParam String password, Model model) {
        Users users = userService.login(userName);
        if (users != null) {
            if (users.getPassword().equals(password)) {
                System.out.println("登录成功");
                model.addAttribute("message","success");
            }
            return "page/test";
        }else{
            System.out.println("用户名不存在");
        }
        return "page/test";
    }
    //    接受包装类参数的时候不需要设定RequestPara注解
    @RequestMapping(value = "/insertUser")
    public String insertUser(Users users,Model model){
        userService.create(users);
        String value="insert a user successfully!";
        model.addAttribute("message",value);
        System.out.println(value);
        return "page/test";
    }
}