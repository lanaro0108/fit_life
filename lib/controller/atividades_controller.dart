import 'package:flutter/material.dart';
import '../model/atividades_model.dart';

// Provider principal — gerencia todo o estado do aplicativo
class AtividadesController extends ChangeNotifier {
  List<Activity> _pending = [];
  List<Activity> _completed = [];

  List<Activity> get pending => List.unmodifiable(_pending);
  List<Activity> get completed => List.unmodifiable(_completed);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _darkMode = false;
  String _userName = 'NomeUsuario';
  int _weeklyGoal = 5; // meta: atividades por semana

  bool get darkMode => _darkMode;
  String get userName => _userName;
  int get weeklyGoal => _weeklyGoal;

  int get totalCalories => _completed.fold(0, (sum, a) => sum + a.calories);

  int get totalMinutes => _completed.fold(0, (sum, a) => sum + a.durationMin);

  String get totalTimeFormatted {
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    if (h > 0) return '${h}h${m.toString().padLeft(2, '0')}';
    return '${m}min';
  }

  double get weeklyProgress =>
      _weeklyGoal == 0 ? 0 : (_completed.length / _weeklyGoal).clamp(0.0, 1.0);

  int get weeklyProgressPercent => (weeklyProgress * 100).round();

  AtividadesController() {
    _pending = defaultActivities();
  }

  void completeActivity(String id) {
    final idx = _pending.indexWhere((a) => a.id == id);
    if (idx == -1) return;

    final activity = _pending[idx].copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );
    _pending.removeAt(idx);
    _completed.insert(0, activity);
    notifyListeners();
  }

  void undoComplete(String id) {
    final idx = _completed.indexWhere((a) => a.id == id);
    if (idx == -1) return;

    final activity = _completed[idx].copyWith(
      isCompleted: false,
      completedAt: null,
    );
    _completed.removeAt(idx);
    _pending.add(activity);
    notifyListeners();
  }

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  void updateUserName(String name) {
    if (name.trim().isNotEmpty) {
      _userName = name.trim();
      notifyListeners();
    }
  }

  void updateWeeklyGoal(int goal) {
    if (goal > 0) {
      _weeklyGoal = goal;
      notifyListeners();
    }
  }

  /// Reseta todo o progresso
  void resetProgress() {
    _pending = defaultActivities();
    _completed = [];
    notifyListeners();
  }
}
