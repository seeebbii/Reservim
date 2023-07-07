import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/notifier/map.notifier.dart';

class RenderMap extends StatelessWidget {
  double? latitude;
  double? longitude;
  RenderMap({Key? key, this.latitude, this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MapNotifier>(
      builder: (ctx, notifier, child) {
        return GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
              target: LatLng(latitude ?? 0.0, longitude ?? 0.0), zoom: 5.00),
          onMapCreated: notifier.onMapCreated,
        );
      },
    );
  }
}
