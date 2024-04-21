import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';

class future_location_name_by_coordinates extends StatefulWidget {
  final Location location;
  const future_location_name_by_coordinates({super.key, required this.location});

  @override
  State<future_location_name_by_coordinates> createState() => _future_location_name_by_coordinatesState();
}

class _future_location_name_by_coordinatesState extends State<future_location_name_by_coordinates> {

  Container get_main_text(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
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
      future: fetchLocationName(widget.location),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return get_main_text('Đang tải vị trí');
        }

        if (snapshot.hasError) {
          return get_main_text('Vui lòng chọn hoặc cho phép vị trí');
        }

        if (!snapshot.hasData) {
          return get_main_text('Vui lòng chọn hoặc cho phép vị trí');
        }

        return get_main_text(snapshot.data!);
      },
    );
  }
}
