import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/general_ingredient.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../general/search_location_dialog.dart';

class item_market_location extends StatefulWidget {
  final List<Location> list;
  final int index;
  final VoidCallback callback;
  const item_market_location({super.key, required this.index, required this.list, required this.callback});

  @override
  State<item_market_location> createState() => _item_market_locationState();
}

class _item_market_locationState extends State<item_market_location> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            child: Row(
              children: [
                Container(
                  width: 10,
                ),

                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/orangecircle.png')
                      )
                  ),
                ),

                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    height: 30,
                    width: width - 40 - 30 - 50 - 10,
                    child: AutoSizeText(
                      'Điểm mua hàng ' + (widget.index + 1).toString(),
                      style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 200,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  child: Container(
                    child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return search_location_dialog(location: widget.list[widget.index], title: 'Chọn điểm mua hàng', event: () {
                            widget.callback();
                          });
                        }
                    );
                  },
                ),

                GestureDetector(
                  child: Container(
                    child: Icon(Icons.delete_outline, color: Colors.redAccent,size: 20,),
                  ),
                  onTap: () {
                    widget.list.removeAt(widget.index);
                    widget.callback();
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 50, right: 10),
            child: FutureBuilder(
              future: fetchLocationName(widget.list[widget.index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return general_ingredient.get_location_text('Đang tải vị trí ...');
                }

                if (snapshot.hasError) {
                  return general_ingredient.get_location_text('Lỗi dữ liệu vị trí, vui lòng thử lại');
                }

                if (!snapshot.hasData) {
                  return general_ingredient.get_location_text('Lỗi dữ liệu vị trí, vui lòng thử lại');
                }

                return general_ingredient.get_location_text(snapshot.data!.toString());
              },
            ),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}
