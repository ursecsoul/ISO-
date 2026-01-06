import 'package:flutter/material.dart';
import 'pages/splashscreen.dart';
import 'pages/absen_page.dart';
import 'pages/welcome_page.dart';
import 'pages/akun_page.dart';
import 'pages/register_page.dart'; 
import 'pages/home_page.dart';
import 'pages/form_page.dart';
import 'pages/scanQR_page.dart';
import 'pages/rekap_page.dart';
import 'pages/notification_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi data lokal untuk tanggal (seperti "id_ID")
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Tambahkan super.key untuk konsistensi best practice

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISO App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
  '/': (context) => SplashScreen(),
  '/welcome': (context) => const WelcomePage(),
  '/akun': (context) => const AkunPage(),
  '/register': (context) => const RegisterPage(),
  '/home': (context) => const HomePage(),
  '/form': (context) => const FormPage(),
  '/scan': (context) => const ScanQRPage(),
  '/rekap': (context) => RekapAbsenPage(),
  '/absen': (context) => const AbsenPage(),
  '/notification': (context) => const NotificationPage(),
  '/profile': (context) => const ProfilePage(),
},
    );
  }
}
