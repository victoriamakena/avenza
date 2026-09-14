import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/learn_store.dart';
import '../../widgets/lesson_card.dart';
import '../../widgets/section_title.dart';
import 'lesson_details_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LearnStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Learn while you save',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Simple financial lessons designed to help you make confident money decisions.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),

          const SectionTitle(
            title: 'Recommended for you',
          ),

          const SizedBox(height: 12),

          ...store.lessons.map(
            (lesson) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LessonCard(
                lesson: lesson,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LessonDetailsScreen(
                        lessonId: lesson.id,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}