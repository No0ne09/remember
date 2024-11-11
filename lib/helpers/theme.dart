import 'package:flutter/material.dart';

const lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff002536),
  surfaceTint: Color(0xff2e6480),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xff044863),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xff11242f),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xff334551),
  onSecondaryContainer: Color(0xffffffff),
  tertiary: Color(0xff002535),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xff004862),
  onTertiaryContainer: Color(0xffffffff),
  error: Color(0xff4e0002),
  onError: Color(0xffffffff),
  errorContainer: Color(0xff8c0009),
  onErrorContainer: Color(0xffffffff),
  surface: Color(0xfff9f9fc),
  onSurface: Color(0xff000000),
  onSurfaceVariant: Color(0xff1e2529),
  outline: Color(0xff3d4449),
  outlineVariant: Color(0xff3d4449),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2e3133),
  inversePrimary: Color(0xffd9efff),
  primaryFixed: Color(0xff044863),
  onPrimaryFixed: Color(0xffffffff),
  primaryFixedDim: Color(0xff003144),
  onPrimaryFixedVariant: Color(0xffffffff),
  secondaryFixed: Color(0xff334551),
  onSecondaryFixed: Color(0xffffffff),
  secondaryFixedDim: Color(0xff1c2f3a),
  onSecondaryFixedVariant: Color(0xffffffff),
  tertiaryFixed: Color(0xff004862),
  onTertiaryFixed: Color(0xffffffff),
  tertiaryFixedDim: Color(0xff003143),
  onTertiaryFixedVariant: Color(0xffffffff),
  surfaceDim: Color(0xffd9dadc),
  surfaceBright: Color(0xfff9f9fc),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff3f3f6),
  surfaceContainer: Color(0xffedeef0),
  surfaceContainerHigh: Color(0xffe7e8ea),
  surfaceContainerHighest: Color(0xffe1e2e5),
);

const darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xfff8fbff),
  surfaceTint: Color(0xff99cded),
  onPrimary: Color(0xff000000),
  primaryContainer: Color(0xff9dd1f1),
  onPrimaryContainer: Color(0xff000000),
  secondary: Color(0xfff8fbff),
  onSecondary: Color(0xff000000),
  secondaryContainer: Color(0xffbacddb),
  onSecondaryContainer: Color(0xff000000),
  tertiary: Color(0xfff8fbff),
  onTertiary: Color(0xff000000),
  tertiaryContainer: Color(0xff99d2f3),
  onTertiaryContainer: Color(0xff000000),
  error: Color(0xfffff9f9),
  onError: Color(0xff000000),
  errorContainer: Color(0xffffbab1),
  onErrorContainer: Color(0xff000000),
  surface: Color(0xff111416),
  onSurface: Color(0xffffffff),
  onSurfaceVariant: Color(0xfff8fbff),
  outline: Color(0xffc5ccd2),
  outlineVariant: Color(0xffc5ccd2),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe1e2e5),
  inversePrimary: Color(0xff002e41),
  primaryFixed: Color(0xffceebff),
  onPrimaryFixed: Color(0xff000000),
  primaryFixedDim: Color(0xff9dd1f1),
  onPrimaryFixedVariant: Color(0xff001925),
  secondaryFixed: Color(0xffd6eaf8),
  onSecondaryFixed: Color(0xff000000),
  secondaryFixedDim: Color(0xffbacddb),
  onSecondaryFixedVariant: Color(0xff051822),
  tertiaryFixed: Color(0xffccebff),
  onTertiaryFixed: Color(0xff000000),
  tertiaryFixedDim: Color(0xff99d2f3),
  onTertiaryFixedVariant: Color(0xff001924),
  surfaceDim: Color(0xff111416),
  surfaceBright: Color(0xff37393c),
  surfaceContainerLowest: Color(0xff0c0f10),
  surfaceContainerLow: Color(0xff191c1e),
  surfaceContainer: Color(0xff1d2022),
  surfaceContainerHigh: Color(0xff282a2c),
  surfaceContainerHighest: Color(0xff333537),
);

const darkMapStyle = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8ec3b9"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1a3646"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#4b6878"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#64779e"
      }
    ]
  },
  {
    "featureType": "administrative.province",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#4b6878"
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#334e87"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "all",
    "stylers": [
      {
        "color": "#283d6a"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6f9ba5"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3C7680"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#304a7d"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#98a5be"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2c6675"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#255763"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#b0d5ce"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#98a5be"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#283d6a"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3a4762"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#0e1626"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#4e6d70"
      }
    ]
  }
]''';
