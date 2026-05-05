/// Modelo que representa uma atividade física
class Activity {
  final String id;
  final String name;
  final String icon;
  final int calories;     // Calorias estimadas (kcal)
  final int durationMin;  // Duração estimada em minutos
  final String category;
  bool isCompleted;
  DateTime? completedAt;

  Activity({
    required this.id,
    required this.name,
    required this.icon,
    required this.calories,
    required this.durationMin,
    required this.category,
    this.isCompleted = false,
    this.completedAt,
  });

  /// Cria uma cópia com campos alterados
  Activity copyWith({bool? isCompleted, DateTime? completedAt}) {
    return Activity(
      id: id,
      name: name,
      icon: icon,
      calories: calories,
      durationMin: durationMin,
      category: category,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

/// Lista padrão de atividades disponíveis
List<Activity> defaultActivities() {
  return [
    Activity(
      id: '1',
      name: 'Caminhada',
      icon: '🚶',
      calories: 150,
      durationMin: 30,
      category: 'Cardio',
    ),
    Activity(
      id: '2',
      name: 'Corrida',
      icon: '🏃',
      calories: 300,
      durationMin: 30,
      category: 'Cardio',
    ),
    Activity(
      id: '3',
      name: 'Musculação',
      icon: '🏋️',
      calories: 250,
      durationMin: 60,
      category: 'Força',
    ),
    Activity(
      id: '4',
      name: 'Alongamento',
      icon: '🧘',
      calories: 80,
      durationMin: 20,
      category: 'Flexibilidade',
    ),
    Activity(
      id: '5',
      name: 'Yoga',
      icon: '🧘‍♀️',
      calories: 120,
      durationMin: 45,
      category: 'Bem-estar',
    ),
    Activity(
      id: '6',
      name: 'Ciclismo',
      icon: '🚴',
      calories: 280,
      durationMin: 45,
      category: 'Cardio',
    ),
    Activity(
      id: '7',
      name: 'Natação',
      icon: '🏊',
      calories: 320,
      durationMin: 40,
      category: 'Cardio',
    ),
    Activity(
      id: '8',
      name: 'Pular Corda',
      icon: '⚡',
      calories: 200,
      durationMin: 15,
      category: 'Cardio',
    ),
  ];
}
