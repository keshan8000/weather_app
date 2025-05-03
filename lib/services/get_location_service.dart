import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationService {
  Future<String> getLocationFromCurentLocation() async {
    //get the permission from the user to access the location
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //get the current location
    Position position = await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );

    // ignore: avoid_print
    print(position.latitude);
    // ignore: avoid_print
    print(position.longitude);

    //conver the location in to list of place marks
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    //extract the city name from the place marks
    String cityName = placemarks[0].locality!;

    // ignore: avoid_print
    print(cityName);

    return cityName;
  }
}
