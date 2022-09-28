import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown({Key? key}) : super(key: key);
  @override
  _MyDropDown createState() => _MyDropDown();
}

class _MyDropDown extends State<MyDropDown> {
  String selectValue = "";
  List userItems = [];
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinput1 = TextEditingController();

  Future getAllUser() async {
    var url = "https://jsonplaceholder.typicode.com/users";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        userItems = jsonData;
      });
    }
    print(userItems);
  }

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    dateinput1.text = "";
    getAllUser();
  }

  var dropdownvalue;
  var dropdownvalue1;
  bool isChecked = false;
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var selectedDate3;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo đơn nghỉ việc"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              child: Column(
                children: [
                  DropdownButtonFormField(
                    hint: Text('Nhân Viên'),
                    borderRadius: BorderRadius.circular(3),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nhân viên",
                    ),
                    items: userItems.map((model) {
                      return DropdownMenuItem(
                          value: model['username'].toString() +
                              model['name'].toString(),
                          child: Text(model['username'].toString() +
                              model['name'].toString()));
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        dropdownvalue = newVal!;
                      });
                    },
                    value: dropdownvalue,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Loại nghỉ",
                    ),
                    borderRadius: BorderRadius.circular(10),
                    validator: (value) =>
                        value == null ? "Lựa chọn loại nghỉ" : null,
                    hint: Text('Loại nghỉ'),
                    items: <String>['Nghỉ có phép', 'Nghỉ không phép']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newVal1) {
                      setState(() {
                        dropdownvalue1 = newVal1;
                      });
                    },
                    value: dropdownvalue1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: dateinput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: 'Từ ngày',
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                        selectedDate3 = selectedDate;
                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    /*controller: dateinput,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Đến ngày',
                        suffixIcon: Icon(Icons.calendar_month),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate1 = await showDatePicker(
                          context: context,
                          initialDate: selectedDate1,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate1 != null) {
                          setState(() {
                            selectedDate = pickedDate1;
                          });
                        } else {
                          return;
                        }
                      }),*/
                    controller: dateinput1,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: "Đến ngày",
                      suffixIcon: Icon(Icons.calendar_month),
                      hintText: 'dd/mm/yyyy',
                    ),
                    onTap: () async {
                      final selectedDate1 = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          selectableDayPredicate: (day) =>
                              day.isBefore(selectedDate3));
                      if (selectedDate1 != null) {
                        String formattedDate1 =
                            DateFormat('yyyy-MM-dd').format(selectedDate1);
                        setState(() {
                          dateinput1.text = formattedDate1;
                        });
                      }
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text('Nghỉ trong ngày'),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        labelText: 'Ghi chú'),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Gửi',
                        textAlign: TextAlign.right,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
