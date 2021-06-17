package cn.edu.njust.service;

import cn.edu.njust.entity.Bank;
import cn.edu.njust.entity.Orders;

import java.math.BigDecimal;

public interface TransactionService extends BaseService<Bank>{
//    通过id获取bank
    public Bank getBankByID(String id);
//    对某account进行处理
    public void modifyAmount(String accountID,BigDecimal money);
//    转账业务，将收入的95%转给餐馆，将5%转给经理
    public boolean Transaction(BigDecimal payAmount,String resID,String managerID,int userID);
//    取消订单之后退款给商家,只退95%
    public boolean TransactionBack(Orders oneOrder);
}
