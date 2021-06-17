package test.BankTest;

import cn.edu.njust.entity.Bank;
import cn.edu.njust.entity.Users;
import cn.edu.njust.mapper.AccountMapper;
import cn.edu.njust.mapper.UserMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.math.BigDecimal;

public class BankTest1 {
    //    spring+springMVC环境
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }

    @Test
    public void method(){
//      获取mapper的实例，与mapper对应，首字母小写
        AccountMapper accountMapper=(AccountMapper) applicationContext.getBean("accountMapper");
        Bank bank= accountMapper.selectByID("17851093886");
        System.out.println("银行中原有的金额："+bank.getAmount());
        System.out.println("银行中现有的金额："+bank.getAmount().subtract(new BigDecimal(100)));
        bank.setAmount(bank.getAmount().subtract(new BigDecimal(100)));
        accountMapper.modify(bank);
        bank= accountMapper.selectByID("17851093886");
        System.out.println("bank中的金额："+bank.getAmount());
    }
}
