import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_time/config/theme/app_theme.dart';

import '../../domain/entity/now_playing_entity.dart';
import '../../../../core/constants/app_constants.dart';

class NowPlayingMovieCard extends StatelessWidget {
  final ThemeData theme;
  final ResultsEntity movie;

  const NowPlayingMovieCard(
      {super.key, required this.theme, required this.movie});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipPath(
        clipper: SeatClipper(),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: SizedBox(
            width: width / 1.6,
            height: height / 2.8,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "${AppConstants.nowPlayingPosterBaseURL}${movie.posterPath}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
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
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                baseline: TextBaseline.alphabetic,
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(
                                text: "${movie.popularity?.round()}",
                                style: theme.textTheme.nowPlayingLanguageStyle
                                    .copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: const Icon(
                          Icons.heart_broken_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    // height: 150,
                    height: 130,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                              width: 140,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: Icon(
                                            Icons.lightbulb_outlined,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                        baseline: TextBaseline.alphabetic,
                                        alignment: PlaceholderAlignment.middle,
                                      ),
                                      TextSpan(
                                        text: "English",
                                        style: theme
                                            .textTheme.nowPlayingLanguageStyle
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          // height: 120,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(14),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 8),
                              Text(
                                movie.originalTitle ?? "",
                                style: theme.textTheme.nowPlayingTitleStyle
                                    .copyWith(color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      movie.overview ?? "",
                                      style: theme.textTheme.nowPlayingDescStyle
                                          .copyWith(color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${movie.voteCount} Votes",
                                textAlign: TextAlign.start,
                                style: theme.textTheme.nowPlayingVoteStyle
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
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
    );
  }
}

class SeatClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
