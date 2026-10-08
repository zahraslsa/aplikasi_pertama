import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/codify_button.dart';
import 'diagnostic_result_screen.dart';

class DiagnosticQuestionScreen extends StatefulWidget {
  const DiagnosticQuestionScreen({super.key});

  @override
  State<DiagnosticQuestionScreen> createState() =>
      _DiagnosticQuestionScreenState();
}

class _DiagnosticQuestionScreenState extends State<DiagnosticQuestionScreen> {
  int currentQuestion = 0;

  final List<int?> answers = List.filled(25, null);

  final List<Map<String, dynamic>> questions = [
    // =========================
    // ALGORITMA & FLOWCHART
    // =========================
    {
      'topic': 'Algoritma & Flowchart',
      'question': 'Apa yang dimaksud dengan algoritma?',
      'options': [
        'Bahasa pemrograman',
        'Langkah-langkah sistematis untuk menyelesaikan masalah',
        'Perangkat keras komputer',
        'Aplikasi untuk membuat program',
      ],
      'answer': 1,
    },
    {
      'topic': 'Algoritma & Flowchart',
      'question': 'Simbol flowchart yang digunakan untuk proses adalah...',
      'options': ['Oval', 'Jajar genjang', 'Persegi panjang', 'Belah ketupat'],
      'answer': 2,
    },
    {
      'topic': 'Algoritma & Flowchart',
      'question': 'Algoritma yang baik harus memiliki langkah yang...',
      'options': [
        'Tidak beraturan',
        'Tidak terbatas',
        'Jelas dan sistematis',
        'Sulit dipahami',
      ],
      'answer': 2,
    },
    {
      'topic': 'Algoritma & Flowchart',
      'question': 'Simbol decision pada flowchart berbentuk...',
      'options': ['Lingkaran', 'Belah ketupat', 'Persegi panjang', 'Oval'],
      'answer': 1,
    },
    {
      'topic': 'Algoritma & Flowchart',
      'question': 'Flowchart digunakan untuk...',
      'options': [
        'Menggambar desain grafis',
        'Menggambarkan alur penyelesaian masalah',
        'Membuat database',
        'Mengedit video',
      ],
      'answer': 1,
    },

    // =========================
    // VARIABEL & TIPE DATA
    // =========================
    {
      'topic': 'Variabel & Tipe Data',
      'question': 'Variabel digunakan untuk...',
      'options': [
        'Menyimpan data',
        'Menghapus program',
        'Menjalankan hardware',
        'Membuat jaringan',
      ],
      'answer': 0,
    },
    {
      'topic': 'Variabel & Tipe Data',
      'question': 'Tipe data untuk menyimpan bilangan bulat adalah...',
      'options': ['String', 'Boolean', 'Integer', 'Character'],
      'answer': 2,
    },
    {
      'topic': 'Variabel & Tipe Data',
      'question': 'Data berupa teks biasanya menggunakan tipe data...',
      'options': ['Integer', 'String', 'Boolean', 'Double'],
      'answer': 1,
    },
    {
      'topic': 'Variabel & Tipe Data',
      'question': 'Nilai true dan false termasuk tipe data...',
      'options': ['String', 'Integer', 'Boolean', 'Double'],
      'answer': 2,
    },
    {
      'topic': 'Variabel & Tipe Data',
      'question': 'Manakah contoh nama variabel yang benar?',
      'options': ['1nama', 'nama siswa', 'namaSiswa', 'nama-siswa'],
      'answer': 2,
    },

    // =========================
    // OPERATOR
    // =========================
    {
      'topic': 'Operator',
      'question': 'Operator yang digunakan untuk penjumlahan adalah...',
      'options': ['+', '-', '*', '/'],
      'answer': 0,
    },
    {
      'topic': 'Operator',
      'question': 'Hasil dari 10 % 3 adalah...',
      'options': ['1', '2', '3', '0'],
      'answer': 0,
    },
    {
      'topic': 'Operator',
      'question': 'Operator == biasanya digunakan untuk...',
      'options': [
        'Penjumlahan',
        'Perbandingan kesamaan',
        'Pembagian',
        'Perkalian',
      ],
      'answer': 1,
    },
    {
      'topic': 'Operator',
      'question': 'Operator && merupakan operator...',
      'options': ['Aritmatika', 'Relasional', 'Logika', 'Assignment'],
      'answer': 2,
    },
    {
      'topic': 'Operator',
      'question': 'Operator yang digunakan untuk memberikan nilai pada variabel adalah...',
      'options': ['==', '=', '!=', '>='],
      'answer': 1,
    },

    // =========================
    // PERCABANGAN
    // =========================
    {
      'topic': 'Percabangan',
      'question': 'Percabangan digunakan ketika program perlu...',
      'options': [
        'Mengulang data',
        'Mengambil keputusan berdasarkan kondisi',
        'Menyimpan file',
        'Menghapus variabel',
      ],
      'answer': 1,
    },
    {
      'topic': 'Percabangan',
      'question': 'Struktur percabangan paling sederhana adalah...',
      'options': ['for', 'while', 'if', 'switch'],
      'answer': 2,
    },
    {
      'topic': 'Percabangan',
      'question': 'Perintah else digunakan ketika...',
      'options': [
        'Kondisi if tidak terpenuhi',
        'Kondisi selalu benar',
        'Program selesai',
        'Perulangan dimulai',
      ],
      'answer': 0,
    },
    {
      'topic': 'Percabangan',
      'question': 'Untuk memeriksa beberapa kondisi secara berurutan dapat digunakan...',
      'options': ['if-else if', 'for', 'while', 'break'],
      'answer': 0,
    },
    {
      'topic': 'Percabangan',
      'question': 'Jika nilai >= 75 maka "Lulus", selain itu "Tidak Lulus". Struktur yang tepat adalah...',
      'options': ['if-else', 'for', 'while', 'do-while'],
      'answer': 0,
    },

    // =========================
    // PERULANGAN
    // =========================
    {
      'topic': 'Perulangan',
      'question': 'Perulangan digunakan untuk...',
      'options': [
        'Menjalankan perintah berulang kali',
        'Menyimpan database',
        'Membuat variabel',
        'Menghapus program',
      ],
      'answer': 0,
    },
    {
      'topic': 'Perulangan',
      'question': 'Perulangan yang umum digunakan ketika jumlah pengulangan sudah diketahui adalah...',
      'options': ['if', 'for', 'switch', 'else'],
      'answer': 1,
    },
    {
      'topic': 'Perulangan',
      'question': 'Perulangan while akan berjalan selama...',
      'options': [
        'Program error',
        'Kondisi bernilai benar',
        'Kondisi bernilai salah',
        'Variabel kosong',
      ],
      'answer': 1,
    },
    {
      'topic': 'Perulangan',
      'question': 'Perintah break digunakan untuk...',
      'options': [
        'Menghentikan perulangan',
        'Memulai perulangan',
        'Mengulang program',
        'Membuat variabel',
      ],
      'answer': 0,
    },
    {
      'topic': 'Perulangan',
      'question': 'Perintah continue digunakan untuk...',
      'options': [
        'Menghentikan seluruh program',
        'Melewati iterasi saat ini dan lanjut ke iterasi berikutnya',
        'Menghapus perulangan',
        'Membuat kondisi baru',
      ],
      'answer': 1,
    },
  ];

