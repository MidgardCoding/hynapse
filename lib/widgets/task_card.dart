import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum TaskPriority { high, medium, low }

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.number,
    required this.title,
    required this.description,
    required this.priority,
    required this.onTap,
    this.completed = false,
    this.accent,
  });

  final int number;
  final String title;
  final String description;
  final TaskPriority priority;
  final VoidCallback onTap;
  final bool completed;
  final Color? accent;

  Color get _priorityColor => switch (priority) {
    TaskPriority.high => AppColors.danger,
    TaskPriority.medium => AppColors.amber,
    TaskPriority.low => AppColors.cyan,
  };

  String get _priorityLabel => switch (priority) {
    TaskPriority.high => 'Wysoki priorytet',
    TaskPriority.medium => 'Średni priorytet',
    TaskPriority.low => 'Niski priorytet',
  };

  @override
  Widget build(BuildContext context) {
    final color = accent ?? _priorityColor;
    final fill = completed
        ? AppColors.green.withValues(alpha: 0.10)
        : color.withValues(alpha: 0.10);

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: (completed ? AppColors.green : color).withValues(
                  alpha: 0.28,
                ),
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 78,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: completed
                            ? [AppColors.green, const Color(0xFF13A95B)]
                            : [
                                color,
                                Color.lerp(color, Colors.black, 0.35) ?? color,
                              ],
                      ),
                    ),
                    child: Center(
                      child: completed
                          ? const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 38,
                            )
                          : Text(
                              '$number',
                              style: TextStyle(
                                fontFamily: 'Bungee',
                                fontWeight: FontWeight.w700,
                                fontSize: 48,
                                height: 1,
                                color: Colors.white.withValues(alpha: 0.94),
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 15, 14, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Bungee',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    letterSpacing: 0.4,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 18,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.35,
                              color: Colors.white.withValues(alpha: 0.70),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: completed ? AppColors.green : color,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                completed ? 'ZREALIZOWANO' : _priorityLabel,
                                style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 0.7,
                                  fontWeight: FontWeight.w700,
                                  color: completed ? AppColors.green : color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
