import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/extensions.dart';

class KMLMakers {

  static const double kml1Latitude = 12.9720;
  static const double kml1Longitude = 77.6002;
  static const String kml1Name = "Red PlaceMarker";


  static const double kml2Latitude = 12.9765;
  static const double kml2Longitude = 77.6050;
  static const String kml2Name = "Triangle Area";

  static screenOverlayImage(String imageUrl, double factor) =>
      '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"
     xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document id="logo">
    <ScreenOverlay>
      <name>Logo</name>
      <Icon>
        <href>$imageUrl</href>
      </Icon>
      <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
      <screenXY x="0.025" y="0.95" xunits="fraction" yunits="fraction"/>
      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <size x="300" y="${300 * factor}" xunits="pixels" yunits="pixels"/>
    </ScreenOverlay>
  </Document>
</kml>''';

  static String lookAtLinear(
      double latitude, double longitude, double zoom, double tilt, double bearing) =>
      '<LookAt>'
          '<longitude>$longitude</longitude>'
          '<latitude>$latitude</latitude>'
          '<range>$zoom</range>'
          '<tilt>$tilt</tilt>'
          '<heading>$bearing</heading>'
          '<gx:altitudeMode>relativeToGround</gx:altitudeMode>'
          '</LookAt>';

  static String orbitLookAtLinear(
      double latitude, double longitude, double zoom, double tilt, double bearing) =>
      '<gx:duration>5.0</gx:duration>'
          '<gx:flyToMode>smooth</gx:flyToMode>'
          '<LookAt>'
          '<longitude>$longitude</longitude>'
          '<latitude>$latitude</latitude>'
          '<range>$zoom</range>'
          '<tilt>$tilt</tilt>'
          '<heading>$bearing</heading>'
          '<gx:altitudeMode>relativeToGround</gx:altitudeMode>'
          '</LookAt>';

  static String lookAt(CameraPosition camera, bool scaleZoom) => '''<LookAt>
  <longitude>${camera.target.longitude}</longitude>
  <latitude>${camera.target.latitude}</latitude>
  <range>${scaleZoom ? camera.zoom.zoomLG : camera.zoom}</range>
  <tilt>${camera.tilt}</tilt>
  <heading>${camera.bearing}</heading>
  <gx:altitudeMode>relativeToGround</gx:altitudeMode>
</LookAt>''';


  static String createKML1() => '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>Red Placemark</name>

    <Style id="largePinStyle">
      <IconStyle>
        <color>ff0000ff</color>
        <scale>4.0</scale>
        <Icon>
          <href>http://maps.google.com/mapfiles/kml/paddle/red-circle.png</href>
        </Icon>
      </IconStyle>
      <LabelStyle>
        <color>ffffffff</color>
        <scale>2.0</scale>
      </LabelStyle>
    </Style>

    <Placemark>
      <name>$kml1Name</name>
      <description>Large Red Pin Marker - Very Visible</description>
      <styleUrl>#largePinStyle</styleUrl>
      <Point>
        <coordinates>$kml1Longitude,$kml1Latitude,0</coordinates>
      </Point>
    </Placemark>

  </Document>
</kml>''';


  static String createKML2() => '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>Yellow Triangle</name>

    <Style id="yellowTriangle">
      <LineStyle>
        <color>ff00ffff</color>
        <width>5</width>
      </LineStyle>
      <PolyStyle>
        <color>7f00ffff</color>
        <fill>1</fill>
        <outline>1</outline>
      </PolyStyle>
    </Style>

    <Placemark>
      <name>$kml2Name</name>
      <description>Yellow Triangle Marker - Visible</description>
      <styleUrl>#yellowTriangle</styleUrl>

      <Polygon>
        <extrude>1</extrude>
        <altitudeMode>relativeToGround</altitudeMode>
        <outerBoundaryIs>
          <LinearRing>
            <coordinates>
              $kml2Longitude,$kml2Latitude,50
              ${kml2Longitude + 0.001},${kml2Latitude - 0.0015},50
              ${kml2Longitude - 0.001},${kml2Latitude - 0.0015},50
              $kml2Longitude,$kml2Latitude,50
            </coordinates>
          </LinearRing>
        </outerBoundaryIs>
      </Polygon>
    </Placemark>

  </Document>
</kml>''';
}
