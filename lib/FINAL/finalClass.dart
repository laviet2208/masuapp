import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/Cost.dart';


import '../GENERAL/NormalUser/accountLocation.dart';
import '../GENERAL/NormalUser/accountNormal.dart';
import '../GENERAL/Order/Receiver.dart';
import '../GENERAL/Order/item_details.dart';
import '../GENERAL/Product/Product.dart';
import '../GENERAL/Product/Voucher.dart';
import '../GENERAL/Tool/Time.dart';

final accountNormal currentAccount = accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0);

//Các controllerTextbike
final startcontroller = TextEditingController();
final endcontroller = TextEditingController();


final accountLocation bikeGetLocation = accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"); // điểm đón xe ôm
final accountLocation bikeSetLocation = accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"); // điểm trả xe ôm

//người nhận
final Receiver currentReceiver = Receiver(location: accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"), locationNote: 'NA', name: 'NA', phoneNum: 'NA', note: 'NA');
final item_details currentitemdetail = item_details(weight: -1, type: 'NA', codFee: -1);

//giỏ hàng
final List<Product> cartList = [];
final List<Product> storeList = [];

//voucher đang chọn
final Voucher chosenvoucher = Voucher(id: 'NA', totalmoney: 0, mincost: 0, startTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), useCount: 0, maxCount: 0, tenchuongtrinh: '', LocationId: '', type: 1, Otype: '', perCustom: 0, CustomList: [], maxSale: 0);
final Cost bikeCost = Cost(departKM: 2, departCost: 25000, perKMcost: 15000, discount: 20);
final Cost carCost = Cost(departKM: 2, departCost: 25000, perKMcost: 15000, discount: 20);
final Cost FoodCost = Cost(departKM: 2, departCost: 25000, perKMcost: 15000, discount: 20);
final Cost ItemCost = Cost(departKM: 2, departCost: 25000, perKMcost: 15000, discount: 20);

final Time currentPage = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);

final accountLocation currentLocatio = accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: '');