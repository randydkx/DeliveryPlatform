package cn.edu.njust.mapper;

import cn.edu.njust.entity.Manager;
import cn.edu.njust.entity.Restaurant;

import java.math.BigDecimal;
import java.util.List;

public interface ManagerMapper {
//    通过managerID得到一条manager信息
    Manager selectByID(String managerID);
    List<Restaurant> listAllAcceptedRest(String managerID);
    List<Restaurant> listAllNotAccepted();
    Restaurant queryOneNotAccepted(String resID);
    void acceptOneRest(String resID);
    int queryNumOfNotAccepted();
    BigDecimal queryBankAmount(String managerID);
    void rejectOneRest(String resID);
}
