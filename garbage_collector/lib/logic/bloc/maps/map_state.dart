import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsState extends Equatable {
  final LatLng myLocation;
  final bool loading, gpsEnabled;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final Map<PolygonId, Polygon> polygons;
  MapsState(
      {this.myLocation,
      this.loading,
      this.gpsEnabled,
      this.markers,
      this.polylines,
      this.polygons});

  static MapsState get initialState => MapsState(
        loading: true,
        markers: Map(),
        gpsEnabled: Platform.isIOS,
        polylines: Map(),
        polygons: Map(),
      );

  MapsState copyWith({
    LatLng cmyLocation,
    bool cloading,
    Map<MarkerId, Marker> cmarkers,
    bool cgpsEnable,
    Map<PolylineId, Polyline> cpolylines,
    Map<PolygonId, Polygon> cpolygons,
  }) =>
      MapsState(
        myLocation: cmyLocation ?? this.myLocation,
        loading: cloading ?? this.loading,
        markers: cmarkers ?? this.markers,
        gpsEnabled: cgpsEnable ?? this.gpsEnabled,
        polygons: cpolygons ?? this.polygons,
        polylines: cpolylines ?? this.polylines,
      );
  @override
  List<Object> get props => [
        myLocation,
        loading,
        markers,
        gpsEnabled,
        polylines,
        polygons,
      ];
}
