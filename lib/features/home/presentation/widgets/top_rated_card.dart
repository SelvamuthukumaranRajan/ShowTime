import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_time/config/theme/app_theme.dart';
import 'package:show_time/features/home/domain/entity/top_rated_entity.dart';

import '../../../../core/constants/app_constants.dart';

class TopRatedCard extends StatelessWidget {
  final ThemeData theme;
  final ResultsEntity movie;

  const TopRatedCard(
      {super.key, required this.theme, required, required this.movie});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 26.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CachedNetworkImage(
                    width: width,
                    height: height / 5.2,
                    imageUrl:
                        "${AppConstants.topRatedPosterBaseURL}${movie.posterPath}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(
                        child: Icon(
                      Icons.error_rounded,
                      size: 48,
                    )),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(height: 4),
                          // Add spacing between icon and text
                          Text(
                            "${movie.popularity?.round()}",
                            style: theme.textTheme.nowPlayingLanguageStyle
                                .copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Text(
                    "${movie.originalTitle}",
                    style: theme.textTheme.topRatedTitleStyle
                        .copyWith(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${movie.overview}",
                          style: theme.textTheme.topRatedDescStyle
                              .copyWith(color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "${movie.voteCount?.round()} Votes",
                        textAlign: TextAlign.start,
                        style: theme.textTheme.topRatedTextStyle
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          color: Colors.grey.withOpacity(0.5),
                          height: 14,
                          width: 1),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${movie.voteAverage?.round()} ⭐️",
                        textAlign: TextAlign.start,
                        style: theme.textTheme.topRatedTextStyle
                            .copyWith(color: Colors.grey),
                      ),
                    ],
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
