import 'package:flutter/material.dart';
import '../../../../../../Data/OrderData/catchOrder.dart';

class location_future_builder extends StatefulWidget {
  final Future<CatchOrder> futureFunc;
  final String type;
  const location_future_builder({super.key, required this.futureFunc, required this.type});

  @override
  State<location_future_builder> createState() => _location_future_builderState();
}

class _location_future_builderState extends State<location_future_builder> {

  Container get_future_content_text(String content) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        content != ' ' ? content : 'Điểm đến sẽ hiển thị ngay khi đơn hàng hoàn thành',
        textAlign: TextAlign.start,
        maxLines: 2,
        style: TextStyle(
            fontFamily: 'muli',
            color: Colors.black,
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.futureFunc,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return get_future_content_text('Đang tải...');
        }

        if (snapshot.hasError) {
          return get_future_content_text('Vui lòng chọn hoặc cho phép vị trí');
        }

        if (!snapshot.hasData) {
          return get_future_content_text('Vui lòng chọn hoặc cho phép vị trí');
        }

        return widget.type == 'start' ? get_future_content_text(snapshot.data!.locationSet.mainText + ' ' + snapshot.data!.locationSet.secondaryText) :
        get_future_content_text(snapshot.data!.locationGet.mainText + ' ' + snapshot.data!.locationGet.secondaryText);
      },
    );
  }
}
