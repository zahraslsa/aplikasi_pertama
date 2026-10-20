import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LearningStore {
  LearningStore._();

  static const _diagnosticHistoryKey = 'codify.diagnosticHistory';
  static const _practiceHistoryKey = 'codify.practiceHistory';
  static const _completedMaterialsKey = 'codify.completedMaterials';
  static const _profileKey = 'codify.profile';

  static Future<List<Map<String, dynamic>>> getDiagnosticHistory() async {
    final preferences = await SharedPreferences.getInstance();
    return _readMapList(preferences.getString(_diagnosticHistoryKey));
  }

  static Future<void> saveDiagnosticResult({
    required int overallScore,
    required Map<String, int> topicScores,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final history = _readMapList(preferences.getString(_diagnosticHistoryKey));
    history.add({
      'overallScore': overallScore,
      'topicScores': topicScores,
      'completedAt': DateTime.now().toIso8601String(),
    });
    await _writeString(preferences, _diagnosticHistoryKey, jsonEncode(history));
  }

  static Future<List<Map<String, dynamic>>> getPracticeHistory() async {
    final preferences = await SharedPreferences.getInstance();
    return _readMapList(preferences.getString(_practiceHistoryKey));
  }

  static Future<void> savePracticeResult({
    required String materialNumber,
    required String materialTitle,
    required int score,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final history = _readMapList(preferences.getString(_practiceHistoryKey));
    history.add({
      'materialNumber': materialNumber,
      'materialTitle': materialTitle,
      'score': score,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'completedAt': DateTime.now().toIso8601String(),
    });
    await _writeString(preferences, _practiceHistoryKey, jsonEncode(history));

    if (score >= 80) {
      await markMaterialCompleted(materialNumber);
    }
  }

  static Future<Set<String>> getCompletedMaterials() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(_completedMaterialsKey)?.toSet() ??
        <String>{};
  }

  static Future<void> markMaterialCompleted(String materialNumber) async {
    final preferences = await SharedPreferences.getInstance();
    final completed = preferences.getStringList(_completedMaterialsKey) ?? [];
    if (completed.contains(materialNumber)) {
      return;
    }
    completed.add(materialNumber);
    if (!await preferences.setStringList(_completedMaterialsKey, completed)) {
      throw StateError('Progres materi tidak berhasil disimpan.');
    }
  }

  static Future<Map<String, String>> getProfile() async {
    final preferences = await SharedPreferences.getInstance();
    final encodedProfile = preferences.getString(_profileKey);
    if (encodedProfile == null) {
      return {
        'name': 'Sobat CODIFY',
        'username': '',
        'email': '',
        'class': 'X PPLG',
      };
    }

    final decoded = jsonDecode(encodedProfile);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Data profil CODIFY tidak valid.');
    }
    return decoded.map((key, value) => MapEntry(key, value as String));
  }

  static Future<void> saveProfile(Map<String, String> profile) async {
    final name = profile['name']?.trim() ?? '';
    if (name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Nama tidak boleh kosong.');
    }

    final preferences = await SharedPreferences.getInstance();
    await _writeString(
      preferences,
      _profileKey,
      jsonEncode({...profile, 'name': name}),
    );
  }

  static List<Map<String, dynamic>> _readMapList(String? encoded) {
    if (encoded == null) {
      return [];
    }

    final decoded = jsonDecode(encoded);
    if (decoded is! List) {
      throw const FormatException('Data riwayat CODIFY tidak valid.');
    }
    return decoded.map((item) {
      if (item is! Map) {
        throw const FormatException('Data riwayat CODIFY tidak valid.');
      }
      return Map<String, dynamic>.from(item);
    }).toList();
  }

  static Future<void> _writeString(
    SharedPreferences preferences,
    String key,
    String value,
  ) async {
    if (!await preferences.setString(key, value)) {
      throw StateError('Data CODIFY tidak berhasil disimpan.');
    }
  }
}
