import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import '../widgets/codify_mascot.dart';
import 'material_practice_screen.dart';

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
      'explanation': "Nilai sisi disimpan dalam variabel. Program mengalikan sisi dengan dirinya sendiri, lalu print menampilkan hasilnya.",
      'output': "25",
      'exercise': "Ubah contoh agar menghitung luas persegi dengan sisi 8.",
      'hint': "Ganti nilai sisi dan gunakan rumus luas = sisi kali sisi.",
      'objectives': [
        "Menguraikan masalah menjadi langkah yang berurutan.",
        "Membedakan input, proses, dan output.",
        "Memilih simbol flowchart untuk tiap jenis langkah.",
      ],
      'conceptGuide': "Mulailah dengan menuliskan tujuan dan data yang tersedia. Urutkan proses dari awal sampai hasil, lalu gambarkan dengan flowchart: oval untuk mulai atau selesai, jajar genjang untuk input atau output, persegi panjang untuk proses, dan belah ketupat untuk keputusan. Periksa alur dengan contoh data agar setiap jalur berakhir.",
      'examples': [
        {
          'title': "Menentukan bilangan genap atau ganjil",
          'explanation': "Data angka diperiksa dengan operasi sisa bagi. Jika sisanya 0, alur menuju output Genap; jika tidak, alur menuju output Ganjil.",
          'code': "int angka = 7;\n\nif (angka % 2 == 0) {\n  print('Genap');\n} else {\n  print('Ganjil');\n}",
          'output': "Ganjil",
        },
      ],
      'commonMistakes': [
        "Menulis langkah yang melompat atau tidak menjelaskan input dan hasil.",
        "Menggunakan simbol proses untuk keputusan yang seharusnya memakai belah ketupat.",
        "Membuat cabang keputusan tanpa jalur lanjutan yang jelas.",
      ],
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
      'explanation': "int menyimpan bilangan bulat, double bilangan desimal, String teks, dan bool nilai benar atau salah. Setiap variabel diberi tipe sesuai isi datanya.",
      'output': "Alya\n16",
      'exercise': "Tambahkan variabel untuk menandai apakah Alya sudah mengikuti kelas.",
      'hint':
          "Gunakan bool dengan nilai true atau false, lalu tampilkan nilainya.",
      'objectives': [
        "Membedakan int, double, String, dan bool.",
        "Membuat nama variabel yang jelas dan memakai nilainya.",
        "Memilih var, final, atau const sesuai kebutuhan.",
      ],
      'conceptGuide': "Dart memiliki tipe statis: tipe nilai perlu cocok dengan tipe variabel. var meminta Dart menyimpulkan tipe dari nilai awal; final hanya dapat diisi sekali saat program berjalan; const dipakai untuk nilai konstan yang diketahui saat kompilasi. Gunakan tipe eksplisit ketika itu membuat maksud program lebih mudah dibaca.",
      'examples': [
        {
          'title': "Menghitung total belanja",
          'explanation': "Nama barang disimpan sebagai teks, jumlah sebagai bilangan bulat, dan harga dapat memakai pecahan. Perkalian jumlah dan harga menghasilkan total belanja.",
          'code': "String barang = 'Buku';\nint jumlah = 2;\ndouble hargaSatuan = 12.5;\ndouble total = jumlah * hargaSatuan;\n\nprint('Barang: ' + barang);\nprint('Total: ' + total.toStringAsFixed(1));",
          'output': "Barang: Buku\nTotal: 25.0",
        },
      ],
      'commonMistakes': [
        "Memasukkan teks ke variabel int tanpa mengubah atau memeriksa tipenya.",
        "Memakai nama singkat seperti x untuk data yang maknanya bisa ditulis lebih jelas.",
        "Mengira final dan const dapat diberi nilai ulang setelah deklarasi.",
      ],
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
      'explanation': "10 + 3 menghasilkan 13, 10 % 3 menghasilkan sisa 1, dan 10 > 3 menghasilkan nilai true.",
      'output': "13\n1\ntrue",
      'exercise': "Buat pemeriksaan untuk mengetahui apakah angka 14 termasuk bilangan genap.",
      'hint': "Bilangan genap memiliki sisa bagi 2 sama dengan 0.",
      'objectives': [
        "Menggunakan operator aritmatika untuk menghitung.",
        "Membandingkan nilai dan membaca hasil true atau false.",
        "Menggabungkan kondisi dengan &&, ||, dan !.",
      ],
      'conceptGuide': "Operator aritmatika menghasilkan angka, operator perbandingan menghasilkan bool, dan operator logika menggabungkan nilai bool. Di Dart, / menghasilkan double, sedangkan ~/ menghasilkan pembagian bulat; % mengambil sisa bagi. Gunakan tanda kurung saat urutan hitung perlu dibuat lebih mudah dibaca.",
      'examples': [
        {
          'title': "Memeriksa syarat masuk",
          'explanation': "Operator >= memeriksa usia. Operator && menghasilkan true hanya jika kedua syarat bernilai true.",
          'code': "int umur = 17;\nbool membawaKartu = true;\nbool bolehMasuk = umur >= 17 && membawaKartu;\n\nprint(bolehMasuk);",
          'output': "true",
        },
      ],
      'commonMistakes': [
        "Memakai = untuk membandingkan; gunakan == untuk memeriksa kesamaan.",
        "Mengira / selalu menghasilkan int; hasil pembagian ini bertipe double.",
        "Lupa bahwa % menghasilkan sisa bagi, bukan hasil pembagian.",
      ],
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
      'explanation': "Kondisi nilai >= 75 bernilai true karena nilai berisi 85. Karena itu, program memilih blok pertama dan menampilkan Lulus.",
      'output': "Lulus",
      'exercise': "Ubah program agar menampilkan Remedial saat nilai di bawah 75 dan Tuntas untuk nilai lainnya.",
      'hint': "Bandingkan nilai dengan 75 pada if, lalu gunakan else untuk kondisi yang tersisa.",
      'objectives': [
        "Membuat kondisi yang menghasilkan true atau false.",
        "Memilih antara if, else if, dan else.",
        "Menguji nilai batas pada setiap cabang.",
      ],
      'conceptGuide': "Program mengevaluasi kondisi dari atas ke bawah. Blok if pertama yang kondisinya true akan dijalankan, sedangkan else menjadi pilihan terakhir. Susun rentang nilai tanpa celah atau tumpang tindih, lalu uji nilai tepat di batas seperti 74, 75, dan 76.",
      'examples': [
        {
          'title': "Mengelompokkan nilai",
          'explanation': "Kondisi diperiksa berurutan. Nilai 68 tidak mencapai 85 maupun 75, sehingga blok else dijalankan.",
          'code': "int nilai = 68;\n\nif (nilai >= 85) {\n  print('Sangat baik');\n} else if (nilai >= 75) {\n  print('Lulus');\n} else {\n  print('Remedial');\n}",
          'output': "Remedial",
        },
      ],
      'commonMistakes': [
        "Menulis kondisi else if setelah else; else harus menjadi cabang terakhir.",
        "Mengurutkan ambang nilai dari kecil ke besar sehingga cabang lebih tinggi tertutup.",
        "Hanya menguji contoh yang berhasil, tanpa memeriksa nilai tepat di batas.",
      ],
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
      'explanation': "Perulangan dimulai dari i = 1. Setelah setiap putaran, i bertambah satu sampai kondisi i <= 5 tidak lagi terpenuhi.",
      'output': "1\n2\n3\n4\n5",
      'exercise': "Tampilkan bilangan genap dari 2 sampai 10.",
      'hint':
          "Mulai i dari 2, ulangi selama i <= 10, lalu tambah i sebanyak 2.",
      'objectives': [
        "Membaca bagian awal, syarat, dan perubahan pada for.",
        "Memilih for atau while sesuai kebutuhan.",
        "Membuat kondisi berhenti agar loop tidak berjalan selamanya.",
      ],
      'conceptGuide': "Pada for, bagian awal dijalankan sekali, kondisi diperiksa sebelum tiap putaran, dan perubahan nilai terjadi setelah isi loop. for cocok untuk jumlah putaran yang terukur; while cocok ketika pengulangan bergantung pada kondisi. Pastikan perubahan variabel akhirnya membuat kondisi berhenti.",
      'examples': [
        {
          'title': "Menjumlahkan angka dengan perulangan",
          'explanation': "Variabel total dimulai dari 0. Setiap putaran menambahkan nilai i, yaitu 1, 2, 3, lalu 4.",
          'code': "int total = 0;\n\nfor (int i = 1; i <= 4; i++) {\n  total += i;\n}\n\nprint(total);",
          'output': "10",
        },
      ],
      'commonMistakes': [
        "Lupa menaikkan atau mengubah variabel pengendali pada while.",
        "Memakai i < 5 saat nilai 5 juga seharusnya ikut diproses.",
        "Mengubah i di dua tempat sehingga ada angka yang terlewat.",
      ],
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
      'explanation': "List menyimpan beberapa nama buah. Indeks pertama adalah 0, add menambahkan buah baru, dan length memberi jumlah seluruh elemen.",
      'output': "Apel\n4",
      'exercise': "Tambahkan buah Nanas ke dalam List, lalu tampilkan elemen terakhirnya.",
      'hint': "Panggil add, lalu akses elemen terakhir menggunakan indeks length - 1.",
      'objectives': [
        "Membuat List dengan tipe elemen yang sesuai.",
        "Mengakses, mengubah, menambah, dan menghitung elemen.",
        "Menelusuri List dengan perulangan.",
      ],
      'conceptGuide': "List<T> membatasi isi agar bertipe T, misalnya List<int> untuk angka. Indeks dimulai dari 0, sehingga elemen terakhir ada pada index length - 1. List biasa dapat ditambah dengan add; sebelum membaca indeks, pastikan List tidak kosong dan indeksnya masih dalam rentang.",
      'examples': [
        {
          'title': "Menghitung rata-rata nilai",
          'explanation': "for-in mengambil setiap angka dari List dan menambahkannya ke total. Setelah itu, total dibagi jumlah elemen untuk memperoleh rata-rata.",
          'code': "List<int> nilai = [80, 75, 90];\nint total = 0;\n\nfor (final angka in nilai) {\n  total += angka;\n}\n\ndouble rataRata = total / nilai.length;\nprint(rataRata.toStringAsFixed(1));",
          'output': "81.7",
        },
      ],
      'commonMistakes': [
        "Mengakses buah[3] padahal indeks yang tersedia hanya 0 sampai 2.",
        "Membagi dengan length ketika List kosong sehingga terjadi pembagian dengan nol.",
        "Mencampur tipe data yang berbeda dalam List bertipe tertentu.",
      ],
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
      'explanation': "tambah menerima dua angka lewat parameter a dan b. return mengirim hasil penjumlahan kembali ke bagian program yang memanggilnya.",
      'output': "7",
      'exercise': "Buat function kali yang menerima dua angka dan mengembalikan hasil perkaliannya.",
      'hint':
          "Gunakan tipe kembalian int, dua parameter int, lalu return a * b.",
      'objectives': [
        "Mendefinisikan function dengan nama dan tipe yang jelas.",
        "Mengirim nilai melalui parameter dan argumen.",
        "Memilih nilai balik atau void sesuai tugas function.",
      ],
      'conceptGuide': "Parameter ditulis pada definisi function; argumen adalah nilai yang diberikan saat function dipanggil. Function bertipe selain void perlu mengembalikan nilai yang sesuai dengan tipe tersebut melalui return. Pisahkan tugas berulang menjadi function kecil agar lebih mudah diuji dan digunakan kembali.",
      'examples': [
        {
          'title': "Membuat function sapaan",
          'explanation': "nama adalah parameter bertipe String. Saat dipanggil dengan argumen Alya, function mengembalikan sapaan yang kemudian ditampilkan.",
          'code': "String sapa(String nama) {\n  return 'Halo, ' + nama + '!';\n}\n\nprint(sapa('Alya'));",
          'output': "Halo, Alya!",
        },
      ],
      'commonMistakes': [
        "Lupa menulis return pada function yang harus menghasilkan nilai.",
        "Mengembalikan tipe yang berbeda dari tipe hasil function.",
        "Mencampur nama parameter dengan nilai argumen saat memanggil function.",
      ],
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
      'explanation': "trim menghapus spasi di tepi teks. toUpperCase mengubah huruf menjadi kapital, sedangkan length menghitung karakter termasuk spasi.",
      'output': "Zahra\n  ZAHRA  \n9",
      'exercise': "Ubah nama menjadi huruf kecil dan tampilkan jumlah karakternya setelah trim.",
      'hint': "Gabungkan trim, toLowerCase, dan length pada teks.",
      'objectives': [
        "Menggabungkan teks dengan operator + atau interpolasi.",
        "Memakai metode trim, contains, dan perubahan huruf.",
        "Memahami bahwa metode String menghasilkan nilai baru.",
      ],
      'conceptGuide': "String tidak diubah di tempat; metode seperti trim dan toUpperCase mengembalikan String baru. Simpan hasilnya jika ingin memakai bentuk yang sudah diolah. Interpolasi dapat menyisipkan nilai variabel atau hasil ekspresi ke dalam teks.",
      'examples': [
        {
          'title': "Menggabungkan nama",
          'explanation': "Dua teks digabung dengan spasi di tengah. contains memeriksa apakah nama lengkap memuat kata Putri dan mengembalikan bool.",
          'code': "String namaDepan = 'Alya';\nString namaBelakang = 'Putri';\nString namaLengkap =\n    (namaDepan + ' ' + namaBelakang).trim();\n\nprint(namaLengkap);\nprint(namaLengkap.contains('Putri'));",
          'output': "Alya Putri\ntrue",
        },
      ],
      'commonMistakes': [
        "Memanggil trim tanpa menyimpan hasilnya, lalu berharap variabel asal berubah.",
        "Mengira length setelah trim sama dengan panjang teks sebelum spasinya dihapus.",
        "Menyambung angka dan teks tanpa mengubah angka menjadi String.",
      ],
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
      'explanation': "readLineSync membaca satu baris dari terminal. Jika masukan kosong, operator ?? memberi nilai teks kosong sebagai pengganti null.",
      'output': "Masukkan nama: Zahra\nHalo, Zahra!",
      'exercise': "Minta nama pengguna lalu tampilkan pesan Selamat belajar, diikuti nama tersebut.",
      'hint': "Simpan readLineSync ke variabel nama, kemudian sisipkan nama itu pada String output.",
      'objectives': [
        "Menampilkan informasi dengan print dan stdout.write.",
        "Membaca masukan teks dari terminal.",
        "Mengubah masukan angka dengan int.tryParse secara aman.",
      ],
      'conceptGuide': "stdin.readLineSync mengembalikan String? karena masukan bisa tidak tersedia. Gunakan ?? untuk nilai pengganti dan int.tryParse untuk konversi angka yang mungkin gagal. stdout.write menulis prompt tanpa pindah baris, sedangkan print menambahkan baris baru.",
      'examples': [
        {
          'title': "Membaca dan memeriksa masukan umur",
          'explanation': "Masukan dibaca sebagai teks. int.tryParse mencoba mengubahnya menjadi angka; jika gagal, nilai 0 dipakai agar program tetap memiliki nilai yang bisa diproses.",
          'code': "import 'dart:io';\n\nstdout.write('Masukkan umur: ');\nString input = stdin.readLineSync() ?? '';\nint umur = int.tryParse(input) ?? 0;\n\nprint('Tahun depan: ' + (umur + 1).toString());",
          'output': "Masukkan umur: 17\nTahun depan: 18",
        },
      ],
      'commonMistakes': [
        "Menganggap hasil readLineSync selalu berisi teks dan bukan null.",
        "Memakai int.parse pada masukan yang belum dipastikan berupa angka.",
        "Lupa bahwa masukan terminal berbentuk String sebelum dikonversi.",
      ],
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
      'explanation': "Contoh menghitung pengurangan pada variabel pertama, lalu menunjukkan operasi penjumlahan yang sesuai dengan kebutuhan. Nilai yang ditampilkan adalah hasil dari hasilBenar.",
      'output': "13",
      'exercise': "Program ingin menghitung total harga 12 ditambah biaya kirim 3, tetapi memakai operator yang salah. Perbaiki hasilnya.",
      'hint': "Periksa operator aritmatika pada ekspresi dan pilih operator penjumlahan.",
      'objectives': [
        "Membedakan syntax error, runtime error, dan logic error.",
        "Memeriksa nilai antara untuk menemukan sumber hasil yang salah.",
        "Menguji ulang program setelah perbaikan.",
      ],
      'conceptGuide': "Mulailah dengan membaca pesan error dan baris yang ditunjuk. Jika program tetap berjalan tetapi hasilnya keliru, lacak nilai variabel dari input sampai output dan periksa rumusnya. Ubah satu hal dalam satu waktu, lalu jalankan kembali contoh normal dan contoh batas.",
      'examples': [
        {
          'title': "Menelusuri perhitungan rata-rata",
          'explanation': "Menampilkan total dan rata-rata sebagai titik pemeriksaan membantu melihat tahap mana yang menghasilkan nilai tidak sesuai.",
          'code': "List<int> nilai = [70, 80];\nint total = 0;\n\nfor (final angka in nilai) {\n  total += angka;\n}\n\ndouble rataRata = total / nilai.length;\nprint('Total: ' + total.toString());\nprint('Rata-rata: ' + rataRata.toStringAsFixed(1));",
          'output': "Total: 150\nRata-rata: 75.0",
        },
      ],
      'commonMistakes': [
        "Mengubah banyak bagian sekaligus sehingga sumber bug makin sulit dilacak.",
        "Mengabaikan pesan error atau tidak memeriksa baris yang ditunjuk.",
        "Menganggap program bebas bug hanya karena satu contoh berhasil.",
      ],
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
      'explanation': "Siswa adalah class yang menyimpan nama dan menyediakan method perkenalan. Object siswa dibuat dari class itu lalu method-nya dipanggil.",
      'output': "Nama saya Alya",
      'exercise': "Buat class Buku dengan property judul dan method untuk menampilkan judul buku.",
      'hint': "Tulis constructor untuk mengisi judul, lalu buat method yang memanggil print.",
      'objectives': [
        "Membuat class sebagai rancangan objek.",
        "Menyimpan data objek pada property.",
        "Membuat constructor dan memanggil method.",
      ],
      'conceptGuide': "Class menyatukan data dan perilaku yang berkaitan. Constructor dijalankan ketika object dibuat dan dapat mengisi property; method adalah function yang dimiliki class. Setiap object memiliki nilai property sendiri, tetapi menggunakan rancangan class yang sama.",
      'examples': [
        {
          'title': "Membuat object Produk",
          'explanation': "Produk mendefinisikan property nama dan harga. Constructor mengisi keduanya saat object buku dibuat, lalu method tampilkan memakai data object tersebut.",
          'code': "class Produk {\n  final String nama;\n  final int harga;\n\n  Produk(this.nama, this.harga);\n\n  void tampilkan() {\n    print(nama + ': Rp' + harga.toString());\n  }\n}\n\nvoid main() {\n  final buku = Produk('Buku', 15000);\n  buku.tampilkan();\n}",
          'output': "Buku: Rp15000",
        },
      ],
      'commonMistakes': [
        "Mencoba memanggil method instance langsung dari class tanpa membuat object.",
        "Lupa mengisi property yang wajib saat membuat object.",
        "Membuat class hanya berisi data tanpa memahami perilaku yang perlu dimiliki object.",
      ],
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
      'explanation': "Variabel nilai menyimpan masukan contoh. Kondisi menentukan status, kemudian print menampilkan keputusan program.",
      'output': "Lulus",
      'exercise': "Ubah kasus ini agar memeriksa nilai 2 mata pelajaran dan menampilkan Lulus jika rata-ratanya minimal 75.",
      'hint': "Jumlahkan kedua nilai, bagi dua, lalu bandingkan rata-ratanya dengan 75.",
      'objectives': [
        "Mengidentifikasi kebutuhan dan membentuk input, proses, serta output.",
        "Menggabungkan List, perulangan, variabel, dan percabangan.",
        "Menguji kasus normal, batas, dan data yang belum tersedia.",
      ],
      'conceptGuide': "Selesaikan masalah secara bertahap: tulis kebutuhan, tentukan data masukan, rancang proses, lalu tentukan hasil yang diharapkan. Pecah pekerjaan menjadi langkah kecil dan gunakan konsep yang sudah dipelajari. Uji beberapa data, termasuk nilai tepat di ambang dan jumlah data kosong atau minimum.",
      'examples': [
        {
          'title': "Rekap nilai beberapa mata pelajaran",
          'explanation': "List menyimpan nilai, loop menghitung jumlah, lalu program menghitung rata-rata dan memilih status berdasarkan ambang 75.",
          'code': "List<int> nilai = [80, 65, 90];\nint total = 0;\n\nfor (final angka in nilai) {\n  total += angka;\n}\n\ndouble rataRata = total / nilai.length;\nString status;\nif (rataRata >= 75) {\n  status = 'Lulus';\n} else {\n  status = 'Belajar lagi';\n}\n\nprint('Rata-rata: ' + rataRata.toStringAsFixed(1));\nprint('Status: ' + status);",
          'output': "Rata-rata: 78.3\nStatus: Lulus",
        },
      ],
      'commonMistakes': [
        "Mulai menulis kode sebelum jelas apa input dan output yang diinginkan.",
        "Tidak menguji nilai tepat pada ambang kelulusan.",
        "Menghitung rata-rata dengan pembagi yang tidak sama dengan jumlah nilai.",
      ],
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
    final accent = AppColors.learningAccentFor(number);

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
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.softTint(accent, opacity: 0.4),
                    AppColors.surface,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(30),
                ),
                border: Border.all(color: accent.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(
                          material['icon'] as IconData,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.butterYellow,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'MATERI $number / 12',
                          style: const TextStyle(
                            color: AppColors.darkText,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    material['title'] as String,
                    style: const TextStyle(
                      color: AppColors.darkText,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    material['subtitle'] as String,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
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
            const SizedBox(height: 20),
            _buildLearningObjectives(content['objectives'] as List<String>),
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
                color: AppColors.primaryDark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(22),
                ),
                border: Border.all(
                  color: AppColors.deepBlue.withValues(alpha: 0.3),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableText(
                  content['code'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    height: 1.7,
                    color: AppColors.softWhite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _sectionTitle('Bedah Contoh'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.softTint(AppColors.dustyBlue, opacity: 0.22),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                content['explanation'] as String,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  height: 1.55,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _sectionTitle('Pendalaman Materi'),
            const SizedBox(height: 8),
            _buildConceptGuideCard(
              content['conceptGuide'] as String,
              accent: accent,
            ),
            const SizedBox(height: 20),
            _sectionTitle('Hasil Contoh'),
            const SizedBox(height: 10),
            _buildOutputCard(content['output'] as String),
            const SizedBox(height: 20),
            _sectionTitle('Contoh Tambahan'),
            const SizedBox(height: 10),
            ...(content['examples'] as List).map(
              (example) => _buildExtraExampleCard(
                Map<String, dynamic>.from(example as Map),
                accent: accent,
              ),
            ),
            const SizedBox(height: 20),
            _sectionTitle('Kesalahan Umum'),
            const SizedBox(height: 10),
            _buildCommonMistakes(content['commonMistakes'] as List<String>),
            const SizedBox(height: 20),
            _buildChallengeCard(
              context,
              exercise: content['exercise'] as String,
              hint: content['hint'] as String,
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
            const SizedBox(height: 24),
            MaterialLearningActions(material: material),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningObjectives(List<String> objectives) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.deepBlue],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.flag_rounded, color: AppColors.butterYellow),
              SizedBox(width: 8),
              Text(
                'TARGET BELAJAR',
                style: TextStyle(
                  color: AppColors.butterYellow,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...objectives.map(
            (objective) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: AppColors.softWhite,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      objective,
                      style: TextStyle(
                        color: AppColors.softWhite,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConceptGuideCard(String guide, {required Color accent}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softTint(AppColors.softLilac, opacity: 0.2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome_rounded, color: AppColors.softLilac),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              guide,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraExampleCard(
    Map<String, dynamic> example, {
    required Color accent,
  }) {
    final accentForeground = accent.computeLuminance() > 0.32
        ? AppColors.darkText
        : AppColors.softWhite;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(22),
        ),
        border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.1),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.code_rounded,
                  color: accentForeground,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  example['title'] as String,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            example['explanation'] as String,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                example['code'] as String,
                style: const TextStyle(
                  color: AppColors.softWhite,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.55,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildOutputCard(example['output'] as String),
        ],
      ),
    );
  }

  Widget _buildCommonMistakes(List<String> mistakes) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softTint(AppColors.dustyRose, opacity: 0.16),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.dustyRose.withValues(alpha: 0.42)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: mistakes
            .map(
              (mistake) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.dustyRose,
                      size: 19,
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        mistake,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildOutputCard(String output) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(22),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.terminal_rounded, color: AppColors.butterYellow),
          const SizedBox(width: 12),
          Expanded(
            child: SelectableText(
              output,
              style: const TextStyle(
                color: AppColors.softWhite,
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(
    BuildContext context, {
    required String exercise,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.softTint(AppColors.peach, opacity: 0.28),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(26),
        ),
        border: Border.all(color: AppColors.peach.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TANTANGAN MINI',
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      exercise,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const CodifyMascot(size: 54),
            ],
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Material(
              color: Colors.transparent,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(bottom: 14),
                iconColor: AppColors.primaryDark,
                collapsedIconColor: AppColors.primaryDark,
                leading: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: AppColors.primaryDark,
                ),
                title: const Text(
                  'Tampilkan petunjuk',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      hint,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

class MaterialLearningActions extends StatefulWidget {
  final Map<String, dynamic> material;

  const MaterialLearningActions({super.key, required this.material});

  @override
  State<MaterialLearningActions> createState() =>
      _MaterialLearningActionsState();
}

class _MaterialLearningActionsState extends State<MaterialLearningActions> {
  late Future<Set<String>> _completedMaterials;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadCompletion();
  }

  void _loadCompletion() {
    _completedMaterials = LearningStore.getCompletedMaterials();
  }

  Future<void> _setCompletion(bool isCompleted) async {
    setState(() => _isSaving = true);
    try {
      final materialNumber = widget.material['number'] as String;
      if (isCompleted) {
        await LearningStore.unmarkMaterialCompleted(materialNumber);
      } else {
        await LearningStore.markMaterialCompleted(materialNumber);
      }
      if (!mounted) {
        return;
      }
      setState(() {
        _isSaving = false;
        _loadCompletion();
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Progres materi tidak berhasil diperbarui: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MaterialPracticeScreen(material: widget.material),
              ),
            );
            if (mounted) {
              setState(_loadCompletion);
            }
          },
          icon: const Icon(Icons.quiz_outlined),
          label: const Text('Mulai Latihan Interaktif'),
        ),
        const SizedBox(height: 12),
        FutureBuilder<Set<String>>(
          future: _completedMaterials,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                'Progres materi gagal dimuat: ${snapshot.error}',
                style: const TextStyle(color: AppColors.error),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final isCompleted = snapshot.data!.contains(
              widget.material['number'],
            );
            if (isCompleted) {
              return Column(
                children: [
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.check_circle, color: AppColors.success),
                    title: Text('Materi sudah ditandai selesai'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _isSaving ? null : () => _setCompletion(true),
                    icon: const Icon(Icons.undo_rounded),
                    label: Text(
                      _isSaving ? 'Memperbarui...' : 'Batalkan Status Selesai',
                    ),
                  ),
                ],
              );
            }
            return OutlinedButton.icon(
              onPressed: _isSaving ? null : () => _setCompletion(false),
              icon: const Icon(Icons.check_circle_outline_rounded),
              label: Text(_isSaving ? 'Menyimpan...' : 'Tandai Materi Selesai'),
            );
          },
        ),
      ],
    );
  }
}
