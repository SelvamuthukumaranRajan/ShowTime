import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../injection_container.dart';
import '../../data/data_sources/cache_services.dart';
import 'landing_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  final CacheService _cacheService = serviceLocator<CacheService>();
  late String _mainAddress = '';
  late String _secondaryAddress = '';

  @override
  void initState() {
    super.initState();
    _initLandingProcess();
  }

  Future<void> _initLandingProcess() async {
    bool hasPermission = await _requestLocationPermission();
    await _retrieveAddresses(hasPermission);
    _navigateToLandingScreen();
  }

  Future<void> _retrieveAddresses(bool hasPermission) async {
    _mainAddress = await _cacheService.getCachedMainAddress();
    _secondaryAddress = await _cacheService.getCachedSecondaryAddress();

    if (_mainAddress.isEmpty &&
        _secondaryAddress.isEmpty &&
        hasPermission) {
      Position position = await _determinePosition();
      List<Placemark> addresses = await _getAddressFromLatLng(
          position.latitude, position.longitude);
      _updateAddresses(addresses);
    } else if (!hasPermission) {
      _checkPermission();
    }
  }

  void _updateAddresses(List<Placemark> addresses) {
    if (addresses.isNotEmpty) {
      _mainAddress = addresses[0].administrativeArea ?? 'Not available';
      _secondaryAddress = "${addresses[0].street}, ${addresses[0].locality}";
      _cacheService.cacheMainAddress(_mainAddress);
      _cacheService.cacheSecondaryAddress(_secondaryAddress);
    }
  }

  void _navigateToLandingScreen() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LandingScreen(
            mainAddress: _mainAddress,
            secondaryAddress: _secondaryAddress,
          ),
        ),
      );
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<Placemark>> _getAddressFromLatLng(
      double lat, double lng) async {
    return placemarkFromCoordinates(lat, lng);
  }

  Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) return true;
    var statuses = await [Permission.location].request();
    return statuses[Permission.location]?.isGranted ?? false;
  }

  void _checkPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      _showPermissionDialog();
    }
  }

  Future<void> _showPermissionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'This app needs location permission to function properly.'),
                Text('Please grant location access in the app settings.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _navigateToLandingScreen();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/splash_icon.gif",
          height: 125.0,
          width: 125.0,
        ),
      ),
    );
  }
}
