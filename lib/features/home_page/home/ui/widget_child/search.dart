import 'package:flutter/material.dart';
import 'package:food_app/features/search/ui/search_screen.dart';
class Search extends StatefulWidget {
  var OnSumitted;
  String search='Bún thịt';
  Search(this.OnSumitted,this.search);
  @override
  State<Search> createState() => _SearchHomeState();
}

class _SearchHomeState extends State<Search> {
  @override
  TextEditingController _searchController = TextEditingController();
  void initState() {
    super.initState();
    _searchController.text =widget.search;
  }
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        textAlign: TextAlign.left,
        controller: _searchController,
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
          widget.OnSumitted(value)
        },
      ),
    );
  }
}