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
import '../otherData/Temporary.dart';
import '../otherData/Time.dart';

class finalData {
  static Account account = UserAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
      location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),);

  static shipperAccount shipper_account = shipperAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
      location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), onlineStatus: 0, money: 0, license: '', orderHaveStatus: 0, debt: 0);

  static UserAccount user_account = UserAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
    location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),);

  static DateTime lastOrderTime = DateTime(0,0,0,0,0,0);

  static List<String> restaurant_type_images = ['assets/image/icontrang1/icon_5sao.png', 'assets/image/icontrang1/icon_anvat.png', 'assets/image/icontrang1/icon_bun.png', 'assets/image/icontrang1/icon_com.png', 'assets/image/icontrang1/icon_khuyenmai.png', 'assets/image/icontrang1/icon_monnhau.png', 'assets/image/icontrang1/icon_nuocuong.png', 'assets/image/icontrang1/icon_thucannhanh.png', 'assets/image/icontrang1/icon_trasua.png',];
  static List<String> store_type_images = ['assets/image/icontrang2/iconthucpham.png', 'assets/image/icontrang2/iconraucu.png', 'assets/image/icontrang2/iconmebe.png', 'assets/image/icontrang2/icongiavi.png', 'assets/image/icontrang2/icongiadung.png', 'assets/image/icontrang2/icondokho.png', 'assets/image/icontrang2/icondohop.png', 'assets/image/icontrang2/icontrungsua.png', 'assets/image/icontrang2/iconbiaruou.png',];
  static List<String> restaurant_type_names = ['Năm sao', 'Ăn vặt', 'Bún phở', 'Cơm', 'Khuyến mãi', 'Món nhậu', 'Nước uống', 'Fast food', 'Trà sữa',];
  static List<String> store_type_names = ['Thực phẩm', 'Rau củ', 'Mẹ và bé', 'Gia vị', 'Gia dụng', 'Đồ khô', 'Đồ hộp', 'Trứng sữa', 'Đồ nhậu',];

  static Cost bikeShipCost = Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0);
  static Cost expressShipCost = Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0);
  static Cost requestBuyShipCost = Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0);
  static Cost foodShipCost = Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0);

  static weatherCost weathercost = weatherCost(available: 0, cost: 0, weatherTitle: '');

  static restaurantCost restaurantcost = restaurantCost(discount: 0);

  static List<cartProduct> cartList = [];
  static List<cartProduct> storeCartList = [];

  static bool jumpAds = true;

  static Temporary shipperIndexTempotary = Temporary(stringData: '', intData: 0, doubleData: 0);
}