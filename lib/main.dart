import 'package:flutter/material.dart';

import 'network.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Đơn xin nghỉ phép",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyDropDown(),
      debugShowCheckedModeBanner: false,
    );
  }
}
