import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collector/logic/bloc/maps/map_state.dart';
import 'package:garbage_collector/logic/bloc/maps/maps_event.dart';
import 'package:garbage_collector/utils/app_asset.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBloc extends Bloc<MapEvents, MapsState> {
  Completer<GoogleMapController> _completer = Completer();
  StreamSubscription<Position> _posistionSubscriotion;
  final Completer<Marker> _myPositionMarker = Completer();
  Polyline myRoute = Polyline(
    polylineId: PolylineId('my_route'),
    width: 5,
    color: Colors.redAccent,
  );

  Polygon myTaps = Polygon(
    polygonId: PolygonId('my_taps_polygon'),
    fillColor: Colors.redAccent,
    strokeWidth: 3,
    strokeColor: Colors.white,
  );

  MapBloc() : super(MapsState.initialState) {
    this._init();
    this._loadTruckPin();
  }

  Future<GoogleMapController> get _mapController async {
    return _completer.future;
  }

  void setMapController(GoogleMapController controller) {
    if (_completer.isCompleted) {
      _completer = Completer();
    }
    _completer.complete(controller);
  }

  _loadTruckPin() async {
    final _bytesImage = await loadAssetAsAByte(
      'assets/images/truck.png',
      height: 100,
      width: 100,
    );
    this._myPositionMarker.complete(
          Marker(
            markerId: MarkerId('my_position_marker'),
            icon: BitmapDescriptor.fromBytes(
              _bytesImage,
            ),
          ),
        );
  }

  void _init() async {
    _posistionSubscriotion = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen(
      (position) async {
        if (position != null) {
          this.add(
            LocationUpdated(
              LatLng(position.latitude, position.longitude),
            ),
          );
          (await _mapController).animateCamera(
            CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude),
            ),
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    _posistionSubscriotion?.cancel();
    return super.close();
  }

  @override
  Stream<MapsState> mapEventToState(MapEvents event) async* {
    if (event is LocationUpdated) {
      yield* _onLocationUpdated(event);
    }
    if (event is MarkerAdded) {
      yield* _onMarkedAdded(event);
    }
    if (event is GpsEnabled) {
      yield state.copyWith(cgpsEnable: event.enable);
    }
  }

  Stream<MapsState> _onLocationUpdated(LocationUpdated event) async* {
    List<LatLng> _points = List<LatLng>.from(this.myRoute.points);
    _points.add(event.location);
    this.myRoute = this.myRoute.copyWith(pointsParam: _points);
    Map<PolylineId, Polyline> polylines = Map();
    polylines[myRoute.polylineId] = myRoute;

    final markers = Map<MarkerId, Marker>.from(this.state.markers);
    final myPositionMarker = (await this._myPositionMarker.future).copyWith(
      positionParam: event.location,
    );
    markers[myPositionMarker.mapsId] = myPositionMarker;
    yield this.state.copyWith(
          cmyLocation: event.location,
          cloading: false,
          cpolylines: polylines,
          cmarkers: markers,
        );
  }

  Stream<MapsState> _onMarkedAdded(MarkerAdded event) async* {
    final assetAsByte = await loadAssetAsAByte('assets/images/truck.png',
        height: 100, width: 100);
    final icon = BitmapDescriptor.fromBytes(assetAsByte);
    final markerId = MarkerId(this.state.markers.length.toString());
    final marker = Marker(
      anchor: Offset(0.5, 0.5),
      markerId: markerId,
      position: event.location,
      icon: icon,
    );
    final newMarker = Map<MarkerId, Marker>.from(this.state.markers);
    newMarker[markerId] = marker;

    List<LatLng> points = List<LatLng>.from(this.myTaps.points);
    points.add(event.location);
    this.myTaps = this.myTaps.copyWith(pointsParam: points);
    Map<PolygonId, Polygon> polygons =
        Map<PolygonId, Polygon>.from(this.state.polygons);
    polygons[this.myTaps.polygonId] = this.myTaps;

    yield this.state.copyWith(
          cmarkers: newMarker,
          cpolygons: polygons,
        );
  }
}
