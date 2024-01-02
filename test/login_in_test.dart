import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/features/home_page/home/ui/home_screen.dart';
import 'package:food_app/features/login/ui/login_screen.dart';
import 'package:food_app/features/signup/ui/signup.dart';

void main() {
  group('LoginIn Widget Tests', () {
    testWidgets('Empty Fields Show Snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginIn(),
      ));

      // Nhấn vào nút đăng nhập mà không nhập tài khoản và mật khẩu.
      await tester.tap(find.text('Đăng nhập').at(1));
      await tester.pump();
      await tester.pumpAndSettle();// Chờ tất cả các animation kết thúc.

      // Xác minh rằng SnackBar đã xuất hiện khi người dùng không nhập tài khoản hoặc mật khẩu.
      expect(find.text('Tài khoản hoặc mật khẩu không để trống'), findsOneWidget);
    });

    testWidgets('Successful Login Navigates to HomeScreen', (WidgetTester tester) async {
      // TODO: Mock LoginBloc and set it up to simulate a successful login.

      await tester.pumpWidget(MaterialApp(
        home: LoginIn(),
      ));

      // Nhập tên người dùng và mật khẩu hợp lệ.
      await tester.enterText(find.byType(TextField).at(0), 'long112');
      await tester.enterText(find.byType(TextField).at(1), '123456');

      // Nhấn vào nút đăng nhập.
      await tester.tap(find.text('Đăng nhập').at(1));
      await tester.pump();

      // Xác minh rằng đã chuyển đến màn hình HomeScreen.
      expect(find.byType(HomeScreen), findsOneWidget);
    });


    testWidgets('Tap "Sign Up?" Navigates to SignUp Screen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginIn(),
      ));

      // Nhấn vào nút "Sign Up?"
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Xác minh rằng đã chuyển đến màn hình đăng ký (SignUp).
      expect(find.byType(SignUp), findsOneWidget);
    });

    // TODO: Add more test cases for Google and Facebook login, error handling, UI display, etc.
  });
}
