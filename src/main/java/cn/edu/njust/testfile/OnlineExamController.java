package cn.edu.njust.testfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/onlineExam")
@Controller
public class OnlineExamController {

    @Autowired
    private OnlineExamFacade onlineExamFacade;

    // 配置访问subws.html
    @RequestMapping(value = {"subws"}, method = RequestMethod.GET)
    public String subws() {
        return "subws";
    }

    // 配置访问sendws.html
    @RequestMapping(value = {"sendws"}, method = RequestMethod.GET)
    public String sendws() {
        return "sendws";
    }

    //订阅消息测试--添加用户信息
    @RequestMapping("/insert")
    @ResponseBody
    public boolean insertUser(String userId) {
        return onlineExamFacade.insertUser(userId);
    }

    @Autowired
    private SimpMessagingTemplate template;

    //广播发送消息
    @MessageMapping(Constant.FORETOSERVERPATH)//@MessageMapping和@RequestMapping功能类似，用于设置URL映射地址，浏览器向服务器发起请求，需要通过该地址。
    public WiselyResponse say(WiselyMessage message) throws Exception {
        // 所有用户
        List<String> userId = onlineExamFacade.send2Users();
        userId.forEach(s -> {
            template.convertAndSendToUser(s.toString(), Constant.P2PPUSHPATH, new WiselyResponse(message.getName()));
        });
        return null;
    }
}