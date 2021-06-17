package cn.edu.njust.utils;

public class StaticConfig {
//    用户状态
    public static final String USER_STATE_REGISTERED="registered";
    public static final String USERS_TATE_DEPRECATED="deprecated";

//    订单状况
    public static final String ORDER_NO_PAY="nopay";
    public static final String ORDER_ALREADY_PAY="alreadypay";
    public static final String ORDER_IN_DELIVERY="indelivery";
    public static final String ORDER_CANCEL="cancel";
    public static final String ORDER_NO_REVIEW="noreview";
    public static final String ORDER_ALREADY_REVIEW="alreadyreview";

//   餐馆状态
    public static final int NOT_ACCEPTED=0;
    public static final int ACCEPTED=1;

//    缺省头像
    public static final String AVATAR="njust.jpg";

//    页面显示的菜品的数量
    public static final String PAGE_SIZE="6";

//    默认的时间格式
    public static final String TIME_PATTERN="yyyy-MM-dd";

//    测试餐馆编号
    public static final String TEST_RES_ID="1000000992";
//    餐馆在某月份无销售的key
    public static final String NO_SALES="noSales";

//    餐馆数据分析相关字段
    public static final String TOTAL_MONEY_IN_A_MONTH="total_money_in_a_month";
    public static final String TOTAL_SALES_IN_A_MONTH="total_sales_in_a_month";
    public static final String TOTAL_SALES_OF_DISHTYPE="total_sales_of_dishType";
    public static final String TOTAL_SCORE_OF_RES="total_score_of_res";
    public static final String TOTAL_ORDERS_IN_ALL_MONTH="total_orders_in_all_month";
    public static final String TOTAL_BALANCE="total_balance";
    public static final String TOTAL_COUNT_OF_DISHTYPE="total_count_of_dishType";
    public static final String AVG_SALE_AMOUNT="avg_sale_amount";


//    餐馆未通过注册申请情况下的缺省管理员
    public static final String DEFAULT_MANAGER="M-17851093886";
    public static final String DEFAULT_REST_IMAGE="njust.jpg";
}
