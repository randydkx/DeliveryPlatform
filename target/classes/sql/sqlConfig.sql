#表1
#创建dishType表

set foreign_key_checks = 0;

drop table if exists `dishType`;
create table `dishType`(
	`dishTypeID` int(10) AUTO_INCREMENT COLLATE utf8_general_ci NOT NULL,#菜品类型编号
    `dishTypeName` varchar(30) COLLATE utf8_general_ci NOT NULL,#菜品类型名称
    primary key(`dishTypeID`) using BTREE
)ENGINE=INNODB AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#表2
#创建restaurantType表
drop table if exists `resType`;
create table `resType`(
	`resTypeID` int(10) AUTO_INCREMENT COLLATE utf8_general_ci NOT NULL,#餐馆类型标号
    `resTypeName` varchar(30) COLLATE utf8_general_ci NOT NULL,#餐馆类型名称
    primary key(`resTypeID`) using BTREE
)ENGINE=INNODB AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


#表3
#创建manager表
drop table if exists `manager`;
create table `manager`(
	`managerID`  varchar(20) COLLATE utf8_general_ci NOT NULL,#管理员标识
    `password` varchar(30)  COLLATE utf8_general_ci NOT NULL,#管理员密码
    `accountID` varchar(20) COLLATE utf8_general_ci NOT NULL,#管理员账号
    primary key(`managerID`),
    FOREIGN KEY(`accountID`) REFERENCES bank(`accountID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


#表4
#创建restaurant表
drop table if exists `restaurant`;
create table `restaurant`(
	`resID` varchar(10) COLLATE utf8_general_ci NOT NULL,#餐馆识别码
    `locate` varchar(40) COLLATE utf8_general_ci NOT NULL,#餐馆地点
    `name` varchar(30) COLLATE utf8_general_ci NOT NULL,#餐馆名称
    `password` varchar(30) COLLATE utf8_general_ci NOT NULL,#登录密码
    `startTime` int(10) COLLATE utf8_general_ci default 9,#开始营业时间
    `endTime` int(10) COLLATE utf8_general_ci default 21,#结束营业时间
    `accountID` varchar(20) COLLATE utf8_general_ci NOT NULL,#餐馆账户
    `resPhone` varchar(20) COLLATE utf8_general_ci NOT NULL,#餐馆电话
    `resTypeID` int(10) COLLATE utf8_general_ci NOT NULL,#餐馆类型编号
    `balance` double COLLATE utf8_general_ci default 0,#餐馆收入
    `accepted` int(1) COLLATE utf8_general_ci default 0,#是否通过申请
    `score` int(10) COLLATE utf8_general_ci default 0,#餐馆的评分
    `managerID` varchar(20) COLLATE utf8_general_ci NOT NULL,#上级管理者
    primary key(`resID`) using BTREE,
    FOREIGN KEY(`resTypeID`) REFERENCES resType(`resTypeID`) ON DELETE CASCADE ON UPDATE CASCADE ,
	FOREIGN KEY(`managerID`) REFERENCES manager(`managerID`) ON DELETE CASCADE ON UPDATE CASCADE ,
	FOREIGN KEY(`accountID`) REFERENCES bank(`accountID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


#表5
# 创建dish表
drop table if exists `dish`;
create table `dish`(
	`dishID` int(12) AUTO_INCREMENT COLLATE utf8_general_ci NOT NULL,#菜品标识
    `dishTypeID` int(10) COLLATE utf8_general_ci NOT NULL,#菜品类型
    `remain` int(11) COLLATE utf8_general_ci default 0,#现存余量
    `description` varchar(300) COLLATE utf8_general_ci default '该菜品没有介绍',#菜品介绍
    `startTime` datetime COLLATE utf8_general_ci NOT NULL,#菜品上架时间
    `price` double COLLATE utf8_general_ci NOT NULL,
    `name` varchar(30) COLLATE utf8_general_ci NOT NULL,#菜品的名称
    `resID` varchar(10) COLLATE utf8_general_ci NOT NULL,#餐馆的编号
    `discount` double COLLATE utf8_general_ci default 1.0,#折扣
    `saleAmount` int(10) COLLATE utf8_general_ci default 0,#销售量
    `score` int(10) COLLATE utf8_general_ci default 0,#评分
    primary key (`dishID`) using BTREE,
    #创建级联删除以及级联更新
    FOREIGN KEY(`dishTypeID`) REFERENCES dishType(`dishTypeID`) ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY(`resID`) REFERENCES  restaurant(`resID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


#表6
#创建bank
drop table if exists `bank`;
create table `bank`(
	`accountID` varchar(20) COLLATE utf8_general_ci NOT NULL,
    `password` varchar(20) COLLATE utf8_general_ci NOT NULL,
    `amount` decimal(32) COLLATE utf8_general_ci NOT NULL,
    primary key (`accountID`) using BTREE
)ENGINE=INNODB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


#表7
#创建user表
drop table if exists `users`;
create table `users`(
	`userID` int(12) AUTO_INCREMENT COLLATE utf8_general_ci NOT NULL,
    `userName` varchar(30)  COLLATE utf8_general_ci NOT NULL,
    `password` varchar(20) COLLATE utf8_general_ci NOT NULL,
    `address` varchar(30) COLLATE utf8_general_ci NOT NULL,
    `email` varchar(20) COLLATE utf8_general_ci NOT NULL,
    `avatar` varchar(100) COLLATE utf8_general_ci NOT NULL,
    `userState` varchar(30) COLLATE utf8_general_ci NOT NULL,
    `phoneNum` varchar(20) COLLATE utf8_general_ci NOT NULL,
    `accountID` varchar(20) COLLATE utf8_general_ci NOT NULL,
    `score` int COLLATE utf8_general_ci default 0,
    primary key(`userID`) using BTREE,
    FOREIGN KEY(`accountID`) REFERENCES  bank(`accountID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


#表8
#创建order表
#order是mysql的关键字
drop table if exists `orders`;
create table `orders`(
	`orderID` int(12) AUTO_INCREMENT COLLATE utf8_general_ci NOT NULL,
    `userID` int(12) COLLATE utf8_general_ci NOT NULL,
    `resID` varchar(10) COLLATE utf8_general_ci NOT NULL,
    `orderTime` datetime COLLATE utf8_general_ci NOT NULL,
    `state` varchar(20) COLLATE utf8_general_ci default 'indelivery',
    primary key(`orderID`) using BTREE,
    FOREIGN KEY(`userID`) REFERENCES users(`userID`) ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY(`resID`) REFERENCES restaurant(`resID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';



#表9
drop table if exists `orderItem`;
create table `orderItem`(
	`orderItemID` int(11) AUTO_INCREMENT COLLATE utf8_general_ci NOT NULL,
    `dishID` int(12) COLLATE utf8_general_ci NOT NULL,
    `orderID` int(12) COLLATE utf8_general_ci NOT NULL,
    `count` int(10) COLLATE utf8_general_ci NOT NULL,
    primary key(`orderItemID`) using BTREE,
    FOREIGN KEY(`orderID`) REFERENCES orders(`orderID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


#表10
drop table  if exists `review`;
create table `review`(
	`reviewID` int(11) AUTO_INCREMENT COLLATE utf8_general_ci NOT NULL,
    `userID` int(12) COLLATE utf8_general_ci NOT NULL,
    `content` varchar(300) COLLATE utf8_general_ci default '该用户没有进行评价',
    `time` datetime COLLATE utf8_general_ci NOT NULL,
    `resID` varchar(10) COLLATE utf8_general_ci NOT NULL,
    primary key(`reviewID`) using BTREE,
    FOREIGN KEY(`resID`) REFERENCES restaurant(`resID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


#表11
drop table if exists `delivery`;
create table `delivery`(
	`deliveryID` int(11) AUTO_INCREMENT COLLATE utf8_general_ci NOT NULL,
    `orderID` int(12) COLLATE utf8_general_ci NOT NULL,
    `phone` varchar(30) COLLATE utf8_general_ci default '13218875296',
    `method` varchar(30) COLLATE utf8_general_ci default '理工配送',
    `time` datetime COLLATE utf8_general_ci NOT NULL,
    `finish` int(2) COLLATE utf8_general_ci default 0,
    primary key(`deliveryID`) using BTREE,
    FOREIGN KEY(`orderID`) REFERENCES orders(`orderID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';



set foreign_key_checks = 1;



#插入bank


INSERT INTO BANK(`ACCOUNTID`,`PASSWORD`,`AMOUNT`) VALUE('17851093886','17851093886','10000');
INSERT INTO BANK(`ACCOUNTID`,`PASSWORD`,`AMOUNT`) VALUE('13218875296','13218875296','10000');
INSERT INTO BANK(`ACCOUNTID`,`PASSWORD`,`AMOUNT`) VALUE('19825000668','19825000668','10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000000', '100000000' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000001', '100000001' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000002', '100000002' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000003', '100000003' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000004', '100000004' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000005', '100000005' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000006', '100000006' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000007', '100000007' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000008', '100000008' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '100000009', '100000009' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000010', '1000000010' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000011', '1000000011' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000012', '1000000012' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000013', '1000000013' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000014', '1000000014' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000015', '1000000015' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000016', '1000000016' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000017', '1000000017' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000018', '1000000018' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000019', '1000000019' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000020', '1000000020' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000021', '1000000021' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000022', '1000000022' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000023', '1000000023' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000024', '1000000024' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000025', '1000000025' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000026', '1000000026' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000027', '1000000027' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000028', '1000000028' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000029', '1000000029' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000030', '1000000030' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000031', '1000000031' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000032', '1000000032' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000033', '1000000033' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000034', '1000000034' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000035', '1000000035' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000036', '1000000036' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000037', '1000000037' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000038', '1000000038' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000039', '1000000039' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000040', '1000000040' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000041', '1000000041' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000042', '1000000042' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000043', '1000000043' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000044', '1000000044' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000045', '1000000045' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000046', '1000000046' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000047', '1000000047' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000048', '1000000048' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000049', '1000000049' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000050', '1000000050' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000051', '1000000051' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000052', '1000000052' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000053', '1000000053' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000054', '1000000054' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000055', '1000000055' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000056', '1000000056' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000057', '1000000057' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000058', '1000000058' ,'10000');
INSERT INTO bank(`accountID`,`password`,`amount`) VALUE( '1000000059', '1000000059' ,'10000');




#插入dishType
INSERT INTO dishType(`dishTypeName`) VALUE( '饺子馄饨' );
INSERT INTO dishType(`dishTypeName`) VALUE( '快餐便当' );
INSERT INTO dishType(`dishTypeName`) VALUE( '汉堡薯条' );
INSERT INTO dishType(`dishTypeName`) VALUE( '意面披萨' );
INSERT INTO dishType(`dishTypeName`) VALUE( '包子粥类' );
INSERT INTO dishType(`dishTypeName`) VALUE( '米粉面类' );
INSERT INTO dishType(`dishTypeName`) VALUE( '麻辣烫冒菜' );
INSERT INTO dishType(`dishTypeName`) VALUE( '川湘菜' );
INSERT INTO dishType(`dishTypeName`) VALUE( '江浙菜' );
INSERT INTO dishType(`dishTypeName`) VALUE( '粤菜' );
INSERT INTO dishType(`dishTypeName`) VALUE( '东北菜' );
INSERT INTO dishType(`dishTypeName`) VALUE( '油炸食品' );
INSERT INTO dishType(`dishTypeName`) VALUE( '西餐牛排' );
INSERT INTO dishType(`dishTypeName`) VALUE( '夹馍饼类' );
INSERT INTO dishType(`dishTypeName`) VALUE( '鸭脖卤味' );
INSERT INTO dishType(`dishTypeName`) VALUE( '日料寿司' );
INSERT INTO dishType(`dishTypeName`) VALUE( '韩式料理' );
INSERT INTO dishType(`dishTypeName`) VALUE( '香锅干锅' );
INSERT INTO dishType(`dishTypeName`) VALUE( '火锅' );
INSERT INTO dishType(`dishTypeName`) VALUE( '海鲜烧烤' );
INSERT INTO dishType(`dishTypeName`) VALUE( '轻食沙拉' );
INSERT INTO dishType(`dishTypeName`) VALUE( '粉丝汤' );
INSERT INTO dishType(`dishTypeName`) VALUE( '面包' );
INSERT INTO dishType(`dishTypeName`) VALUE( '奶茶' );
INSERT INTO dishType(`dishTypeName`) VALUE( '果汁' );
INSERT INTO dishType(`dishTypeName`) VALUE( '鲜果' );
INSERT INTO dishType(`dishTypeName`) VALUE( '冰淇淋' );
INSERT INTO dishType(`dishTypeName`) VALUE( '甜品' );



#插入resType
INSERT INTO resType(`resTypeName`) VALUE( '快餐便当' );
INSERT INTO resType(`resTypeName`) VALUE( '火锅烤鱼' );
INSERT INTO resType(`resTypeName`) VALUE( '日韩料理' );
INSERT INTO resType(`resTypeName`) VALUE( '甜品饮品' );
INSERT INTO resType(`resTypeName`) VALUE( '水果店铺' );
INSERT INTO resType(`resTypeName`) VALUE( '小吃烧烤' );
INSERT INTO resType(`resTypeName`) VALUE( '米粉面馆' );
INSERT INTO resType(`resTypeName`) VALUE( '地方菜馆' );

#插入manager
INSERT INTO MANAGER(`managerID`,`PASSWORD`,`accountID`) VALUES('17851093886','17851093886','17851093886');
INSERT INTO MANAGER(`managerID`,`PASSWORD`,`accountID`) VALUES('13218875296','13218875296','13218875296');
INSERT INTO MANAGER(`managerID`,`PASSWORD`,`accountID`) VALUES('19825000668','19825000668','19825000668');


#插入restaurant
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000000','孝陵卫晏公庙新村2栋', '七家湾牛肉锅贴' ,'100000000' ,'5' ,'21' ,'100000000' ,'13815896762' ,'6' ,'10000' ,'1' ,'96' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000032','玄武区童卫路7号', '吉祥馄饨' ,'100000001' ,'7' ,'20' ,'100000001' ,'13815896762' ,'6' ,'10000' ,'1' ,'98' ,'19825000668');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000064', '玄武区罗汉巷2栋', '哈尔滨水饺' ,'100000002' ,'0' ,'24' ,'100000002' ,'13815896762' ,'6' ,'10000' ,'0' ,'90' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000096','孝陵卫罗汉巷12栋', '福庆水饺炸酱面' ,'100000003' ,'6' ,'22' ,'100000003' ,'13815896762' ,'6' ,'10000' ,'1' ,'96' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000128', '中山门大街297号钟鼎名悦广场114室', '苗小坛酸菜鱼捞饭' ,'100000004' ,'10' ,'21' ,'100000004' ,'13815896762' ,'1' ,'10000' ,'1' ,'91' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000160', '玄武区银城东苑1号103室', '老乡鸡' ,'100000005' ,'6' ,'22' ,'100000005' ,'13815896762' ,'1' ,'10000' ,'1' ,'95' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000192', '玄武区孝陵卫街85号', '孟氏黄焖鸡' ,'100000006' ,'9' ,'23' ,'100000006' ,'13815896762' ,'1' ,'10000' ,'1' ,'98' ,'19825000668');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000224', '孝陵卫罗汉巷7幢110室', '骨头饭' ,'100000007' ,'10' ,'21' ,'100000007' ,'13815896762' ,'1' ,'10000' ,'1' ,'100' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000256', '天坛村16幢12号', '厨子与辣子' ,'100000008' ,'10' ,'21' ,'100000008' ,'13815896762' ,'2' ,'10000' ,'1' ,'97' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000288', '玄武区友谊路100号S50号', '鸡来鲜鸡小地锅' ,'100000009' ,'10' ,'21' ,'100000009' ,'13815896762' ,'2' ,'10000' ,'1' ,'96' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000320', '四方村中队一队1号', '川小妞麻辣香锅' ,'1000000010' ,'9' ,'22' ,'1000000010' ,'13815896762' ,'2' ,'10000' ,'1' ,'96' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000352', '孝陵卫南京理工大学一号路A2-2', '乡村无骨烤鱼饭' ,'1000000011' ,'9' ,'21' ,'1000000011' ,'13815896762' ,'2' ,'10000' ,'1' ,'91' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000384', '玄武区友谊路100号N06号', '和风便当' ,'1000000012' ,'10' ,'20' ,'1000000012' ,'13815896762' ,'3' ,'10000' ,'1' ,'97' ,'17851093886');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000416', '玄武区中山门大街301号北京华联超市', 'N多寿司' ,'1000000013' ,'8' ,'22' ,'1000000013' ,'13815896762' ,'3' ,'10000' ,'1' ,'96' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000448', '玄武区双拜巷151号', '晨曦日式料理' ,'1000000014' ,'9' ,'20' ,'1000000014' ,'13815896762' ,'3' ,'10000' ,'1' ,'91' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000480', '秦淮区苜蓿园东街2号', '韩式石锅拌饭' ,'1000000015' ,'0' ,'24' ,'1000000015' ,'13815896762' ,'3' ,'10000' ,'1' ,'95' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000512', '玄武区中山门大街297号钟鼎名悦广场127室', '喜霖川烤肉拌饭' ,'1000000016' ,'10' ,'21' ,'1000000016' ,'13815896762' ,'3' ,'10000' ,'1' ,'97' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000544', '玄武区友谊路100号品硕广场', '1点点' ,'1000000017' ,'10' ,'22' ,'1000000017' ,'13815896762' ,'4' ,'10000' ,'1' ,'99' ,'17851093886');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000576', '玄武区银城东苑1号金石楼', '巴黎贝甜' ,'1000000018' ,'7' ,'22' ,'1000000018' ,'13815896762' ,'4' ,'10000' ,'1' ,'99' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000608', '玄武区中山门大街297号6栋327号', '贡茶' ,'1000000019' ,'10' ,'24' ,'1000000019' ,'13815896762' ,'4' ,'10000' ,'1' ,'98' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000640', '太平南路168号309室', '卡漫莫尼蛋糕' ,'1000000020' ,'7' ,'20' ,'1000000020' ,'13815896762' ,'4' ,'10000' ,'1' ,'98' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000672', '秦淮区星海路8-1号', '百果园' ,'1000000021' ,'8' ,'23' ,'1000000021' ,'13815896762' ,'5' ,'10000' ,'1' ,'96' ,'17851093886');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000704', '玄武区后宰门街19号东楼101室', '茂盛果园' ,'1000000022' ,'7' ,'23' ,'1000000022' ,'13815896762' ,'5' ,'10000' ,'1' ,'98' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000736', '玄武区小卫街228号01幢105室', '鲜丰水果' ,'1000000023' ,'8' ,'23' ,'1000000023' ,'13815896762' ,'5' ,'10000' ,'1' ,'98' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000768', '玄武区中山门大街99号君临紫金商业街120号', '龙门花甲' ,'1000000024' ,'0' ,'24' ,'1000000024' ,'13815896762' ,'6' ,'10000' ,'1' ,'90' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000800', '长白街464号', '喜辣烧烤' ,'1000000025' ,'0' ,'24' ,'1000000025' ,'13815896762' ,'6' ,'10000' ,'1' ,'98' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000832', '玄武区小卫街16-3号', '刘长兴面馆' ,'1000000026' ,'7' ,'20' ,'1000000026' ,'13815896762' ,'7' ,'10000' ,'1' ,'97' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000864', '罗汉巷1号10幢8号', '寻味螺螺蛳粉' ,'1000000027' ,'10' ,'23' ,'1000000027' ,'13815896762' ,'7' ,'10000' ,'1' ,'99' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000896', '秦淮区银龙花园三期35幢104号', '味之美过桥米线' ,'1000000028' ,'0' ,'24' ,'1000000028' ,'13815896762' ,'7' ,'10000' ,'1' ,'98' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000928', '玄武区罗汉巷123号04幢102室', '盛旺缘面馆' ,'1000000029' ,'6' ,'21' ,'1000000029' ,'13815896762' ,'7' ,'10000' ,'1' ,'97' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000960', '玄武区小卫街20号', '褚记北京烤鸭店' ,'1000000030' ,'10' ,'21' ,'1000000030' ,'13815896762' ,'8' ,'10000' ,'1' ,'97' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000000992', '玄武区罗汉巷123号03幢', '金陵小碗菜' ,'1000000031' ,'10' ,'21' ,'1000000031' ,'13815896762' ,'8' ,'10000' ,'1' ,'97' ,'19825000668');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000001024', '紫金明珠34幢110号', '外婆记菜饭骨头汤' ,'1000000032' ,'9' ,'21' ,'1000000032' ,'13815896762' ,'8' ,'10000' ,'1' ,'94' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000001056', '玄武区小卫街16号3幢7号', '巴蜀鱼蛙' ,'1000000033' ,'9' ,'21' ,'1000000033' ,'13815896762' ,'8' ,'10000' ,'1' ,'97' ,'13218875296');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000001088', '万达新村57-1号', '兴隆川菜馆' ,'1000000034' ,'10' ,'24' ,'1000000034' ,'13815896762' ,'8' ,'10000' ,'1' ,'94' ,'19825000668');
INSERT INTO restaurant(`resID`,`locate`,`name`,`password`,`startTime`,`endTime`,`accountID`,`resPhone`,`resTypeID`,`balance`,`accepted`,`score`,`managerID`) VALUE('1000001120', '玄武区中山门大街9号', '南京大排档' ,'1000000035' ,'10' ,'21' ,'1000000035' ,'13815896762' ,'8' ,'10000' ,'1' ,'97' ,'13218875296');




#dish
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 100 ,'主料鸡肉，菜系为中餐，分量为300g，口味麻辣' ,'2020-07-01 09:55:00' ,'口水鸡' ,'1000000992' ,18 ,5.5 ,2132 ,96 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 200 ,'主料猪排骨，荤菜，分量约200g，口味辣' ,'2020-07-01 09:55:00' ,'红烧排骨' ,'1000000992' ,18 ,7.1 ,270,92);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 300 ,'主料鸡，腌菜，香菇，荤菜，分量约200g，口味微辣' ,'2020-07-01 09:55:00' ,'霸王别姬' ,'1000000992' ,18 ,6.6 ,750,95);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 150 ,'主料鸭肉，莴笋，鸭，菜系苏菜，分量约200g，口味咸' ,'2020-07-01 09:55:00' ,'金陵盐水鸭' ,'1000000992' ,18 ,6.0 ,164,95);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 100 ,'主料蛋黄，葱，鸭，鸭腿，菜系中餐，分量约200g，口味辣' ,'2020-07-01 09:55:00' ,'金陵烤鸭' ,'1000000992' ,18 ,6.0 ,1039,87);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 100 ,'主料有机蔬菜，青椒，面粉，菜系浙菜，分量约200g，口味不辣' ,'2020-07-01 09:55:00' ,'土豆烧牛肉' ,'1000000992' ,19 ,5.7 ,1221,91);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 200 ,'主料番茄，白糖，山椒，鸡蛋菜系家常菜，分量约250g，口味原味' ,'2020-07-01 09:55:00' ,'番茄炒蛋' ,'1000000992' ,14 ,4.2 ,1516,91);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 200 ,'主料青椒，火腿，鸡蛋，菜系鲁菜，分量约220g，口味香味' ,'2020-07-01 09:55:00' ,'青椒火腿炒鸡蛋' ,'1000000992' ,13 ,3.7 ,1576,93);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 200 ,'主料梅干菜，猪肉，荤菜，分量约200g，口味香味' ,'2020-07-01 09:55:00' ,'梅菜扣肉' ,'1000000992' ,20 ,5.9 ,28,92);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 200 ,'主料鸡肉，荤菜，菜系家常菜分量约200g，口味香味' ,'2020-07-01 09:55:00' ,'鱼香鸡柳' ,'1000000992' ,20 ,5.4 ,113,95);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 200 ,'主料黄瓜，猪头肉，荤菜，菜系中餐，分量约200g，口味微辣' ,'2020-07-01 09:55:00' ,'黄瓜拌猪头肉' ,'1000000992' ,19 ,6.2 ,150,98);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 9, 200 ,'主料黄豆，鸡肉，毛豆，菜系川菜，分量约200g，口味辣' ,'2020-07-01 09:55:00' ,'毛豆鸡丁' ,'1000000992' ,18 ,5.5 ,451,97);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 1, 100 ,'主料猪肉，分量约15g，清淡，口味咸味' ,'2020-07-01 09:55:00' ,'招牌小馄饨' ,'1000000032' ,18.8 ,0 ,132,87);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 1, 200 ,'主料猪肉，蛋黄，分量约270g，清淡，口味原味' ,'2020-07-01 09:55:00' ,'全家福馄饨' ,'1000000032' ,24.8 ,0 ,127,87);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 1, 200 ,'主料虾仁，分量约270g，清淡，口味原味' ,'2020-07-01 09:55:00' ,'哈尔滨水饺' ,'1000000064' ,23 ,0 ,325,66);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 2, 200 ,'主料香肠，毛豆，分量一碗，清淡，口味咸鲜' ,'2020-07-01 09:55:00' ,'香肠蒸豆米' ,'1000000160' ,14 ,0 ,487,87);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 2, 100 ,'主料葱油，鸡肉，分量一碗，家常菜，口味葱香' ,'2020-07-01 09:55:00' ,'葱油鸡' ,'1000000160' ,17 ,0,775,94);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 2, 100 ,'主料草鱼，辣椒，分量一碗，家常菜，鲜，口味香辣' ,'2020-07-01 09:55:00' ,'鸡汁辣鱼' ,'1000000160' ,14 ,0 ,371,94);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 6, 150 ,'主料牛肉，面条，口味咸鲜，一人份' ,'2020-07-01 09:55:00' ,'牛肉面' ,'1000000832' ,23 ,0 ,167,90);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 6, 100 ,'主料皮肚，香肠，猪肝，肉丝，青菜，西红柿' ,'2020-07-01 09:55:00' ,'六鲜面' ,'1000000928' ,22 ,0 ,96,94);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 6, 200 ,'主料猪肉，青椒，爽口，口味咸味' ,'2020-07-01 09:55:00' ,'青椒干子肉丝盖浇饭' ,'1000000928' ,15 ,0 ,75,94);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 7, 100 ,'主料四川农家土公鸡，干辣椒，大火热油现炒，一人份，口味辣味' ,'2020-07-01 09:55:00' ,'辣子鸡' ,'1000000256' ,15.8 ,0 ,598,92);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 8, 100 ,'主料现杀活鱼，老坛酸菜，鲶鱼，菜系为川菜，一人份，口味辣味' ,'2020-07-01 09:55:00' ,'酸菜鱼' ,'1000000256' ,18.8 ,0 ,214,84);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 8, 200 ,'主料上等猪肉，青椒，菜系为川菜，分量为300g，口味为辣味' ,'2020-07-01 09:55:00' ,'回锅肉' ,'1000000256' ,16.8 ,0 ,150,86);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 7, 100 ,'正宗陈氏麻婆豆腐工艺，主料为汉源贡椒，豆腐，菜系为川菜，一人份' ,'2020-07-01 09:55:00' ,'麻婆豆腐' ,'1000000256' ,13.8 ,0 ,160,96);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 14, 200 ,'主料黄牛肉，菜系为苏菜，口感香酥，分量一两五只' ,'2020-07-01 09:55:00' ,'牛肉锅贴一两' ,'1000000000' ,9 ,0 ,1414,100);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 14, 100 ,'主料牛杂，干丝，豆腐干，分量一碗，口味咸鲜' ,'2020-07-01 09:55:00' ,'牛杂干丝汤' ,'1000000000' ,18 ,0 ,20,90 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 15, 100 ,'精选新鲜食材，坚持小锅现炒，均衡搭配更营养，主料鸭肉，大米，口味辣味' ,'2020-07-01 09:55:00' ,'青椒烤鸭丝套餐饭' ,'1000000960' ,50 ,4.6 ,75,94 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 15, 100 ,'包含烤鸭约18片，两个褚记馍饼以及一套葱饼酱，主料鸭肉，胡萝卜，孜然，黄瓜，菜系北京菜，口味椒盐' ,'2020-07-01 09:55:00' ,'烤鸭套餐' ,'1000000960' ,28.99 ,0 ,390,100 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 15, 100 ,'主料鸭脖，口味酱香' ,'2020-07-01 09:55:00' ,'酱香鸭脖' ,'1000000960' ,10.99 ,0 ,50,94 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 16, 100 ,'主食一份，味增汤一份，蔬菜沙拉一份' ,'2020-07-01 09:55:00' ,'照烧鸡排饭套餐' ,'1000000384' ,38.8 ,5.13 ,1275,93 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 16, 100 ,'主料章鱼，面粉，分量六个，口味咸鲜' ,'2020-07-01 09:55:00' ,'章鱼小丸子' ,'1000000384' ,20 ,4.4 ,338,85);
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 16, 100 ,'主食一份，味增汤一份，蔬菜沙拉一份' ,'2020-07-01 09:55:00' ,'咖喱鸡排饭套餐' ,'1000000384' ,37.8 ,5.26 ,264,95 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 17, 100 ,'主食五常米饭，鸡蛋，胡萝卜，腊肠，分量一碗，口味甜辣' ,'2020-07-01 09:55:00' ,'香肠石锅拌饭' ,'1000000480' ,16 ,0 ,140,98 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 17, 100 ,'主料肥牛，优质大米，肥牛片，分量一碗，口味香辣' ,'2020-07-01 09:55:00' ,'肥牛石锅拌饭' ,'1000000480' ,21 ,0 ,149,66 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 18, 100 ,'主料虾饼，大虾，虾丸，开花肠，一份米饭，口味微辣' ,'2020-07-01 09:55:00' ,'麻辣香锅单人' ,'1000000320' ,37.8 ,5.26 ,264,95 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 18, 100 ,'主料鸡腿，土豆片，青椒，鱼豆腐，腐竹，一份米饭，菜系为苏菜' ,'2020-07-01 09:55:00' ,'地锅鸡腿饭' ,'1000000288' ,20 ,0 ,821,92 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 19, 100 ,'主料排骨，土豆片，腐竹，青椒，鱼豆腐，米饭一份，口味微辣' ,'2020-07-01 09:55:00' ,'地锅排骨饭' ,'1000000288' ,26 ,0 ,50,95 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 24, 200 ,'四季春茶搭配特选植脂末，由黄金比例调制而成，香滑顺口，份量一杯' ,'2020-07-01 09:55:00' ,'四季奶青' ,'1000000544' ,13 ,0 ,457,92 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 24, 200 ,'奶茶搭配波霸，口感软，红茶，波霸，植脂末，份量一杯' ,'2020-07-01 09:55:00' ,'波霸奶茶' ,'1000000544' ,13 ,0 ,344,90 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 24, 200 ,'精选米酿和奶茶的碰撞，主料红茶，米酒，份量一杯' ,'2020-07-01 09:55:00' ,'桂花米酿奶茶' ,'1000000608' ,16 ,9.38 ,131,100 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 28, 200 ,'红豆包' ,'2020-07-01 09:55:00' ,'红豆包' ,'1000000576' ,9 ,0 ,88,95 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 28, 200 ,'芋泥空气小蛋糕' ,'2020-07-01 09:55:00' ,'芋泥空气小蛋糕' ,'1000000576' ,6 ,0 ,88,95 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 28, 200 ,'葡式蛋挞' ,'2020-07-01 09:55:00' ,'葡式蛋挞' ,'1000000576' ,6.5 ,0 ,28,95 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 28, 200 ,'新鲜现做，新鲜水果夹心，主料蛋糕胚，芒果，奶油，蓝莓，份量一个' ,'2020-07-01 09:55:00' ,'芒果生日蛋糕' ,'1000000640' ,138 ,2.2 ,380,96 );
INSERT INTO dish(`dishTypeID`,`remain`,`description`,`startTime`,`name`,`resID`,`price`,`discount`,`saleAmount`,`score`) VALUE( 28, 200 ,'新鲜现做，新鲜水果夹心，主料蛋糕胚，高级奶油' ,'2020-07-01 09:55:00' ,'黑森林蛋糕' ,'1000000640' ,168 ,2.38 ,125,95 );


