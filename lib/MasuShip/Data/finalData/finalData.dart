import 'package:masuapp/MasuShip/Data/OrderData/Order.dart';
import 'package:masuapp/MasuShip/Data/accountData/shipperAccount.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/cartProduct.dart';
import 'package:masuapp/MasuShip/Data/costData/Cost.dart';

import '../accountData/Account.dart';
import '../accountData/shopData/Product.dart';
import '../accountData/userAccount.dart';
import '../costData/restaurantCost.dart';
import '../costData/weatherCost.dart';
import '../locationData/Location.dart';
import '../otherData/Time.dart';

class finalData {
  static Account account = UserAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
      location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),);

  static shipperAccount shipper_account = shipperAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
      location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), onlineStatus: 0, money: 0, license: '', orderHaveStatus: 0);

  static UserAccount user_account = UserAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
    location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),);

  static DateTime lastOrderTime = DateTime(0,0,0,0,0,0);

  static List<String> restaurant_type_images = ['assets/image/icontrang1/icon_5sao.png', 'assets/image/icontrang1/icon_anvat.png', 'assets/image/icontrang1/icon_bun.png', 'assets/image/icontrang1/icon_com.png', 'assets/image/icontrang1/icon_khuyenmai.png', 'assets/image/icontrang1/icon_monnhau.png', 'assets/image/icontrang1/icon_nuocuong.png', 'assets/image/icontrang1/icon_thucannhanh.png', 'assets/image/icontrang1/icon_trasua.png',];

  static List<String> restaurant_type_names = ['Năm sao', 'Ăn vặt', 'Bún phở', 'Cơm', 'Khuyến mãi', 'Món nhậu', 'Nước uống', 'Fast food', 'Trà sữa',];

  static Cost bikeCost = Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0);

  static weatherCost weathercost = weatherCost(available: 0, cost: 0, weatherTitle: '');

  static restaurantCost restaurantcost = restaurantCost(discount: 0);

  static List<cartProduct> cartList = [];
}