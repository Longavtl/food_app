import 'package:flutter/material.dart';
import 'package:food_app/data/donhang.dart';
import 'package:food_app/data/model/donhangmodel.dart';

import '../../data/chitietdonhang.dart';
import '../../data/model/data_repository.dart';

class OderSuccess extends StatefulWidget {
  OderSuccess({super.key});

  @override
  State<OderSuccess> createState() => _OderSuccessState();
}

class _OderSuccessState extends State<OderSuccess> {
  Future<List<Donhangmodel>>? danhSachDonHang;

  @override
  void initState() {
    UserSingleton userSingleton = UserSingleton.getInstance();
    danhSachDonHang = fetchDataByTenNguoiNhan(userSingleton.user.name);
    super.initState();
  }

  Future<List<Donhangmodel>> fetchDataByTenNguoiNhan(String tenNguoiNhan) async {
    return Donhang.layDonhangtheoten(tenNguoiNhan);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "List of order  ",
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Donhangmodel>>(
        future: danhSachDonHang,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Hiển thị một tiêu đề hoặc widget loading khi đang đợi dữ liệu
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Xử lý lỗi nếu có
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Xử lý trường hợp không có dữ liệu
            return Column(children: [
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.topCenter,
                  child: Text('Không tìm thấy đơn hàng'))
            ],);
          } else {
            // Hiển thị danh sách đơn hàng
            List<Donhangmodel> danhSachDonHang = snapshot.data!;
            return
                ListView.builder(
                  itemCount: danhSachDonHang.length,
                  itemBuilder: (context, index) {
                    Donhangmodel donHang = danhSachDonHang[index];
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Xử lý sự kiện chạm vào đơn hàng ở đây
                          // Bạn có thể mở màn hình chi tiết đơn hàng hoặc thực hiện hành động khác
                          // Ví dụ: Navigator.push để chuyển sang màn hình chi tiết đơn hàng
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChiTietDonHangScreen(donHangId: donHang.id)),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mã đơn hàng: ${donHang.id}', style: TextStyle(fontSize: 18)),
                              SizedBox(height: 8.0),
                              Text('Tên người nhận: ${donHang.tennguoinhan}', style: TextStyle(fontSize: 16)),
                              Text('Địa chỉ: ${donHang.diachi}', style: TextStyle(fontSize: 16)),
                              Text('Số điện thoại: ${donHang.sdt}', style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8.0),
                              Text('Trạng thái: ${donHang.trangthai == Trangthai.Choxacnhan ? 'Chờ xác nhận' : 'Không rõ'}', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
            );
          }
        },
      ),
    );
  }
}
class ChiTietDonHangScreen extends StatelessWidget {
  final String donHangId;

  ChiTietDonHangScreen({required this.donHangId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail order '),
      ),
      body: FutureBuilder<List<ChiTietDonHang2>>(
        future: ChiTietDonHang2.layChiTietDonHang(donHangId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Text('Không có chi tiết đơn hàng');
          } else {
            // Hiển thị chi tiết đơn hàng
            List<ChiTietDonHang2> chiTietDonHang = snapshot.data!;
            return ListView.builder(
              itemCount: chiTietDonHang.length,
              itemBuilder: (context, index) {
                ChiTietDonHang2 chiTiet = chiTietDonHang[index];
                return ListTile(
                  title: Text('Tên sản phẩm: ${chiTiet.tenSP}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Giá: ${chiTiet.gia}'),
                      Text('Số lượng: ${chiTiet.soluong}'),
                      SizedBox(height: 5,),
                      Text('Thành tiền: ${chiTiet.gia * chiTiet.soluong}'),
                      SizedBox(height: 5,),
                      Image.network('${chiTiet.url}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}