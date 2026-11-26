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
            _sectionTitle('Hasil Contoh'),
            const SizedBox(height: 10),
            _buildOutputCard(content['output'] as String),
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
