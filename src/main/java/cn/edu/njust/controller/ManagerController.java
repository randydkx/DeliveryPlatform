package cn.edu.njust.controller;

import cn.edu.njust.entity.Manager;
import cn.edu.njust.entity.Restaurant;
import cn.edu.njust.service.ManagerService;
import cn.edu.njust.service.RestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

import static jdk.nashorn.internal.runtime.regexp.joni.Config.log;

@Controller
@RequestMapping(value = "/manager")
public class ManagerController {
    @Autowired
    ManagerService managerService;
    @Autowired
    RestService restService;



//    manager同意某商家的申请
    @RequestMapping(value = "/accepted")
    public String acceptOntRest(@RequestParam String resID, Model model){
        managerService.acceptOneRest(resID);
        model.addAttribute("message","成功达成申请");
        return "redirect: toManagerMainPage.do";
    }

//    manager拒绝某商家的申请
    @RequestMapping(value = "/reject")
    public String rejectOneRest(@RequestParam String resID,Model model){
        managerService.rejectOneRest(resID);
        log.println("商家"+resID+"未通过审批");
        model.addAttribute("message","manager拒绝商家审批");
        return "redirect: toManagerMainPage.do";
    }

    @RequestMapping(value = "/toManagerMainPage")
    public String showApprovePage(Model model ,HttpSession session){
        List<Restaurant> listOfNotAccepted = managerService.listAllNotAccepted();
        System.out.println("总计未审批的数量"+listOfNotAccepted.size());
        model.addAttribute("listOfNotAccepted",listOfNotAccepted);
        Manager manager = (Manager)session.getAttribute("manager");
        List<Restaurant> listOfAccepted = managerService.ListAllAcceptedRest(manager.getManagerID());
        model.addAttribute("listOfAccepted",listOfAccepted);
        System.out.println("总计已经审批的数量："+listOfAccepted.size());
        return "page/manager/mainPage";
    }

    @ResponseBody
    @RequestMapping(value = "/viewOneResInfo")
    public Restaurant viewOneResInfo(@RequestBody Restaurant restaurant){
        System.out.println("想要通过申请的餐馆的编号是"+restaurant.getResID());
        Restaurant res=restService.selectResByID(restaurant.getResID());
        return res;
    }

    @ResponseBody
    @RequestMapping(value = "/viewOneResInfoOfAccepted")
    public Restaurant viewOneResInfoOfAccepted(@RequestBody Restaurant restaurant){
        System.out.println("想要通过申请的餐馆的编号是"+restaurant.getResID());
        Restaurant res=restService.selectResByID(restaurant.getResID());
        return res;
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session){
        session.removeAttribute("manager");
        return "page/login";
    }
}
