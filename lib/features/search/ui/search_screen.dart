import 'package:flutter/material.dart';
import 'package:food_app/features/home_page/home/ui/widget_child/search.dart';

class SearchScreen extends StatefulWidget{
  String search='Bún thịt';
  SearchScreen(this.search,);

  @override
  State<SearchScreen> createState() => _SearchScreenState(search: search, );
}

class _SearchScreenState extends State<SearchScreen> {
  String search;
  @override
  void initState() {
    super.initState();
    // _searchController.text =this.search; // Gán giá trị mặc định
  }
  _SearchScreenState({required this.search,});
  @override
  void SearchSumitted(String value){
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(value),));
  }
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(child: Search(SearchSumitted,'')),
          // ListSearch(
          //   key: UniqueKey(), // Sử dụng UniqueKey() để cập nhật widget ListSearch
          //   search: search,user: user,
          // ),
        ],
    );
  }
}