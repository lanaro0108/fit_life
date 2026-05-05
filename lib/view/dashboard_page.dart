import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/atividades_controller.dart';
import '../theme/app_theme.dart';

/// Tela Dashboard — exibe métricas em GridView e ListView
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lê os dados do Provider para atualização automática
    final provider = context.watch<AtividadesController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GreetingCard(provider: provider),
          SizedBox(height: 20),

          _WeeklyGoalCard(provider: provider),
          SizedBox(height: 20),

          Text(
            'Métricas de hoje',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _MetricCard(
                emoji: '✅',
                value: '${provider.completed.length}',
                label: 'Concluídas',
                color: AppTheme.primaryGreen,
              ),
              _MetricCard(
                emoji: '⏳',
                value: '${provider.pending.length}',
                label: 'Pendentes',
                color: AppTheme.accentOrange,
              ),
              _MetricCard(
                emoji: '🔥',
                value: '${provider.totalCalories}',
                label: 'Calorias (kcal)',
                color: Color(0xFFFF3D5A),
              ),
              _MetricCard(
                emoji: '⏱',
                value: provider.totalTimeFormatted,
                label: 'Tempo total',
                color: Color(0xFF7C6FFF),
              ),
            ],
          ),

          SizedBox(height: 20),

          // ── Últimas atividades ────────────────────────────────
          if (provider.completed.isNotEmpty) ...[
            Text(
              'Últimas atividades',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 12),

            // ListView das últimas 5 atividades concluídas
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: provider.completed.length.clamp(0, 5),
              itemBuilder: (context, i) {
                final a = provider.completed[i];
                return _RecentActivityTile(
                  emoji: a.icon,
                  name: a.name,
                  calories: a.calories,
                  duration: a.durationMin,
                  completedAt: a.completedAt,
                );
              },
            ),
          ],

          if (provider.completed.isEmpty)
            _EmptyDashboard(
              onNavigate: () =>
                  context.read<AtividadesController>().setCurrentIndex(1),
            ),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Widgets internos ───────────────────────────────────────────────────────────

class _GreetingCard extends StatelessWidget {
  final AtividadesController provider;
  _GreetingCard({required this.provider}); //

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Bom dia';
    if (h < 18) return 'Boa tarde';
    return 'Boa noite';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_greeting()}, ${provider.userName}!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 22,
                  ),
            ),
            SizedBox(height: 4),
            Text(
              'Continue firme! Você está indo bem.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class _WeeklyGoalCard extends StatelessWidget {
  final AtividadesController provider;
  _WeeklyGoalCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    final progress = provider.weeklyProgress;
    final percent = provider.weeklyProgressPercent;
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Meta Semanal',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _progressColor(progress).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$percent%',
                    style: TextStyle(
                      color: _progressColor(progress),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: scheme.surface,
                valueColor: AlwaysStoppedAnimation(_progressColor(progress)),
                minHeight: 10,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${provider.completed.length} de ${provider.weeklyGoal} atividades concluídas',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Color _progressColor(double progress) {
    if (progress >= 1.0) return AppTheme.primaryGreen;
    if (progress >= 0.5) return AppTheme.accentOrange;
    return Color(0xFFFF3D5A);
  }
}

class _MetricCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color color;

  _MetricCard({
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(emoji, style: TextStyle(fontSize: 24)),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentActivityTile extends StatelessWidget {
  final String emoji;
  final String name;
  final int calories;
  final int duration;
  final DateTime? completedAt;

  _RecentActivityTile({
    required this.emoji,
    required this.name,
    required this.calories,
    required this.duration,
    this.completedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Text(emoji, style: TextStyle(fontSize: 24)),
        title: Text(name,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15)),
        subtitle: Text(
          '${duration}min · $calories kcal',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Icon(
          Icons.check_circle,
          color: AppTheme.primaryGreen,
          size: 20,
        ),
      ),
    );
  }
}

class _EmptyDashboard extends StatelessWidget {
  final VoidCallback onNavigate;
  _EmptyDashboard({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text('💪', style: TextStyle(fontSize: 48)),
            SizedBox(height: 12),
            Text(
              'Comece agora!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 6),
            Text(
              'Vá para Atividades e marque algumas como concluídas.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onNavigate,
              icon: Icon(Icons.fitness_center, size: 18),
              label: Text('Ver Atividades'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
