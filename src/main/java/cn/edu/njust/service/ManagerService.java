package cn.edu.njust.service;

import cn.edu.njust.entity.Manager;
import cn.edu.njust.entity.Restaurant;

import java.math.BigDecimal;
import java.util.List;

public interface ManagerService extends BaseService<Manager> {
//    通过名称查找manager
    Manager getManagerByID(String managerID);
//    列举所有已经经过同意且属于当前manager的餐馆
    List<Restaurant> ListAllAcceptedRest(String managerID);
//    列举当前manager的所欲未经过同意的餐馆
    List<Restaurant> listAllNotAccepted();
//    查看一个未经过审批的餐馆的信息
    Restaurant oneNotAccepted(String resID);
//    审批申请
    void acceptOneRest(String resID);
//    查询没有经过审批的餐馆的数量
    int queryNumOfNotAccepted();
//    查看账户余额
    BigDecimal queryBankAmount(String managerID);
//    经理拒绝某商家的申请，将accept设置为2
    void rejectOneRest(String resID);
}
