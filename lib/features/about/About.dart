import 'package:flutter/material.dart';
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(108, 227, 181, 0.9019607843137255),
          title: Text('Một chút về ứng dụng'),
        ),
        body: Column(
          children: [
            SizedBox(height: 15),
            FractionallySizedBox(
              widthFactor: 0.9,
              alignment: Alignment.center, // Căn giữa ngang (theo chiều rộng)
              child: Center(
                child: Text(
                  'Ứng dụng được viết bằng framework flutter đang dần hoàn thiện - by Long',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Times New Roman',
                  ),
                  textAlign: TextAlign.center, // Căn giữa ngang (theo chiều rộng)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
