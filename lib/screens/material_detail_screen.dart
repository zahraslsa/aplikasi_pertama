import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MaterialDetailScreen extends StatelessWidget {
  final Map<String, dynamic> material;

  const MaterialDetailScreen({super.key, required this.material});

  static const Map<String, Map<String, dynamic>> contents = {
    '01': {
      'intro': 'Algoritma adalah urutan langkah yang logis dan sistematis untuk menyelesaikan suatu masalah. Flowchart digunakan untuk menggambarkan langkah tersebut dalam bentuk diagram.',
      'points': [
        'Start/End (oval): menandai awal dan akhir.',
        'Process (persegi panjang): menunjukkan proses.',
        'Input/Output (jajar genjang): menerima atau menampilkan data.',
        'Decision (belah ketupat): menentukan pilihan berdasarkan kondisi.',
      ],
      'code': '''// Algoritma menghitung luas persegi
int sisi = 5;
int luas = sisi * sisi;

print(luas); // 25''',
      'summary': [
        'Algoritma harus jelas, logis, dan berurutan.',
        'Flowchart membantu memvisualisasikan alur algoritma.',
      ],
    },
    '02': {
      'intro': 'Variabel adalah tempat untuk menyimpan nilai yang dapat digunakan dalam program. Tipe data menentukan jenis nilai yang disimpan.',
      'points': [
        'int: bilangan bulat.',
        'double: bilangan desimal.',
        'String: teks.',
        'bool: nilai true atau false.',
      ],
      'code': '''int umur = 16;
double tinggi = 165.5;
String nama = 'Alya';
bool aktif = true;

print(nama);
print(umur);''',
      'summary': [
        'Nama variabel sebaiknya jelas dan mudah dipahami.',
        'Pilih tipe data sesuai kebutuhan.',
      ],
    },
    '03': {
      'intro': 'Operator digunakan untuk melakukan operasi terhadap nilai atau variabel, seperti perhitungan, perbandingan, dan pengambilan keputusan logis.',
      'points': [
        '+, -, *, /: operasi aritmatika.',
        '%: sisa hasil bagi.',
        '==, !=, >, <: operator perbandingan.',
        '&&, ||, !: operator logika.',
      ],
      'code': '''int a = 10;
int b = 3;

print(a + b); // 13
print(a % b); // 1
print(a > b); // true''',
      'summary': [
        'Operator aritmatika digunakan untuk berhitung.',
        'Operator perbandingan dan logika sering digunakan dalam kondisi.',
      ],
    },
    '04': {
      'intro': 'Percabangan memungkinkan program memilih tindakan berdasarkan kondisi tertentu. Program menjalankan bagian kode yang sesuai dengan hasil kondisi.',
      'points': [
        'if digunakan untuk memeriksa kondisi.',
        'else dijalankan ketika kondisi if tidak terpenuhi.',
        'else if digunakan untuk memeriksa kondisi tambahan.',
      ],
      'code': '''int nilai = 85;

if (nilai >= 75) {
  print('Lulus');
} else {
  print('Belum lulus');
}''',
      'summary': [
        'Percabangan digunakan untuk pengambilan keputusan.',
        'Kondisi biasanya menghasilkan nilai true atau false.',
      ],
    },
    '05': {
      'intro': 'Perulangan digunakan untuk menjalankan instruksi berulang kali. Perulangan membantu mengurangi penulisan kode yang sama.',
      'points': [
        'for cocok ketika jumlah pengulangan diketahui.',
        'while berjalan selama kondisi bernilai true.',
        'break menghentikan perulangan.',
        'continue melewati iterasi saat ini.',
      ],
      'code': '''for (int i = 1; i <= 5; i++) {
  print(i);
}''',
      'summary': [
        'Perulangan membuat kode lebih ringkas.',
        'Pastikan kondisi berhenti tercapai agar tidak terjadi perulangan tanpa akhir.',
      ],
    },
    '06': {
      'intro': 'Array atau kumpulan data digunakan untuk menyimpan beberapa nilai dalam satu variabel. Pada Dart, List merupakan struktur yang umum digunakan untuk tujuan ini.',
      'points': [
        'Indeks List dimulai dari 0.',
        'length menunjukkan jumlah elemen.',
        'add() menambahkan elemen.',
        'Elemen dapat diakses menggunakan indeks.',
      ],
      'code': '''List<String> buah = [
  'Apel',
  'Jeruk',
  'Mangga'
];

print(buah[0]); // Apel
buah.add('Pisang');
print(buah.length); // 4''',
      'summary': [
        'Gunakan List untuk mengelola banyak data sejenis.',
        'Pastikan indeks yang digunakan tersedia.',
      ],
    },
    '07': {
      'intro': 'Function adalah blok kode yang dibuat untuk menjalankan tugas tertentu. Function dapat dipanggil kembali sehingga kode lebih terstruktur dan mudah digunakan ulang.',
      'points': [
        'Function dapat menerima parameter.',
        'Function dapat mengembalikan nilai dengan return.',
        'void digunakan untuk fungsi yang tidak mengembalikan nilai.',
      ],
      'code': '''int tambah(int a, int b) {
  return a + b;
}

void main() {
  print(tambah(3, 4)); // 7
}''',
      'summary': [
        'Pisahkan tugas program ke dalam fungsi yang sesuai.',
        'Gunakan parameter untuk menerima masukan.',
      ],
    },
    '08': {
      'intro': 'String adalah tipe data untuk teks. Manipulasi String digunakan untuk memeriksa, menggabungkan, mengubah, atau mengambil bagian dari teks.',
      'points': [
        'length menghitung panjang teks.',
        'toUpperCase() mengubah teks menjadi huruf besar.',
        'toLowerCase() mengubah teks menjadi huruf kecil.',
        'trim() menghapus spasi di awal dan akhir.',
      ],
      'code': '''String nama = '  Zahra  ';

print(nama.trim());
print(nama.toUpperCase());
print(nama.length);''',
      'summary': [
        'String digunakan untuk mengolah data berbentuk teks.',
        'Pilih metode manipulasi sesuai kebutuhan.',
      ],
    },
    '09': {
      'intro': 'Input adalah data yang diterima program, sedangkan output merupakan hasil yang ditampilkan. Keduanya memungkinkan program berinteraksi dengan pengguna.',
      'points': [
        'Input dapat berasal dari pengguna atau sumber data lain.',
        'Output dapat berupa teks, angka, atau informasi lain.',
        'Data input perlu diperiksa sebelum diproses.',
      ],
      'code': r'''import 'dart:io';

void main() {
  stdout.write('Masukkan nama: ');
  String nama = stdin.readLineSync() ?? '';

  print('Halo, $nama!');
}''',
      'summary': [
        'Input menyediakan data untuk diproses.',
        'Output menyampaikan hasil pemrosesan.',
      ],
    },
    '10': {
      'intro': 'Debugging adalah proses menemukan dan memperbaiki kesalahan pada program. Proses ini membantu memastikan program berjalan sesuai tujuan.',
      'points': [
        'Syntax error: kesalahan penulisan kode.',
        'Runtime error: kesalahan ketika program berjalan.',
        'Logic error: program berjalan tetapi hasilnya keliru.',
        'Gunakan pesan error dan breakpoint untuk membantu pemeriksaan.',
      ],
      'code': '''// Sebelum diperbaiki
int hasil = 10 - 3;

// Periksa operasi yang diperlukan
int hasilBenar = 10 + 3;

print(hasilBenar); // 13''',
      'summary': [
        'Baca pesan error dan periksa baris yang bermasalah.',
        'Uji kembali program setelah melakukan perbaikan.',
      ],
    },
    '11': {
      'intro': 'Object-Oriented Programming (OOP) adalah pendekatan pemrograman yang menggunakan class dan object untuk mengorganisasi data serta perilaku.',
      'points': [
        'Class adalah cetak biru objek.',
        'Object adalah instance dari class.',
        'Property menyimpan data objek.',
        'Method mendefinisikan perilaku objek.',
      ],
      'code': r'''class Siswa {
  String nama;

  Siswa(this.nama);

  void perkenalan() {
    print('Nama saya $nama');
  }
}

void main() {
  Siswa siswa = Siswa('Alya');
  siswa.perkenalan();
}''',
      'summary': [
        'Class menggabungkan data dan perilaku.',
        'Object dibuat berdasarkan class.',
      ],
    },
    '12': {
      'intro': 'Studi kasus pemrograman menggabungkan beberapa konsep dasar untuk menyelesaikan masalah nyata. Tahapannya meliputi memahami masalah, merancang algoritma, menulis kode, dan menguji hasil.',
      'points': [
        'Identifikasi masalah dan kebutuhan.',
        'Tentukan input, proses, dan output.',
        'Susun algoritma sebelum menulis kode.',
        'Uji beberapa kondisi dan perbaiki kesalahan.',
      ],
      'code': '''int nilai = 80;
String status;

if (nilai >= 75) {
  status = 'Lulus';
} else {
  status = 'Belum lulus';
}

print(status);''',
      'summary': [
        'Pahami masalah sebelum membuat program.',
        'Gabungkan variabel, operator, dan percabangan sesuai kebutuhan.',
        'Lakukan pengujian untuk memastikan hasil benar.',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final number = material['number'] as String;
    final content = contents[number]!;

    return Scaffold(
      appBar: AppBar(title: Text('Materi $number')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    material['icon'] as IconData,
                    color: Colors.white,
                    size: 38,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    material['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    material['subtitle'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle('Pengantar Materi'),
            const SizedBox(height: 8),
            Text(
              content['intro'] as String,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle('Konsep Penting'),
            const SizedBox(height: 12),
            ...(content['points'] as List<String>).map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _sectionTitle('Contoh Kode'),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableText(
                  content['code'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    height: 1.7,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle('Rangkuman'),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (content['summary'] as List<String>)
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}
