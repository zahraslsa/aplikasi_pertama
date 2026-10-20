import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import '../widgets/codify_button.dart';

class PracticeQuestion {
  final String question;
  final List<String> options;
  final int answer;
  final String explanation;

  const PracticeQuestion({
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
  });
}

class MaterialPracticeScreen extends StatefulWidget {
  final Map<String, dynamic> material;

  const MaterialPracticeScreen({super.key, required this.material});

  static const Map<String, List<PracticeQuestion>> questionBank = {
    '01': [
      PracticeQuestion(
        question: 'Apa tujuan utama algoritma?',
        options: [
          'Menyimpan file',
          'Menyusun langkah penyelesaian masalah',
          'Menggambar antarmuka',
          'Menghubungkan komputer',
        ],
        answer: 1,
        explanation: 'Algoritma menyusun langkah yang jelas dan berurutan untuk menyelesaikan masalah.',
      ),
      PracticeQuestion(
        question: 'Simbol flowchart untuk mengambil keputusan adalah...',
        options: ['Oval', 'Persegi panjang', 'Belah ketupat', 'Jajar genjang'],
        answer: 2,
        explanation: 'Simbol belah ketupat menyatakan keputusan atau percabangan berdasarkan kondisi.',
      ),
    ],
    '02': [
      PracticeQuestion(
        question: 'Tipe data Dart untuk bilangan bulat adalah...',
        options: ['String', 'int', 'bool', 'List'],
        answer: 1,
        explanation: 'Tipe data int digunakan untuk menyimpan bilangan bulat.',
      ),
      PracticeQuestion(
        question: 'Manakah deklarasi teks yang benar di Dart?',
        options: [
          'String nama = "Alya";',
          'bool nama = "Alya";',
          'int nama = "Alya";',
          'double nama = "Alya";',
        ],
        answer: 0,
        explanation: 'String menyimpan teks, misalnya nama seseorang.',
      ),
    ],
    '03': [
      PracticeQuestion(
        question: 'Apa hasil dari 10 % 3?',
        options: ['0', '1', '3', '10'],
        answer: 1,
        explanation: 'Operator % menghasilkan sisa pembagian; sisa 10 dibagi 3 adalah 1.',
      ),
      PracticeQuestion(
        question: 'Operator untuk membandingkan dua nilai agar sama adalah...',
        options: ['=', '==', '!=', '&&'],
        answer: 1,
        explanation: 'Operator == membandingkan kesamaan; = digunakan untuk memberi nilai.',
      ),
    ],
    '04': [
      PracticeQuestion(
        question: 'Kapan blok else dijalankan?',
        options: [
          'Saat kondisi if bernilai false',
          'Sebelum kondisi diperiksa',
          'Setiap perulangan selesai',
          'Hanya ketika program error',
        ],
        answer: 0,
        explanation:
            'Blok else dijalankan ketika kondisi pada if tidak terpenuhi.',
      ),
      PracticeQuestion(
        question:
            'Struktur yang tepat untuk memilih berdasarkan kondisi adalah...',
        options: ['for', 'if-else', 'List', 'print'],
        answer: 1,
        explanation: 'if-else memilih jalur program berdasarkan hasil kondisi.',
      ),
    ],
    '05': [
      PracticeQuestion(
        question: 'Perulangan yang sesuai ketika jumlah pengulangan diketahui adalah...',
        options: ['if', 'for', 'switch', 'class'],
        answer: 1,
        explanation: 'Perulangan for umum digunakan ketika jumlah iterasi dapat ditentukan.',
      ),
      PracticeQuestion(
        question: 'Apa fungsi break di dalam perulangan?',
        options: [
          'Memulai ulang program',
          'Menghentikan perulangan',
          'Melewati deklarasi variabel',
          'Mencetak nilai',
        ],
        answer: 1,
        explanation:
            'break langsung menghentikan perulangan yang sedang berjalan.',
      ),
    ],
    '06': [
      PracticeQuestion(
        question: 'Indeks elemen pertama List di Dart adalah...',
        options: ['0', '1', '-1', 'length'],
        answer: 0,
        explanation: 'Indeks List dimulai dari 0.',
      ),
      PracticeQuestion(
        question: 'Metode untuk menambahkan elemen ke List adalah...',
        options: ['insertText()', 'append()', 'add()', 'pushData()'],
        answer: 2,
        explanation: 'Metode add() menambahkan satu elemen ke akhir List.',
      ),
    ],
    '07': [
      PracticeQuestion(
        question: 'Apa kegunaan parameter pada function?',
        options: [
          'Menerima data masukan untuk function',
          'Menghentikan aplikasi',
          'Menghapus class',
          'Mengubah tipe semua variabel',
        ],
        answer: 0,
        explanation:
            'Parameter menjadi tempat menerima nilai saat function dipanggil.',
      ),
      PracticeQuestion(
        question:
            'Kata kunci untuk mengembalikan nilai dari function adalah...',
        options: ['break', 'return', 'continue', 'class'],
        answer: 1,
        explanation:
            'return mengirimkan nilai hasil dari function kepada pemanggil.',
      ),
    ],
    '08': [
      PracticeQuestion(
        question:
            'Metode String untuk menghapus spasi di awal dan akhir adalah...',
        options: ['split()', 'trim()', 'replaceAll()', 'length'],
        answer: 1,
        explanation: 'trim() menghapus whitespace di awal dan akhir String.',
      ),
      PracticeQuestion(
        question: 'Apa hasil nama.toUpperCase()?',
        options: [
          'Nama menjadi huruf kecil',
          'Nama menjadi huruf besar',
          'Nama menjadi angka',
          'Nama terhapus',
        ],
        answer: 1,
        explanation: 'toUpperCase() menghasilkan String dengan huruf kapital.',
      ),
    ],
    '09': [
      PracticeQuestion(
        question: 'Apa yang disebut output dalam program?',
        options: [
          'Data yang diterima program',
          'Hasil yang disampaikan program',
          'Kesalahan penulisan kode',
          'Nama variabel',
        ],
        answer: 1,
        explanation:
            'Output adalah hasil atau informasi yang ditampilkan program.',
      ),
      PracticeQuestion(
        question: 'Di Dart, fungsi stdin.readLineSync() digunakan untuk...',
        options: [
          'Membaca masukan teks',
          'Menampilkan gambar',
          'Menghapus List',
          'Menghentikan perulangan',
        ],
        answer: 0,
        explanation:
            'readLineSync() membaca teks yang dimasukkan melalui stdin.',
      ),
    ],
    '10': [
      PracticeQuestion(
        question: 'Program berjalan tanpa error tetapi hasilnya salah. Ini disebut...',
        options: [
          'Syntax error',
          'Logic error',
          'Runtime success',
          'Input error',
        ],
        answer: 1,
        explanation: 'Logic error terjadi saat program berjalan tetapi logikanya memberi hasil keliru.',
      ),
      PracticeQuestion(
        question: 'Langkah awal yang baik saat debugging adalah...',
        options: [
          'Menghapus seluruh kode',
          'Membaca pesan error dan memeriksa baris terkait',
          'Mengabaikan hasil program',
          'Mengganti semua nama variabel',
        ],
        answer: 1,
        explanation: 'Pesan error dan lokasi baris membantu mempersempit sumber masalah.',
      ),
    ],
    '11': [
      PracticeQuestion(
        question: 'Dalam OOP, class adalah...',
        options: [
          'Cetak biru untuk membuat objek',
          'Nilai yang selalu berupa angka',
          'Sebuah perulangan',
          'Pesan kesalahan',
        ],
        answer: 0,
        explanation:
            'Class mendefinisikan struktur dan perilaku yang dimiliki objek.',
      ),
      PracticeQuestion(
        question: 'Objek adalah...',
        options: [
          'Instance yang dibuat berdasarkan class',
          'Operator logika',
          'Tipe komentar',
          'Urutan flowchart',
        ],
        answer: 0,
        explanation: 'Objek merupakan instance nyata dari sebuah class.',
      ),
    ],
    '12': [
      PracticeQuestion(
        question: 'Langkah yang sebaiknya dilakukan sebelum menulis kode studi kasus adalah...',
        options: [
          'Memahami masalah dan menentukan kebutuhan',
          'Menghapus semua data',
          'Menjalankan program berulang tanpa tujuan',
          'Memilih warna aplikasi',
        ],
        answer: 0,
        explanation: 'Memahami masalah membantu menentukan input, proses, dan output yang tepat.',
      ),
      PracticeQuestion(
        question: 'Mengapa program perlu diuji dengan beberapa kondisi?',
        options: [
          'Untuk memastikan hasil sesuai kebutuhan',
          'Agar kode menjadi lebih panjang',
          'Untuk menghindari penggunaan variabel',
          'Agar program tidak memiliki output',
        ],
        answer: 0,
        explanation: 'Pengujian pada kondisi berbeda membantu memastikan logika program benar.',
      ),
    ],
  };

