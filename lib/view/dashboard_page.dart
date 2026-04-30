import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_life/controller/app_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá, ${state.userName}',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Acompanhe sua evolução e mantenha sua rotina saudável.'),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.1,
            children: [
              _metricCard(
                context,
                'Atividades concluídas',
                '${state.totalCompleted}',
                Icons.check_circle,
                Colors.green,
              ),
              _metricCard(
                context,
                'Pendentes',
                '${state.totalPending}',
                Icons.pending,
                Colors.orange,
              ),
              _metricCard(
                context,
                'Calorias',
                '${state.totalCalories} kcal',
                Icons.local_fire_department,
                Colors.red,
              ),
              _metricCard(
                context,
                'Tempo total',
                '${state.totalMinutes} min',
                Icons.timer,
                Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Meta semanal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: state.goalProgress / 100,
                    color: const Color(0xFF00A79D),
                    backgroundColor: Colors.grey.shade300,
                    minHeight: 10,
                  ),
                  const SizedBox(height: 12),
                  Text('${state.goalProgress.toStringAsFixed(0)}% concluído'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nível de atividade',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Text(
                        state.activityLevel,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
