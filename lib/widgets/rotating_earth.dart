import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earth_globe/flutter_earth_globe.dart';
import 'package:flutter_earth_globe/flutter_earth_globe_controller.dart';
import 'package:flutter_earth_globe/globe_coordinates.dart';
import 'package:flutter_earth_globe/point.dart';
import 'package:flutter_earth_globe/sphere_style.dart';
import 'package:vpn_v2ray_full/models/vpn_config.dart';

import '../bloc/vpn_bloc.dart';

class RotatingEarth extends StatefulWidget {
  const RotatingEarth({super.key});

  @override
  State<RotatingEarth> createState() => _RotatingEarthState();
}

class _RotatingEarthState extends State<RotatingEarth> {
  late FlutterEarthGlobeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FlutterEarthGlobeController(
      zoom: 0.5,
      rotationSpeed: 0.02,
      isRotating: true,
      isZoomEnabled: false,
      isBackgroundFollowingSphereRotation: false,
      background: Image.asset('assets/2k_stars.jpg').image,
      surface: Image.asset('assets/2k_earth-night.jpg').image,
    );
    List<Point> points = [];
    final configs = context.read<VpnBloc>().state.configs;
    for (var cfg in configs) {
      final lat = cfg.lat ?? 0.0;
      final lon = cfg.lon ?? 0.0;
      if(lat != 0.0 && lon != 0.0){
        points.add(Point(
            id: cfg.id,
            coordinates:  GlobeCoordinates(lat, lon),
            label: cfg.city,
            isLabelVisible: true,
            style: PointStyle(color: cfg.connection == ConfigStatus.ok ? Colors.green : Colors.red, size: 6)));
      }


    }
   // points = [
   //    Point(
   //        id: '1',
   //
   //        coordinates: const GlobeCoordinates(51.5072, 0.1276),
   //        label: 'London',
   //        isLabelVisible: true,
   //        style: const PointStyle(color: Colors.red, size: 6)),
   //    Point(
   //        id: '2',
   //        isLabelVisible: true,
   //        coordinates: const GlobeCoordinates(40.7128, -74.0060),
   //        style: const PointStyle(color: Colors.green),
   //        onHover: () {},
   //        label: 'New York'),
   //    Point(
   //        id: '3',
   //        isLabelVisible: true,
   //        coordinates: const GlobeCoordinates(60.1719, 24.9347),
   //        style: const PointStyle(color: Colors.blue,size: 12),
   //        onHover: () {
   //          print('Finland');
   //        },
   //        label: 'Finland'),
   //    Point(
   //        id: '4',
   //        isLabelVisible: true,
   //        onTap: () {
   //          Future.delayed(Duration.zero, () {
   //            showDialog(
   //                context: context,
   //                builder: (context) => const AlertDialog(
   //                  title: Text('Center'),
   //                  content: Text('This is the center of the globe'),
   //                ));
   //          });
   //        },
   //        coordinates: const GlobeCoordinates(0, 0),
   //        style: const PointStyle(color: Colors.yellow),
   //        label: 'Center'),
   //  ];

    for (var point in points) {
      _controller.addPoint(point);
    }



  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Listener(
        onPointerDown: (_) => _controller.setSphereStyle(SphereStyle(
            shadowColor: Colors.green,
            shadowBlurSigma: 20)),
    child:FlutterEarthGlobe(
        controller: _controller,
        radius: 120,
      )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
