import 'package:flutter/material.dart';
import 'package:food_app/features/home_page/home/ui/widget_child/list_mon.dart';
import 'package:food_app/features/home_page/home/ui/widget_child/search.dart';
import 'package:food_app/features/home_page/home/ui/widget_child/slide_show.dart';
import 'package:food_app/features/search/ui/search_screen.dart';
class HomeChild extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    void SearchSumitted(String value){
      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(value),));
    }
    return
      SafeArea(
        child: Column(
          children: [
            Search(SearchSumitted,''),
            Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children:  [
                  Slideshow(),
                  Container(height: 5,),
                  const FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('CHỌN THEO THỂ LOẠI',style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold),),
                          Text('Xem tất cả ',style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue))
                        ]),
                  ),
                  SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MenuWidget('https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/monchay.jpg?alt=media&token=37d887ed-3006-4e4d-8e6b-e2e1254b5a03','Món chay'),
                        MenuWidget('https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/bunthit.jpg?alt=media&token=80cc9cfd-e68c-44c0-a6fc-746f5b53afb7','Bún Thịt Nướng'),
                        MenuWidget('https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/tra.jpg?alt=media&token=9f309fde-2079-4996-8e40-bfa310d90f0a','Trà'),
                        MenuWidget('https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/banhtrangtron.PNG?alt=media&token=9a155e79-47b4-4715-bf14-ebba2e95b727','Bánh tráng trộn'),
                      ]
                  ),
                  SizedBox(height: 20,),
                  const FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('MÓN ĂN NỔI BẬT',style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold),),
                          Text('Xem tất cả ',style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue))
                        ]),
                  ),
                  // Expanded(child: User1ListWidget())
                  ListMonAn(),
                ]),
          ),]
        ),
      );
  }
}
class MenuWidget extends StatelessWidget {
  String urlmon,tenmon;
  MenuWidget(this.urlmon,this.tenmon);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [ Container(width: MediaQuery.of(context).size.width/4-5,
            child: GestureDetector(
              onTap: () {
                // FirebaseNewFood aa=FirebaseNewFood();
                //                 aa.addMenuItem("Mon5", "Bún thịt", 60, "kkk", 4.7, "dddd");
              },
              child: Column(children: [
                Image.network(urlmon,height: 100,)
              ],),
            ),
          ),
            SizedBox(height: 10),
            Center(child: Text(tenmon,style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Arial',fontSize: 13),maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,))
          ]
      ),
    );
  }
}