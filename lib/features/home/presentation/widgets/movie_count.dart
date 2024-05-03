import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_time/config/theme/app_theme.dart';

class NowPlayingMovieCountCard extends StatelessWidget {
  final double width;
  final ThemeData theme;

  final int count;

  const NowPlayingMovieCountCard(
      {super.key,
      required this.theme,
      required this.width,
      required this.count});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String formattedDate = formatDateWithSuffix(today);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: width,
        height: 110,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryColor.withOpacity(1),
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      theme.colorScheme.primaryColor.withOpacity(0.8),
                      theme.colorScheme.primaryColor.withOpacity(0.4),
                      theme.colorScheme.primaryColor.withOpacity(0.8),
                    ],
                    stops: const [0.1, 0.5, 0.9],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                width: width / 1.6,
                height: 75,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryColor.withOpacity(1),
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      theme.colorScheme.primaryColor.withOpacity(0.8),
                      theme.colorScheme.primaryColor.withOpacity(0.4),
                      theme.colorScheme.primaryColor.withOpacity(0.8),
                    ],
                    stops: const [0.1, 0.5, 0.9],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                width: width / 1.2,
                height: 80,
              ),
            ),
            Positioned(
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      formattedDate,
                      style: theme.textTheme.movieCountDateStyle.copyWith(
                        color: theme.colorScheme.textColor(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 14.0),
                    child: Text(
                      "We Movies",
                      style: theme.textTheme.movieCountBoldStyle.copyWith(
                        color: theme.colorScheme.textColor(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text(
                      "$count Movies are loaded in now playing",
                      style: theme.textTheme.movieCountStyle.copyWith(
                        color: theme.colorScheme.textColor(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDateWithSuffix(DateTime date) {
  int day = date.day;
  String suffix;

  switch (day) {
    case 1:
    case 21:
    case 31:
      suffix = 'st';
      break;
    case 2:
    case 22:
      suffix = 'nd';
      break;
    case 3:
    case 23:
      suffix = 'rd';
      break;
    default:
      suffix = 'th';
  }

  return "$day$suffix ${DateFormat('MMM yyyy').format(date)}";
}
