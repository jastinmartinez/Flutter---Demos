import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collector/logic/bloc/maps/map_bloc.dart';
import 'package:garbage_collector/logic/bloc/maps/map_state.dart';
import 'package:garbage_collector/logic/bloc/maps/maps_event.dart';
import 'package:garbage_collector/utils/app_color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key key}) : super(key: key);
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final _map = new MapBloc();

  @override
  void dispose() {
    _map.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _map,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: BlocBuilder<MapBloc, MapsState>(
              builder: (context, state) {
                if (state.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColor.kBlue,
                    ),
                  );
                }
                final _cameraPosition = CameraPosition(
                  zoom: 15,
                  target: state.myLocation,
                );

                return GoogleMap(
                  onMapCreated: (controller) {
                    this._map.setMapController(controller);
                  },
                  initialCameraPosition: _cameraPosition,
                  polylines: state.polylines.values.toSet(),
                  markers: state.markers.values.toSet(),
                  // polygons: state.polygons.values.toSet(),
                  trafficEnabled: true,
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onTap: (lat) {
                    context.read<MapBloc>().add(MarkerAdded(lat));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
