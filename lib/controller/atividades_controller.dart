import 'dart:math';
import 'package:flutter/material.dart';
import '../model/atividades_model.dart';

class AppState extends ChangeNotifier {
  final List<Activity> _activities = [
    Activity(id: '1', title: 'Caminhada', calories: 120, durationMinutes: 30),
    Activity(id: '2', title: 'Corrida', calories: 260, durationMinutes: 45),
    Activity(id: '3', title: 'Musculação', calories: 220, durationMinutes: 40),
    Activity(id: '4', title: 'Alongamento', calories: 80, durationMinutes: 20),
    Activity(id: '5', title: 'Yoga', calories: 100, durationMinutes: 35),
  ];

  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _userName = 'Ana';
  int _weeklyGoal = 5;
  bool _notificationsEnabled = true;

  List<Activity> get pendingActivities =>
      _activities.where((a) => !a.isCompleted).toList();
  List<Activity> get completedActivities =>
      _activities.where((a) => a.isCompleted).toList();

  int get currentIndex => _currentIndex;
  bool get isDarkMode => _isDarkMode;
  String get userName => _userName;
  int get weeklyGoal => _weeklyGoal;
  bool get notificationsEnabled => _notificationsEnabled;

  int get totalPending => pendingActivities.length;
  int get totalCompleted => completedActivities.length;
  int get totalCalories =>
      completedActivities.fold(0, (sum, activity) => sum + activity.calories);
  int get totalMinutes => completedActivities.fold(
    0,
    (sum, activity) => sum + activity.durationMinutes,
  );
  double get goalProgress =>
      _weeklyGoal == 0 ? 0 : min(100, totalCompleted / _weeklyGoal * 100);

  String get activityLevel {
    final progress = goalProgress;
    if (progress >= 90) return 'Alta';
    if (progress >= 60) return 'Moderada';
    return 'Leve';
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void toggleActivityStatus(String id) {
    final index = _activities.indexWhere((activity) => activity.id == id);
    if (index == -1) return;
    _activities[index].isCompleted = !_activities[index].isCompleted;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setUserName(String value) {
    _userName = value;
    notifyListeners();
  }

  void setWeeklyGoal(int value) {
    _weeklyGoal = value;
    notifyListeners();
  }

  void setNotificationsEnabled(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void resetProgress() {
    for (final activity in _activities) {
      activity.isCompleted = false;
    }
    notifyListeners();
  }
}
