import 'package:flutter/material.dart';
class SearchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        // controller: searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Tìm kiếm...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        onSubmitted: (value) => {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(search: value,user :user),))
        },
      ),
    );
  }
}