import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvents {}

class LocationUpdated extends MapEvents {
  final LatLng location;

  LocationUpdated(this.location);
}

class MarkerAdded extends MapEvents {
  final LatLng location;

  MarkerAdded(this.location);
}

class GpsEnabled extends MapEvents {
  final bool enable;

  GpsEnabled(this.enable);
}
