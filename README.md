# ISO - Flutter Mobile App

**ISO** adalah sebuah aplikasi **Flutter** yang dibuat untuk Mengembangkan aplikasi presensi digital untuk siswa menggunakan fitur scan QR, perizinan online, 
rekap kehadiran, dan notifikasi siswa. Aplikasi ini menggantikan presensi manual yang memakan waktu 
dan rawan kesalahan. Dengan demikian, efisiensi dan akurasi pelaporan kehadiran siswa dapat 
ditingkatkan di era digital.

Project ini berisi kode sumber aplikasi mobile Flutter yang bisa dibangun
untuk **Android**.
---

## Struktur Kode & Cara Kerja

Ini adalah gambaran umum bagaimana kode bekerja:
- ├── android/ # Konfigurasi & kode khusus Android
- ├── lib/ # Kode utama Dart/Flutter
- │ ├── main.dart # Titik masuk aplikasi
- │ ├── pages/ # Halaman UI
- ├── assets/ # Gambar
- ├── pubspec.yaml # Konfigurasi Flutter + dependencies
- └── test/ # Unit/UI test

---

### Cara Kerja Utama Kode

**`lib/main.dart`**  
Ini adalah titik masuk aplikasi Flutter. Flutter akan menjalankan fungsi
`main()` di sini. Di dalamnya ada:

- `runApp(MyApp())`
- Widget root `MaterialApp`

Kode di sini akan:
1. Mengatur tema
2. Mengatur routing ke halaman awal

---

**Halaman & Navigasi (pages/)**  
Di folder `lib/pages/`, tiap file merepresentasikan satu halaman UI.

Flutter menampilkan widget berdasarkan rute yang ditentukan
(pada MaterialApp.routes atau Navigator.push()).

Assets (images, icons, fonts)
Assets ditambahkan pada file pubspec.yaml sehingga bisa dipanggil di kode:

flutter:
  assets:
    - assets/img/logo.png

pubspec.yaml
File ini penting karena:
- Mendefinisikan nama project
- Menentukan versi Flutter SDK yang dipakai
- Menambahkan dependencies (library eksternal)
- Menambahkan assets yang akan dipakai

Cara Install & Jalankan

Pastikan sudah terinstall:
Flutter SDK
Android Studio / Xcode (untuk mobile)

Lalu di terminal:

git clone https://github.com/ursecsoul/ISO-.git
cd ISO-
flutter pub get      # install dependencies
flutter run          # jalankan aplikasi   

Fitur 

- Halaman Login
- Dashboard utama
- Profile pengguna
- Fitur input & validasi form
- Fitur scan, notifikasi

Testing

Project ini dilengkapi folder test/.
Untuk menjalankan test:
flutter test

Penulis

[Adinda Rachmania]

