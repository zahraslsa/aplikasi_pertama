# CODIFY

CODIFY adalah aplikasi pembelajaran dasar pemrograman berbasis Flutter untuk
membantu siswa kelas X SMK PPLG mempelajari konsep pemrograman secara bertahap.
Aplikasi menyediakan tes diagnostik, materi dan latihan, serta pemantauan
progres belajar. Pencarian materi dilakukan secara lokal dan status materi
selesai disimpan pada perangkat.

## Tujuan dan Sasaran Pengguna

CODIFY ditujukan untuk siswa kelas X SMK PPLG sebagai sarana belajar mandiri
dasar pemrograman. Tes diagnostik membantu mengenali kompetensi yang perlu
dipelajari, sedangkan materi, latihan, dan progres mendukung proses belajar
selanjutnya.

## Teknologi

- Flutter dan Dart.
- `shared_preferences` untuk menyimpan data aplikasi secara lokal, termasuk
  status materi yang selesai.
- `flutter_test` untuk pengujian widget.

Aplikasi tidak menggunakan Firebase atau backend untuk fitur-fitur tersebut.

## Fitur Utama

- **Dashboard:** akses ke tes diagnostik, materi, dan ringkasan progres belajar.
- **Tes diagnostik:** 25 soal yang mencakup algoritma dan flowchart, variabel
  dan tipe data, operator, percabangan, serta perulangan.
- **Hasil diagnostik:** menampilkan nilai keseluruhan dan kompetensi.
- **Materi pembelajaran:** 12 materi dasar dan pengayaan, dengan halaman detail
  serta latihan interaktif.
- **Pencarian materi:** mencari berdasarkan judul atau deskripsi/kata kunci;
  hasil diperbarui saat mengetik, tidak membedakan huruf besar dan kecil, dan
  dapat dihapus menggunakan tombol hapus.
- **Status selesai:** materi dapat ditandai selesai atau dibatalkan dari halaman
  detail. Latihan dengan nilai minimal 80 juga menandai materi selesai.
- **Progres belajar:** Dashboard dan halaman Progres menampilkan jumlah materi
  selesai, persentase, dan progress bar. Progres dihitung dari materi yang
  terdaftar dan berstatus selesai.
- **Riwayat dan profil:** riwayat tes/latihan dan informasi profil dikelola
  melalui `LearningStore`.

## Penyimpanan Data

`LearningStore` menggunakan `shared_preferences` untuk menyimpan data aplikasi
secara lokal di perangkat. Daftar materi selesai disimpan sebagai ID materi
unik, sehingga materi yang sama tidak dihitung lebih dari sekali. Penandaan
dan pembatalan status memakai penyimpanan yang sama; halaman Dashboard,
Progres, dan daftar materi memuat status dari sumber tersebut.

Penyimpanan lokal tidak disinkronkan ke perangkat lain atau layanan daring.

## Struktur Folder

```text
aplikasi_pertama/
├── lib/
│   ├── data/       # Penyimpanan lokal dan data aplikasi
│   ├── screens/    # Dashboard, materi, latihan, tes, progres, dan halaman lain
│   ├── theme/      # Tema dan warna CODIFY
│   ├── widgets/    # Komponen UI yang digunakan kembali
│   └── main.dart   # Entry point aplikasi
├── test/           # Widget test dan pengujian aplikasi
├── screenshots/    # Gambar tampilan aplikasi
├── android/        # Konfigurasi platform Android
├── ios/            # Konfigurasi platform iOS
├── web/            # Konfigurasi platform web
├── windows/        # Konfigurasi platform Windows
├── linux/          # Konfigurasi platform Linux
├── macos/          # Konfigurasi platform macOS
├── pubspec.yaml    # Konfigurasi project dan dependency
└── README.md
```

## Menjalankan Project

Pasang Flutter SDK yang sesuai dengan batas versi SDK pada `pubspec.yaml`, lalu
jalankan perintah berikut dari folder project:

```bash
flutter pub get
flutter devices
flutter run
```

Pilih atau sambungkan perangkat/emulator yang tersedia. Untuk menjalankan
pemeriksaan kode dan pengujian:

```bash
flutter analyze
flutter test
```

## Pengujian Fitur Secara Manual

### Pencarian Materi

1. Buka tab **Materi**.
2. Cari judul, misalnya `Array`, lalu coba variasi huruf besar seperti `ARRAY`.
3. Cari kata dari deskripsi materi, misalnya `diagram alir`.
4. Masukkan teks yang tidak cocok dan pastikan pesan **Materi tidak ditemukan**
   muncul.
5. Tekan tombol hapus di kolom pencarian dan pastikan semua materi kembali
   ditampilkan.
6. Pilih hasil untuk memastikan halaman detail tetap terbuka.

### Menandai Materi dan Melihat Progres

1. Buka detail salah satu materi dan tekan **Tandai Materi Selesai**.
2. Pastikan detail menunjukkan status selesai dan kartu materi menampilkan
   label **Selesai**.
3. Kembali ke Dashboard dan halaman **Progres**. Periksa jumlah materi, angka
   persentase, serta progress bar.
4. Pada detail materi, tekan **Batalkan Status Selesai** dan pastikan status
   serta progres berkurang.
5. Menandai materi yang sama berulang kali seharusnya tetap dihitung sebagai
   satu materi selesai.

### Memeriksa Penyimpanan Setelah Aplikasi Ditutup

1. Tandai sebuah materi selesai.
2. Tutup aplikasi sepenuhnya, bukan hanya kembali ke Dashboard.
3. Buka kembali aplikasi dan periksa status materi, Dashboard, dan halaman
   Progres.
4. Batalkan status selesai, tutup dan buka kembali aplikasi, lalu pastikan
   perubahan juga tetap tersimpan.

Pengujian widget menggunakan `SharedPreferences.setMockInitialValues`, sehingga
pengujian otomatis memverifikasi pemuatan ulang state di dalam test, bukan
force close dan pembukaan ulang proses aplikasi native. Langkah di atas perlu
dilakukan pada perangkat/emulator untuk memverifikasi siklus hidup aplikasi
yang sebenarnya.

## Hasil Pengujian

Pada pemeriksaan terakhir sebelum dokumentasi ini diperbarui:

- `flutter analyze` selesai tanpa masalah.
- `flutter test` berhasil; seluruh 10 widget test lulus.
- Pengujian mencakup pencarian judul/kata kunci dan huruf besar-kecil, hasil
  pencarian kosong dan pengosongan kolom, penandaan/pembatalan status, status
  unik, progres Dashboard dan halaman Progres, serta pemuatan ulang menggunakan
  penyimpanan mock.

Uji force close aplikasi pada perangkat/emulator belum dibuktikan oleh widget
test dan perlu dilakukan secara manual sesuai langkah di atas.

## Screenshot

Gambar aplikasi tersedia di folder [`screenshots/`](screenshots/), termasuk
Dashboard, daftar dan detail materi, tes diagnostik, latihan, progres, riwayat,
dan profil.

## Repository

https://github.com/zahraslsa/aplikasi_pertama
