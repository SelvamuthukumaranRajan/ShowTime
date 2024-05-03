import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:show_time/config/theme/app_theme.dart';
import 'package:show_time/features/home/presentation/blocs/movies_bloc.dart';
import 'package:show_time/features/home/presentation/widgets/landing_titles.dart';
import 'package:show_time/features/home/presentation/widgets/movie_count.dart';
import 'package:show_time/features/home/presentation/widgets/now_playing_card.dart';

import '../widgets/top_rated_card.dart';

class LandingScreen extends StatelessWidget {
  final String mainAddress;
  final String secondaryAddress;

  LandingScreen(
      {super.key, required this.mainAddress, required this.secondaryAddress});

  final TextEditingController filter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: getBody(width, height, theme),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/app_icon.svg',
                width: 24,
                height: 24,
              ),
              label: "We Movies"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined), label: "Explore"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded), label: "Upcoming"),
        ],
      ),
    );
  }

  Widget getBody(double width, double height, ThemeData theme) {
    final mainAddress = this.mainAddress;
    final secondaryAddress = this.secondaryAddress;

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (BuildContext context, MoviesState state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is MoviesRefreshFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    "Failed to refresh movies. Please try again later."),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          }
          if (state is MoviesLoadMoreNowPLayingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    "Failed to to load now playing movies. Please try again later."),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          }
          if (state is MoviesLoadMoreTopRatedFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    "Failed to to load top rated movies. Please try again later."),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          }
        });
        if (state is MoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MoviesFailure) {
          return Center(
            child: Text(
              "Something went wrong!",
              style: theme.textTheme.appBarLocationStyle.copyWith(
                color: theme.colorScheme.textColor(),
              ),
            ),
          );
        }
        if (state is MoviesSuccess ||
            state is MoviesRefreshFailure ||
            state is MoviesLoadMoreNowPLayingLoading ||
            state is MoviesLoadMoreNowPLayingFailure ||
            state is MoviesLoadMoreTopRatedLoading ||
            state is MoviesLoadMoreTopRatedFailure) {
          return RefreshIndicator(
            onRefresh: () {
              context.read<MoviesBloc>().add(const RefreshMovies());
              return Future<void>.value();
            },
            child: Container(
                height: height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primaryColor,
                    theme.colorScheme.secondaryColor
                  ],
                )),
                child: SafeArea(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: buildScrollController(context, state),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                                Icons.location_on_outlined),
                                            baseline: TextBaseline.alphabetic,
                                            alignment:
                                                PlaceholderAlignment.middle,
                                          ),
                                          TextSpan(
                                            text: mainAddress.isNotEmpty
                                                ? mainAddress
                                                : "Not available",
                                            style: theme.textTheme
                                                .appBarLocationBoldStyle
                                                .copyWith(
                                              color:
                                                  theme.colorScheme.textColor(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        secondaryAddress.isNotEmpty
                                            ? secondaryAddress
                                            : "Not available",
                                        overflow: TextOverflow.ellipsis,
                                        style: theme
                                            .textTheme.appBarLocationStyle
                                            .copyWith(
                                          color: theme.colorScheme.textColor(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                    'assets/images/app_icon.svg',
                                    width: 48,
                                    height: 48,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Container(
                              height: 50,
                              width: width - 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.grey[200],
                              ),
                              child: TextField(
                                controller: filter,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.search_rounded),
                                    hintText: 'Search Movies by name....',
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(16.0),
                                    hintStyle: theme.textTheme.searchBarStyle),
                                textAlign: TextAlign.start,
                                onChanged: (query) {
                                  context.read<MoviesBloc>().add(SearchMovies(
                                      query,
                                      state.nowPlayingMoviesEntity!,
                                      state.topRatedMoviesEntity!));
                                },
                              )),
                        ),
                        NowPlayingMovieCountCard(
                            theme: theme,
                            width: width,
                            count:
                                state.nowPlayingMoviesEntity?.results?.length ??
                                    0),
                        state.nowPlayingMoviesEntity?.results?.isNotEmpty ??
                                false
                            ? Column(
                                children: [
                                  LandingTitles(
                                      theme: theme, title: "NOW PLAYING"),
                                  SizedBox(
                                    width: width,
                                    height: height / 2.8,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.nowPlayingMoviesEntity!
                                                .results!.length +
                                            1,
                                        itemBuilder: (context, index) {
                                          if (index ==
                                              state.nowPlayingMoviesEntity!
                                                  .results!.length) {
                                            if (state
                                                is MoviesLoadMoreNowPLayingLoading) {
                                              return const Center(
                                                  child: Padding(
                                                padding: EdgeInsets.all(14),
                                                child:
                                                    CircularProgressIndicator(),
                                              ));
                                            } else {
                                              context.read<MoviesBloc>().add(
                                                    LoadMoreNowPlayingMovies(
                                                      (index ~/ 20) + 1,
                                                      state
                                                          .nowPlayingMoviesEntity!,
                                                      state
                                                          .topRatedMoviesEntity!,
                                                    ),
                                                  );
                                              return const SizedBox.shrink();
                                            }
                                          } else {
                                            return NowPlayingMovieCard(
                                              theme: theme,
                                              movie: state
                                                  .nowPlayingMoviesEntity!
                                                  .results![index],
                                            );
                                          }
                                        }),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        state.topRatedMoviesEntity?.results?.isNotEmpty ?? false
                            ? Column(
                                children: [
                                  LandingTitles(
                                      theme: theme, title: "TOP RATED"),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state
                                        .topRatedMoviesEntity!.results!.length,
                                    itemBuilder: (context, index) {
                                      return TopRatedCard(
                                        theme: theme,
                                        movie: state.topRatedMoviesEntity!
                                            .results![index],
                                      );
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        state is MoviesLoadMoreTopRatedLoading
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.all(14),
                                child: CircularProgressIndicator(),
                              ))
                            : const SizedBox.shrink(),
                      ])),
                )),
          );
        }
        if (state is MoviesSearch) {
          return RefreshIndicator(
            onRefresh: () {
              context.read<MoviesBloc>().add(const RefreshMovies());
              return Future<void>.value();
            },
            child: Container(
                height: height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primaryColor,
                    theme.colorScheme.secondaryColor
                  ],
                )),
                child: SafeArea(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                                Icons.location_on_outlined),
                                            baseline: TextBaseline.alphabetic,
                                            alignment:
                                                PlaceholderAlignment.middle,
                                          ),
                                          TextSpan(
                                            text: mainAddress,
                                            style: theme.textTheme
                                                .appBarLocationBoldStyle
                                                .copyWith(
                                              color:
                                                  theme.colorScheme.textColor(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        secondaryAddress,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme
                                            .textTheme.appBarLocationStyle
                                            .copyWith(
                                          color: theme.colorScheme.textColor(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                    'assets/images/app_icon.svg',
                                    width: 48,
                                    height: 48,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Container(
                              height: 50,
                              width: width - 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.grey[200],
                              ),
                              child: TextField(
                                controller: filter,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.search_rounded),
                                    hintText: 'Search Movies by name....',
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(16.0),
                                    hintStyle: theme.textTheme.searchBarStyle),
                                textAlign: TextAlign.start,
                                onChanged: (query) {
                                  context.read<MoviesBloc>().add(SearchMovies(
                                      query,
                                      state.nowPlayingMoviesEntity!,
                                      state.topRatedMoviesEntity!));
                                },
                              )),
                        ),
                        NowPlayingMovieCountCard(
                            theme: theme,
                            width: width,
                            count:
                                state.nowPlayingMoviesEntity?.results?.length ??
                                    0),
                        state.nowPlayingMoviesEntity?.results?.isNotEmpty ??
                                false
                            ? Column(
                                children: [
                                  LandingTitles(
                                      theme: theme, title: "NOW PLAYING"),
                                  SizedBox(
                                    width: width,
                                    height: height / 2.8,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.nowPlayingMoviesEntity
                                                ?.results?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          if (state.nowPlayingMoviesEntity
                                                      ?.results !=
                                                  null &&
                                              index <
                                                  state.nowPlayingMoviesEntity!
                                                      .results!.length) {
                                            return NowPlayingMovieCard(
                                              theme: theme,
                                              movie: state
                                                  .nowPlayingMoviesEntity!
                                                  .results![index],
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  "No results in now playing movies",
                                  style: theme.textTheme.movieCountBoldStyle
                                      .copyWith(
                                    color: theme.colorScheme.textColor(),
                                  ),
                                ),
                              ),
                        state.topRatedMoviesEntity?.results?.isNotEmpty ?? false
                            ? Column(
                                children: [
                                  LandingTitles(
                                      theme: theme, title: "TOP RATED"),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.topRatedMoviesEntity
                                            ?.results?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      if (state.topRatedMoviesEntity?.results !=
                                              null &&
                                          index <
                                              state.topRatedMoviesEntity!
                                                  .results!.length) {
                                        return TopRatedCard(
                                          theme: theme,
                                          movie: state.topRatedMoviesEntity!
                                              .results![index],
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  "No results in top rated movies",
                                  style: theme.textTheme.movieCountBoldStyle
                                      .copyWith(
                                    color: theme.colorScheme.textColor(),
                                  ),
                                ),
                              ),
                      ])),
                )),
          );
        }
        return Container();
      },
    );
  }

  ScrollController buildScrollController(
      BuildContext context, MoviesState state) {
    final controller = ScrollController();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        context.read<MoviesBloc>().add(
              LoadMoreTopRatedMovies(
                (state.topRatedMoviesEntity!.results!.length ~/ 20) + 1,
                state.nowPlayingMoviesEntity!,
                state.topRatedMoviesEntity!,
              ),
            );
      }
    });
    return controller;
  }
}