#insert users
INSERT INTO users(`userName`,`password`,`address`,`email`,`avatar`,`userState`,`phoneNum`,`accountID`,`score`) VALUES( '王安文' , '19825000668' , '南京市南京理工大学（南大门）' , '19825000668@qq.com', 'http://localhost:8888/img/1324123413241324123.jpg','registered', '19825000668', '19825000668',  '2000' );
INSERT INTO users(`userName`,`password`,`address`,`email`,`avatar`,`userState`,`phoneNum`,`accountID`,`score`) VALUES( '宋涛' , '13218875296' , '南京理工大学宁静轩' , '13218875296@qq.com', '8967986789678967967987897.jpg', 'registered', '13218875296', '13218875296', '1000' );
INSERT INTO users(`userName`,`password`,`address`,`email`,`avatar`,`userState`,`phoneNum`,`accountID`,`score`) VALUES( '罗文水' , '17851093886' , '南京理工大学明理居' , '1551904915@qq.com', '56457487251446345745.jpg', 'registered', '17851093886', '17851093886', '1000' );


#插入orders
INSERT INTO orders(`userID`,`resID`,`orderTime`,`state`) VALUES( 1, '1000000992' ,'2020-07-03 09:55:00' ,'nopay' );
INSERT INTO orders(`userID`,`resID`,`orderTime`,`state`) VALUES( 2, '1000000992' ,'2020-07-03 10:55:00' ,'alreadypay' );
INSERT INTO orders(`userID`,`resID`,`orderTime`,`state`) VALUES( 3, '1000000992' ,'2020-07-03 11:55:00' ,'indelivery' );
INSERT INTO orders(`userID`,`resID`,`orderTime`,`state`) VALUES( 2, '1000000992' ,'2020-07-03 13:55:00' ,'alreadyreview' );



#插入orderitem
INSERT INTO orderitem(`orderID`,`dishID`,`count`) VALUES(  4,  1, 2 );
INSERT INTO orderitem(`orderID`,`dishID`,`count`) VALUES(  4,  2,1  );
INSERT INTO orderitem(`orderID`,`dishID`,`count`) VALUES(  4,  3, 1 );
INSERT INTO orderitem(`orderID`,`dishID`,`count`) VALUES(  4, 1 ,2  );
INSERT INTO orderitem(`orderID`,`dishID`,`count`) VALUES(  2, 23 ,4  );
INSERT INTO orderitem(`orderID`,`dishID`,`count`) VALUES(  3,  32, 5 );


#插入delivery
INSERT INTO delivery(`orderID`,`time`,`finish`) VALUES(  4, '2020-07-01 09:55:00' , 1  );
INSERT INTO delivery(`orderID`,`time`,`finish`) VALUES( 3 , '2020-07-01 09:55:00' , 0 );


#插入review
INSERT INTO review(`userID`,`content`,`time`,`resID`) values(2,'菜品非常地美味！！','2020-07-01 09:55:00','1000000992');




