package cn.edu.njust.service.Impl;

import cn.edu.njust.entity.*;
import cn.edu.njust.mapper.*;
import cn.edu.njust.service.TransactionService;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static jdk.nashorn.internal.runtime.regexp.joni.Config.log;

@Service
public class TransactionServiceImpl implements TransactionService {
//    mapper自动注入
    @Autowired
    AccountMapper accountMapper;
    @Autowired
    RestMapper restMapper;
    @Autowired
    ManagerMapper managerMapper;
    @Autowired
    UserMapper userMapper;
    @Autowired
    OrderMapper orderMapper;

    @Override
    public void modifyAmount(String accountID, BigDecimal money) {
        Bank bank = new Bank();
        bank.setAccountID(accountID);
        bank.setAmount(money);
        accountMapper.modify(bank);
    }

    @Override
    public boolean Transaction(BigDecimal payAmount, String resID, String managerID,int userID) {
        try{
            Restaurant restaurant = restMapper.selectResByID(resID);
            Manager manager =managerMapper.selectByID(managerID);
            Bank managerBank=accountMapper.selectByID(manager.getAccountID());
            Bank restBank=accountMapper.selectByID(restaurant.getAccountID());
            Users user=userMapper.selectById(userID);
            Bank userBank=accountMapper.selectByID(user.getAccountID());
            if(userBank.getAmount().compareTo(payAmount) == -1){
                System.out.println("交易失败，银行余额不足");
                return false;
            }else{
//                更新金钱方面的交易信息
                BigDecimal managerFinalMoney=managerBank.getAmount().add(payAmount.multiply(new BigDecimal(0.05)));
                BigDecimal restFinalMoney=restBank.getAmount().add(payAmount.multiply(new BigDecimal(0.95)));
                BigDecimal userFinalMoney = userBank.getAmount().subtract(payAmount);
                Restaurant toUpdate = new Restaurant();
                toUpdate.setBalance(payAmount.doubleValue()*0.95+restaurant.getBalance());
                toUpdate.setResID(restaurant.getResID());
                restMapper.updateRestBalance(toUpdate);

//                更新用户的评分
                Map<String,String> condition = new HashMap<>();
                condition.put("userID",String.valueOf(userID));
                System.out.println(new String("###############################################"));
                int finalScore = user.getScore()+(int)Math.ceil(payAmount.doubleValue());
                System.out.println("用户的最终评分是"+String.valueOf(finalScore));
                condition.put("score",String.valueOf(finalScore));
                userMapper.updateScore(condition);

                this.modifyAmount(user.getAccountID(),userFinalMoney);
                this.modifyAmount(manager.getAccountID(),managerFinalMoney);
                this.modifyAmount(restBank.getAccountID(),restFinalMoney);
                System.out.println("交易成功===================\n用户成功支付："+payAmount.toString());
                System.out.println("餐馆最终银行中金额："+restFinalMoney.toString());
                System.out.println("管理员最终银行中金额："+managerFinalMoney.toString());
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("交易失败，回滚回原状态");
            return false;
        }
    }

//    用户取消订单之后的交易回退
    @Override
    public boolean TransactionBack(Orders oneOrder) {
        String resID = oneOrder.getResID();
        Restaurant restaurant=restMapper.selectResByID(resID);
        int userID = oneOrder.getUserID();
        Users user=userMapper.selectById(userID);
        QueryOrderFullDetail orderFullDetail = orderMapper.queryOrderFullDetail(oneOrder.getOrderID());
        double totalValue = 0;
        for(ExtendOrderItem orderItem : orderFullDetail.getOrderItems()){
            totalValue+=orderItem.getItemPrice();
        }
        oneOrder.setTotalPrice(totalValue);
//        退款的时候是餐馆将所有的钱（总价钱）从自己的bank中扣除，全部加入用户的bank中去
        String resAccount = restMapper.selectResByID(resID).getAccountID();
        String userAccount = userMapper.selectById(userID).getAccountID();
        Bank resBank = accountMapper.selectByID(resAccount);
        Bank userBank= accountMapper.selectByID(userAccount);
        BigDecimal userRemain = userBank.getAmount().add(new BigDecimal(totalValue));
        BigDecimal resRemain = resBank.getAmount().subtract(new BigDecimal(totalValue));
        if(resRemain.compareTo(new BigDecimal(0)) == -1){
//            餐馆的金额小于零，表示不能从餐馆的金额中扣除指定数量的花费
            return false;
        }else{
            this.modifyAmount(resAccount,resRemain);
            this.modifyAmount(userAccount,userRemain);
//        将商家的其余信息进行修改
//            改变商家的balance信息
            Restaurant toUpdate = new Restaurant();
            toUpdate.setBalance(restaurant.getBalance()-totalValue);
            toUpdate.setResID(resID);
            restMapper.updateRestBalance(toUpdate);

//            更新用户的评分信息，将用户的评分信息是原来的评分-交易的总价格-50，直到减到0,作为对用户取消订单的惩罚
            Map<String,String> condition = new HashMap<>();
            condition.put("userID",String.valueOf(userID));
            System.out.println(new String("###############################################"));
            log.println("用户的初始评分是："+user.getScore());
            String finalScore = String.valueOf(Math.max(user.getScore()-(int)Math.ceil(totalValue)-50,0));
            System.out.println("用户的最终评分是"+finalScore);
            condition.put("score",finalScore);
            userMapper.updateScore(condition);
            return true;
        }
    }

    @Override
    public List<Bank> findAll() {
        return null;
    }
    public Bank selectById(String accountID){
        return accountMapper.selectByID(accountID);
    }

    @Override
    public Bank findById(int id) {
        return null;
    }
    @Override
    public void create(Bank bank) {

    }

    @Override
    public void delete(int id) {

    }

    @Override
    public void update(Bank bank) {

    }

    @Override
    public Bank getBankByID(String id) {
        return accountMapper.selectByID(id);
    }

}
