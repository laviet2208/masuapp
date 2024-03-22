import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../areaData/Area.dart';

class search_page_area extends StatefulWidget {
  final Area area;
  const search_page_area({Key? key, required this.area}) : super(key: key);

  @override
  State<search_page_area> createState() => _search_page_areaState();
}

class _search_page_areaState extends State<search_page_area> {
  String query = '';
  final control = TextEditingController();
  List<Area> filteredList = [];
  final List<Area> list_area = [];

  void get_area_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      list_area.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        list_area.add(area);
        filteredList = list_area.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_data();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          TextField(
            controller: control,
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Tìm kiếm',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(filteredList[index].name),
                    onTap: () {
                      control.text = filteredList[index].name;
                      widget.area.name = filteredList[index].name;
                      widget.area.id = filteredList[index].id;
                      setState(() {

                      });
                    }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
