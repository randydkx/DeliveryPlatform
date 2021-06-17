package cn.edu.njust.mapper;

import cn.edu.njust.entity.Dish;
import com.github.pagehelper.Page;
import java.util.Map;

public interface DishMapper {
//    通过条件查找所有菜品
    Page<Dish> findByPage(Map<String,String> con);
    void updateDishInfo(Dish dish);
    Dish findDishByDishID(int dishID);
}
