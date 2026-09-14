import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/learn_store.dart';
import '../../theme/app_colors.dart';
import '../../widgets/avenza_button.dart';

class LessonDetailsScreen extends StatelessWidget {
  final int lessonId;

  const LessonDetailsScreen({
    super.key,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LearnStore>();

    final lesson = store.lessons.firstWhere(
      (item) => item.id == lessonId,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.lightPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(
                Icons.menu_book_outlined,
                size: 70,
                color: AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            lesson.title,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${lesson.category} • ${lesson.durationMinutes} minutes',
            style: const TextStyle(
              color: AppColors.secondaryText,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            lesson.description,
            style: const TextStyle(
              fontSize: 17,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Key idea',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Good financial habits do not have to start with large amounts of money. '
            'The goal is to understand your money and make consistent decisions.',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 30),

          AvenzaButton(
            text: lesson.completed
                ? 'Lesson Completed'
                : 'Mark as Complete',
            icon: Icons.check,
            onPressed: lesson.completed
                ? null
                : () {
                    context
                        .read<LearnStore>()
                        .completeLesson(lesson.id);

                    Navigator.pop(context);
                  },
          ),
        ],
      ),
    );
  }
}