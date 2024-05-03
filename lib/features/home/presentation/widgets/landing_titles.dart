import 'package:flutter/material.dart';
import 'package:show_time/config/theme/app_theme.dart';

class LandingTitles extends StatelessWidget {
  final ThemeData theme;
  final String title;

  const LandingTitles({super.key, required this.theme, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: theme.textTheme.landingTitleStyle.copyWith(
              color: theme.colorScheme.textColor(),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 160,
            height: 1.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black12.withOpacity(0.1),
                  Colors.black12.withOpacity(0)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
