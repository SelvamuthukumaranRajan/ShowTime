import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_time/features/home/presentation/screens/launch_screen.dart';

import 'config/theme/app_theme.dart';
import 'features/home/presentation/blocs/movies_bloc.dart';
import 'features/home/presentation/screens/landing_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      create: (context) => serviceLocator()..add(const FetchMovies()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().buildLightTheme(),
        darkTheme: AppTheme().buildDarkTheme(),
        themeMode: ThemeMode.system,
        home: const LaunchScreen(),
        // home: LandingScreen(),
      ),
    );
  }
}
