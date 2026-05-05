import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/atividades_controller.dart';
import '../model/atividades_model.dart';
import '../theme/app_theme.dart';

// Tela de Atividades com TabBarView (Pendentes / Concluídas)
class AtividadesPage extends StatelessWidget {
  const AtividadesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.pending_actions, size: 16),
                      SizedBox(width: 6),
                      Text('Pendentes'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline, size: 16),
                      SizedBox(width: 6),
                      Text('Concluídas'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              children: [
                _PendingTab(),
                _CompletedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _PendingTab extends StatelessWidget {
  _PendingTab();

  @override
  Widget build(BuildContext context) {
    final pending = context.watch<AtividadesController>().pending;

    if (pending.isEmpty) {
      return _EmptyState(
        emoji: '🎉',
        title: 'Tudo concluído!',
        subtitle: 'Você completou todas as atividades de hoje.',
      );
    }

    return ListView.builder(
      padding:    EdgeInsets.all(16),
      itemCount: pending.length,
      itemBuilder: (context, i) => _ActivityCard(
        activity: pending[i],
        isPending: true,
      ),
    );
  }
}


class _CompletedTab extends StatelessWidget {
  _CompletedTab();

  @override
  Widget build(BuildContext context) {
    final completed = context.watch<AtividadesController>().completed;

    if (completed.isEmpty) {
      return _EmptyState(
        emoji: '💪',
        title: 'Nenhuma atividade ainda',
        subtitle: 'Complete atividades na aba Pendentes.',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: completed.length,
      itemBuilder: (context, i) => _ActivityCard(
        activity: completed[i],
        isPending: false,
      ),
    );
  }
}


class _ActivityCard extends StatelessWidget {
  final Activity activity;
  final bool isPending;

  _ActivityCard({required this.activity, required this.isPending});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AtividadesController>();
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isPending
                    ? AppTheme.primaryGreen.withOpacity(0.12)
                    : scheme.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  activity.icon,
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ),

            SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          decoration: isPending
                              ? null
                              : TextDecoration.lineThrough,
                          color: isPending ? null : Colors.grey,
                        ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      _InfoChip(
                        '${activity.calories} kcal',
                        color: AppTheme.accentOrange,
                      ),
                      SizedBox(width: 6),
                      _InfoChip('⏱ ${activity.durationMin}min'),
                    ],
                  ),
                ],
              ),
            ),

            if (isPending)
              _CompleteButton(
                onTap: () {
                  provider.completeActivity(activity.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${activity.name} concluída! +${activity.calories} kcal 🔥'),
                      backgroundColor: AppTheme.primaryGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              )
            else
              IconButton(
                icon: Icon(Icons.undo, color: Colors.grey),
                tooltip: 'Desfazer',
                onPressed: () => provider.undoComplete(activity.id),
              ),
          ],
        ),
      ),
    );
  }
}

/// Botão animado para concluir atividade
class _CompleteButton extends StatelessWidget {
  final VoidCallback onTap;
     _CompleteButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.check,
          color: AppTheme.primaryGreen,
        ),
      ),
    );
  }
}

/// Chip de informação pequena
class _InfoChip extends StatelessWidget {
  final String text;
  final Color? color;
  _InfoChip(this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: (color ?? Colors.grey).withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color ?? Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Estado vazio genérico
class _EmptyState extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

     _EmptyState({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style:    TextStyle(fontSize: 56)),
          SizedBox(height: 16),
          Text(title,
              style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
