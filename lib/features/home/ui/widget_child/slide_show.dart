import 'dart:async';
import 'package:flutter/material.dart';

class Slideshow extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  final int slideCount = 3;
  final int slideDuration = 3; // Thời gian tự chuyển slide (giây)
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Bắt đầu chuyển slide tự động
    Timer.periodic(Duration(seconds: slideDuration), (Timer timer) {
      if (_currentPage < slideCount - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [Container(
          height: 200, // Chiều cao của slide
          child: PageView.builder(
            controller: _pageController,
            itemCount: slideCount,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                // Đường dẫn của ảnh
                getImageUrl(index),
                fit: BoxFit.cover,
              );
            },
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
        ),
          SizedBox(height: 10,)
        ]
    );
  }

  String getImageUrl(int index) {
    // Đường dẫn của từng ảnh tại các index khác nhau
    if (index == 0) {
      return 'https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/banner1.jpg?alt=media&token=41d1669d-18af-4912-b891-5c47d4080923';
    } else if (index == 1) {
      return 'https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/banner2.jpg?alt=media&token=098e2fd5-85a5-4342-aa4a-c394bf5d1b1a';
    }
    return 'https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/banner3.jpg?alt=media&token=e0c2ed2f-da0f-427c-ac16-bd25f6260109';
  }
}