  static List<PracticeQuestion> questionsFor(String materialNumber) {
    final questions = questionBank[materialNumber];
    if (questions == null) {
      throw ArgumentError.value(materialNumber, 'materialNumber');
    }
    return questions;
  }

  @override
  State<MaterialPracticeScreen> createState() => _MaterialPracticeScreenState();
}

class _MaterialPracticeScreenState extends State<MaterialPracticeScreen> {
  late final List<PracticeQuestion> _questions;
  late final List<int?> _answers;
  int _currentQuestion = 0;
  bool _isChecked = false;
  bool _isSaving = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _questions = MaterialPracticeScreen.questionsFor(
      widget.material['number'] as String,
    );
    _answers = List<int?>.filled(_questions.length, null);
  }

  int get _correctAnswers => List.generate(
    _questions.length,
    (index) => _answers[index] == _questions[index].answer ? 1 : 0,
  ).fold(0, (total, correct) => total + correct);

  int get _score => ((_correctAnswers / _questions.length) * 100).round();

  String get _feedback {
    if (_score >= 80) {
      return 'Bagus! Kompetensi materi ini sudah tercapai. Materi ditandai selesai.';
    }
    if (_score >= 50) {
      return 'Cukup baik. Tinjau kembali konsep yang belum tepat, lalu coba lagi.';
    }
    return 'Ayo pelajari kembali rangkuman dan contoh kode sebelum mengulang latihan.';
  }

  void _checkAnswer() {
    if (_answers[_currentQuestion] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jawaban sebelum memeriksa.')),
      );
      return;
    }
    setState(() => _isChecked = true);
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestion++;
      _isChecked = false;
    });
  }

  Future<void> _saveResult() async {
    if (_isSaving || _isSaved) {
      return;
    }
    setState(() => _isSaving = true);
    try {
      await LearningStore.savePracticeResult(
        materialNumber: widget.material['number'] as String,
        materialTitle: widget.material['title'] as String,
        score: _score,
        correctAnswers: _correctAnswers,
        totalQuestions: _questions.length,
      );
      if (mounted) {
        setState(() {
          _isSaving = false;
          _isSaved = true;
        });
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hasil latihan tidak berhasil disimpan: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];
    final selectedAnswer = _answers[_currentQuestion];
    final isCorrect = selectedAnswer == question.answer;
    final isLastQuestion = _currentQuestion == _questions.length - 1;

    return Scaffold(
      appBar: AppBar(title: Text('Latihan ${widget.material['title']}')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (_currentQuestion + 1) / _questions.length,
                minHeight: 6,
                backgroundColor: AppColors.primaryLight,
                color: AppColors.primary,
              ),
              const SizedBox(height: 18),
              Text(
                'Soal ${_currentQuestion + 1} dari ${_questions.length}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                question.question,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(question.options.length, (index) {
                final isSelected = selectedAnswer == index;
                final isAnswer = question.answer == index;
                final color = !_isChecked
                    ? (isSelected ? AppColors.primary : AppColors.border)
                    : isAnswer
                    ? AppColors.success
                    : isSelected
                    ? AppColors.error
                    : AppColors.border;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: _isChecked
                        ? null
                        : () => setState(
                            () => _answers[_currentQuestion] = index,
                          ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryLight
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: color,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        question.options[index],
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              if (_isChecked) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? AppColors.success.withValues(alpha: 0.1)
                        : AppColors.warning.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCorrect ? 'Jawaban benar!' : 'Belum tepat',
                        style: TextStyle(
                          color: isCorrect
                              ? AppColors.success
                              : AppColors.warning,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        question.explanation,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              if (_isSaved) ...[
                Text(
                  'Nilai latihan: $_score/100',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _feedback,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                CodifyButton(
                  text: 'Kembali ke Materi',
                  onPressed: () => Navigator.pop(context),
                ),
              ] else if (!_isChecked) ...[
                CodifyButton(text: 'Periksa Jawaban', onPressed: _checkAnswer),
              ] else if (!isLastQuestion) ...[
                CodifyButton(text: 'Soal Berikutnya', onPressed: _nextQuestion),
              ] else ...[
                Text(
                  'Nilai latihan: $_score/100',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _feedback,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                CodifyButton(
                  text: _isSaving ? 'Menyimpan...' : 'Simpan Hasil Latihan',
                  isLoading: _isSaving,
                  onPressed: _saveResult,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
