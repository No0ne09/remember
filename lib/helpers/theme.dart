import 'package:flutter/material.dart';

const lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(4278199606),
  surfaceTint: Color(4281230464),
  onPrimary: Color(4294967295),
  primaryContainer: Color(4278470755),
  onPrimaryContainer: Color(4294967295),
  secondary: Color(4279313455),
  onSecondary: Color(4294967295),
  secondaryContainer: Color(4281550161),
  onSecondaryContainer: Color(4294967295),
  tertiary: Color(4278199605),
  onTertiary: Color(4294967295),
  tertiaryContainer: Color(4278208610),
  onTertiaryContainer: Color(4294967295),
  error: Color(4283301890),
  onError: Color(4294967295),
  errorContainer: Color(4287365129),
  onErrorContainer: Color(4294967295),
  surface: Color(4294572540),
  onSurface: Color(4278190080),
  onSurfaceVariant: Color(4280165673),
  outline: Color(4282205257),
  outlineVariant: Color(4282205257),
  shadow: Color(4278190080),
  scrim: Color(4278190080),
  inverseSurface: Color(4281217331),
  inversePrimary: Color(4292472831),
  primaryFixed: Color(4278470755),
  onPrimaryFixed: Color(4294967295),
  primaryFixedDim: Color(4278202692),
  onPrimaryFixedVariant: Color(4294967295),
  secondaryFixed: Color(4281550161),
  onSecondaryFixed: Color(4294967295),
  secondaryFixedDim: Color(4280037178),
  onSecondaryFixedVariant: Color(4294967295),
  tertiaryFixed: Color(4278208610),
  onTertiaryFixed: Color(4294967295),
  tertiaryFixedDim: Color(4278202691),
  onTertiaryFixedVariant: Color(4294967295),
  surfaceDim: Color(4292467420),
  surfaceBright: Color(4294572540),
  surfaceContainerLowest: Color(4294967295),
  surfaceContainerLow: Color(4294177782),
  surfaceContainer: Color(4293783280),
  surfaceContainerHigh: Color(4293388522),
  surfaceContainerHighest: Color(4292993765),
);

const darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(4294507519),
  surfaceTint: Color(4288269805),
  onPrimary: Color(4278190080),
  primaryContainer: Color(4288532977),
  onPrimaryContainer: Color(4278190080),
  secondary: Color(4294507519),
  onSecondary: Color(4278190080),
  secondaryContainer: Color(4290432475),
  onSecondaryContainer: Color(4278190080),
  tertiary: Color(4294507519),
  onTertiary: Color(4278190080),
  tertiaryContainer: Color(4288271091),
  onTertiaryContainer: Color(4278190080),
  error: Color(4294965753),
  onError: Color(4278190080),
  errorContainer: Color(4294949553),
  onErrorContainer: Color(4278190080),
  surface: Color(4279309334),
  onSurface: Color(4294967295),
  onSurfaceVariant: Color(4294507519),
  outline: Color(4291153106),
  outlineVariant: Color(4291153106),
  shadow: Color(4278190080),
  scrim: Color(4278190080),
  inverseSurface: Color(4292993765),
  inversePrimary: Color(4278201921),
  primaryFixed: Color(4291750911),
  onPrimaryFixed: Color(4278190080),
  primaryFixedDim: Color(4288532977),
  onPrimaryFixedVariant: Color(4278196517),
  secondaryFixed: Color(4292274936),
  onSecondaryFixed: Color(4278190080),
  secondaryFixedDim: Color(4290432475),
  onSecondaryFixedVariant: Color(4278523938),
  tertiaryFixed: Color(4291619839),
  onTertiaryFixed: Color(4278190080),
  tertiaryFixedDim: Color(4288271091),
  onTertiaryFixedVariant: Color(4278196516),
  surfaceDim: Color(4279309334),
  surfaceBright: Color(4281809212),
  surfaceContainerLowest: Color(4278980368),
  surfaceContainerLow: Color(4279835678),
  surfaceContainer: Color(4280098850),
  surfaceContainerHigh: Color(4280822316),
  surfaceContainerHighest: Color(4281546039),
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
