import 'dart:collection';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexPolygon extends StatefulWidget {
  YandexPolygon({Key? key}) : super(key: key);

  @override
  _YandexPolygonState createState() => _YandexPolygonState();
}

class _YandexPolygonState extends State<YandexPolygon> {
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Polyline> _polyLines = HashSet<Polyline>();
  late final YandexMapController controller;
  bool _drawPolygonEnabled = false;
  List<Point> _userPolyLinesLatLngList = [];

  bool _clearDrawing = false;
  double? _lastXCoordinate, _lastYCoordinate;
  final MapObjectId mapObjectId = const MapObjectId('polyline');
  final List<MapObject> mapObjects = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
          onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
          child: YandexMap(
            onMapCreated: (_controller) {
              controller = _controller;
            },
            mapObjects: mapObjects,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleDrawing,
        tooltip: 'Drawing',
        child: Icon((_drawPolygonEnabled) ? Icons.cancel : Icons.edit),
      ),
    );
  }

  _toggleDrawing() {
    final mapObject = PolylineMapObject(
      mapId: mapObjectId,
      polyline: Polyline(points: _userPolyLinesLatLngList),
      strokeColor: Colors.orange[700]!,
      strokeWidth: 7.5,
      outlineColor: Colors.yellow[200]!,
      outlineWidth: 2.0,
      turnRadius: 10.0,
      arcApproximationStep: 1.0,
      gradientLength: 1.0,
      isInnerOutlineEnabled: true,
    );
    mapObjects.add(mapObject);
    _clearPolygons();
    setState(() => _drawPolygonEnabled = !_drawPolygonEnabled);
  }

  _onPanUpdate(DragUpdateDetails details) async {
    // To start draw new polygon every time.
    if (_clearDrawing) {
      _clearDrawing = false;
      _clearPolygons();
    }

    if (_drawPolygonEnabled) {
      double x, y;
      // if (Platform.isAndroid) {
      //   // It times in 3 without any meaning,
      //   // We think it's an issue with GoogleMaps package.
      //   x = details.globalPosition.dx * 3;
      //   y = details.globalPosition.dy * 3;
      // } else if (Platform.isIOS) {
      x = details.globalPosition.dx;
      y = details.globalPosition.dy;
      // }

      // Round the x and y.
      double xCoordinate = x;
      double yCoordinate = y;

      // Check if the distance between last point is not too far.
      // to prevent two fingers drawing.
      if (_lastXCoordinate != null && _lastYCoordinate != null) {
        var distance = Math.sqrt(Math.pow(xCoordinate - _lastXCoordinate!, 2) +
            Math.pow(yCoordinate - _lastYCoordinate!, 2));
        // Check if the distance of point and point is large.
        if (distance > 80.0) return;
      }

      // Cached the coordinate.
      _lastXCoordinate = xCoordinate;
      _lastYCoordinate = yCoordinate;

      //ScreenCoordinate screenCoordinate = ScreenCoordinate(x: xCoordinate, y: yCoordinate);
      ScreenPoint screenPoint = ScreenPoint(x: xCoordinate, y: yCoordinate);
      //final GoogleMapController controller = await _controller.future;
      // LatLng latLng = await controller.getLatLng(screenCoordinate);
      Point? screenPoints = await controller.getPoint(screenPoint);

      try {
        // Add new point to list.
        //  _userPolyLinesLatLngList.add(latLng);

        //  _polyLines.removeWhere(
        //      (polyline) => polyline.polylineId.value == 'user_polyline');
        _userPolyLinesLatLngList.add(screenPoints!);

        _polyLines.add(
          Polyline(
            //  polylineId: PolylineId('user_polyline'),
            points: _userPolyLinesLatLngList,
            // width: 2,
            // color: Colors.blue,
          ),
        );
      } catch (e) {
        print(" error painting $e");
      }
      setState(() {});
    }
  }

  _onPanEnd(DragEndDetails details) async {
    // Reset last cached coordinate
    _lastXCoordinate = null;
    _lastYCoordinate = null;

    if (_drawPolygonEnabled) {
      //    _polygons
      //       .removeWhere((polygon) => polygon.polygonId.value == 'user_polygon');
      //   _polygons.add(
      // Polygon(
      //   polygonId: PolygonId('user_polygon'),
      //   points: _userPolyLinesLatLngList,
      //   strokeWidth: 2,
      //   strokeColor: Colors.blue,
      //   fillColor: Colors.blue.withOpacity(0.4), outerRing: , innerRings: [],
      // ),
      //  );
      setState(() {
        _clearDrawing = true;
      });
    }
  }

  _clearPolygons() {
    setState(() {
      _polyLines.clear();
      _polygons.clear();
      //   _userPolyLinesLatLngList.clear();
    });
  }
}
