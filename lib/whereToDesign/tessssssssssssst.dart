import 'package:design/whereToDesign/users_model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexPolygon extends StatefulWidget {
  List<AddressModel> address;
  YandexPolygon({super.key, required this.address});

  @override
  _YandexPolygonState createState() => _YandexPolygonState();
}

class _YandexPolygonState extends State<YandexPolygon> {
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
      appBar: AppBar(),
      body: GestureDetector(
        onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
        onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
        child: YandexMap(
          onMapCreated: (_controller) {
            controller = _controller;
          },
          mapObjects: mapObjects,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleDrawing,
        tooltip: 'Drawing',
        child: Icon((_drawPolygonEnabled) ? Icons.cancel : Icons.swipe_down),
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
    setState(() {
      mapObjects.add(mapObject);
    });
    final List<AddressModel> address;
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
      x = details.globalPosition.dx * 2.75;
      y = details.globalPosition.dy * 2.75;
      // }

      // Round the x and y.
      double xCoordinate = x;
      double yCoordinate = y;

      // Check if the distance between last point is not too far.
      // to prevent two fingers drawing.
      // if (_lastXCoordinate != null && _lastYCoordinate != null) {
      //   var distance = Math.sqrt(Math.pow(xCoordinate - _lastXCoordinate!, 2) +
      //       Math.pow(yCoordinate - _lastYCoordinate!, 2));
      //   // Check if the distance of point and point is large.
      //   if (distance > 80.0) return;
      // }

      // Cached the coordinate.
      _lastXCoordinate = xCoordinate;
      _lastYCoordinate = yCoordinate;

      ScreenPoint screenPoint =
          ScreenPoint(x: _lastXCoordinate!, y: _lastYCoordinate!);

      Point? screenPoints = await controller.getPoint(screenPoint);

      try {
        _userPolyLinesLatLngList.add(screenPoints!);
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
        setState(() {
          mapObjects.add(mapObject);
        });
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
      //TODO add polygon here
      final mapobjectPolyGon = PolygonMapObject(
        strokeWidth: 3,
        strokeColor: Colors.blue,
        fillColor: Colors.blue[100]!,
        mapId: mapObjectId,
        polygon: Polygon(
            outerRing: LinearRing(points: _userPolyLinesLatLngList),
            innerRings: []),
      );

      setState(() {
        mapObjects.add(mapobjectPolyGon);
      });
      setState(() {
        _clearDrawing = true;
      });
    }
  }

  _clearPolygons() {
    setState(() {
      _userPolyLinesLatLngList.clear();
      mapObjects.clear();
    });
  }
}
