package cn.edu.njust.service.Impl;

import cn.edu.njust.entity.Manager;
import cn.edu.njust.entity.Restaurant;
import cn.edu.njust.mapper.ManagerMapper;
import cn.edu.njust.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService {
    @Autowired
    private ManagerMapper managerMapper;

    @Override
    public Manager getManagerByID(String managerID) {
        return managerMapper.selectByID(managerID);
    }

    @Override
    public List<Restaurant> ListAllAcceptedRest(String managerID) {
        return managerMapper.listAllAcceptedRest(managerID);
    }

    @Override
    public List<Restaurant> listAllNotAccepted() {
        return managerMapper.listAllNotAccepted();
    }

    @Override
    public Restaurant oneNotAccepted(String resID) {
        return managerMapper.queryOneNotAccepted(resID);
    }

    @Override
    public void acceptOneRest(String resID) {
        managerMapper.acceptOneRest(resID);
    }

    @Override
    public int queryNumOfNotAccepted() {
        return managerMapper.queryNumOfNotAccepted();
    }

    @Override
    public BigDecimal queryBankAmount(String managerID) {
        return managerMapper.queryBankAmount(managerID);
    }

    @Override
    public void rejectOneRest(String resID) {
        managerMapper.rejectOneRest(resID);
    }

    @Override
    public List<Manager> findAll() {
        return null;
    }

    @Override
    public Manager findById(int id) {
        return null;
    }

    @Override
    public void create(Manager manager) {

    }

    @Override
    public void delete(int id) {

    }

    @Override
    public void update(Manager manager) {

    }


}