  void nextQuestion() {
    if (answers[currentQuestion] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih salah satu jawaban terlebih dahulu.'),
        ),
      );
      return;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      showResult();
    }
  }

  void previousQuestion() {
    if (currentQuestion > 0) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  void showResult() {
    int totalCorrect = 0;

    final Map<String, int> topicCorrect = {
      'Algoritma & Flowchart': 0,
      'Variabel & Tipe Data': 0,
      'Operator': 0,
      'Percabangan': 0,
      'Perulangan': 0,
    };

    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i]['answer']) {
        totalCorrect++;

        final topic = questions[i]['topic'] as String;
        topicCorrect[topic] = topicCorrect[topic]! + 1;
      }
    }

    final Map<String, int> topicScores = {};

    topicCorrect.forEach((topic, correct) {
      topicScores[topic] = ((correct / 5) * 100).round();
    });

    final overallScore = ((totalCorrect / questions.length) * 100).round();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DiagnosticResultScreen(
          topicScores: topicScores,
          overallScore: overallScore,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final options = question['options'] as List<String>;

    final progress = (currentQuestion + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Tes Diagnostik')),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.primaryLight,
              color: AppColors.primary,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Soal ${currentQuestion + 1} dari ${questions.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            question['topic'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Pertanyaan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      question['question'],
                      style: const TextStyle(
                        fontSize: 21,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 28),

                    ...List.generate(options.length, (index) {
                      final isSelected = answers[currentQuestion] == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            answers[currentQuestion] = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryLight
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.background,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.border,
                                  ),
                                ),
                                child: Text(
                                  String.fromCharCode(65 + index),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  options[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (currentQuestion > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: previousQuestion,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('Sebelumnya'),
                      ),
                    ),

                  if (currentQuestion > 0) const SizedBox(width: 12),

                  Expanded(
                    child: CodifyButton(
                      text: currentQuestion == questions.length - 1
                          ? 'Selesai'
                          : 'Berikutnya',
                      onPressed: nextQuestion,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
