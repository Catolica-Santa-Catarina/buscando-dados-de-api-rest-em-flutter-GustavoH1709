import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? Latitude = 0;
  double? Longitude = 0;

  //Location(double? latitude, double? longitude) {
  //  Latitude = latitude ?? 0;
  //  Longitude = longitude ?? 0;
  //}

  set setLatitute(double? value) {
    Latitude = value;
  }

  get getLatitute {
    return Latitude;
  }

  set setLongitude(double? value) {
    Longitude = value;
  }

  get getLongitude {
    return Longitude;
  }

  Future<void> getCurrentLocation() async {
    await checkLocationPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    Latitude = position.latitude;
    Longitude = position.longitude;

    print('position: ' + position.toString());
  }

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // serviço de localização desabilitado. Não será possível continuar
      return Future.error('O serviço de localização está desabilitado.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Sem permissão para acessar a localização
        return Future.error('Sem permissão para acesso à localização');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // permissões negadas para sempre
      return Future.error('A permissão para acesso a localização foi negada para sempre. Não é possível pedir permissão.');
    }
  }
}

