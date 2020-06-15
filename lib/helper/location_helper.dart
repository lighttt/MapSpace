const GOOGLE_API_KEY = "AIzaSyB87_rzA8Bb7bCD7VaOs6vxYHDL12UTW3Y";

class LocationHelper {
  static String getLocationPreviewImg({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
