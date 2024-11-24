import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

final defaultBorderRadius = BorderRadius.circular(24);

OutlineInputBorder getTextFieldBorder({Color color = Colors.transparent}) {
  return OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(color: color),
  );
}

ButtonStyle getSmallRedButtonStyle(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return ElevatedButton.styleFrom(
    backgroundColor: scheme.error,
    foregroundColor: scheme.onError,
  );
}

BoxDecoration getBackgroundDecoration(BuildContext context,
    {fit = BoxFit.cover}) {
  return BoxDecoration(
    image: DecorationImage(
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn,
        ),
        opacity: 0.1,
        fit: fit,
        image: const Svg(
          'assets/background.svg',
          color: Colors.transparent,
        )),
  );
}

const lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff1c6586),
  surfaceTint: Color(0xff1c6586),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffc4e7ff),
  onPrimaryContainer: Color(0xff001e2c),
  secondary: Color(0xff1a6585),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffc2e8ff),
  onSecondaryContainer: Color(0xff001e2c),
  tertiary: Color(0xff276389),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffcae6ff),
  onTertiaryContainer: Color(0xff001e2f),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfff6fafe),
  onSurface: Color(0xff181c1f),
  onSurfaceVariant: Color(0xff41484d),
  outline: Color(0xff71787d),
  outlineVariant: Color(0xffc0c7cd),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2c3134),
  inversePrimary: Color(0xff90cef3),
  primaryFixed: Color(0xffc4e7ff),
  onPrimaryFixed: Color(0xff001e2c),
  primaryFixedDim: Color(0xff90cef3),
  onPrimaryFixedVariant: Color(0xff004c69),
  secondaryFixed: Color(0xffc2e8ff),
  onSecondaryFixed: Color(0xff001e2c),
  secondaryFixedDim: Color(0xff8ecff2),
  onSecondaryFixedVariant: Color(0xff004d68),
  tertiaryFixed: Color(0xffcae6ff),
  onTertiaryFixed: Color(0xff001e2f),
  tertiaryFixedDim: Color(0xff95cdf8),
  onTertiaryFixedVariant: Color(0xff004b6f),
  surfaceDim: Color(0xffd6dadf),
  surfaceBright: Color(0xfff6fafe),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff0f4f8),
  surfaceContainer: Color(0xffeaeef3),
  surfaceContainerHigh: Color(0xffe5e8ed),
  surfaceContainerHighest: Color(0xffdfe3e7),
);

const darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff90cef3),
  surfaceTint: Color(0xff90cef3),
  onPrimary: Color(0xff00344a),
  primaryContainer: Color(0xff004c69),
  onPrimaryContainer: Color(0xffc4e7ff),
  secondary: Color(0xff8ecff2),
  onSecondary: Color(0xff003548),
  secondaryContainer: Color(0xff004d68),
  onSecondaryContainer: Color(0xffc2e8ff),
  tertiary: Color(0xff95cdf8),
  onTertiary: Color(0xff00344e),
  tertiaryContainer: Color(0xff004b6f),
  onTertiaryContainer: Color(0xffcae6ff),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff0f1417),
  onSurface: Color(0xffdfe3e7),
  onSurfaceVariant: Color(0xffc0c7cd),
  outline: Color(0xff8b9297),
  outlineVariant: Color(0xff41484d),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffdfe3e7),
  inversePrimary: Color(0xff1c6586),
  primaryFixed: Color(0xffc4e7ff),
  onPrimaryFixed: Color(0xff001e2c),
  primaryFixedDim: Color(0xff90cef3),
  onPrimaryFixedVariant: Color(0xff004c69),
  secondaryFixed: Color(0xffc2e8ff),
  onSecondaryFixed: Color(0xff001e2c),
  secondaryFixedDim: Color(0xff8ecff2),
  onSecondaryFixedVariant: Color(0xff004d68),
  tertiaryFixed: Color(0xffcae6ff),
  onTertiaryFixed: Color(0xff001e2f),
  tertiaryFixedDim: Color(0xff95cdf8),
  onTertiaryFixedVariant: Color(0xff004b6f),
  surfaceDim: Color(0xff0f1417),
  surfaceBright: Color(0xff353a3d),
  surfaceContainerLowest: Color(0xff0a0f12),
  surfaceContainerLow: Color(0xff181c1f),
  surfaceContainer: Color(0xff1c2023),
  surfaceContainerHigh: Color(0xff262b2e),
  surfaceContainerHighest: Color(0xff313539),
);
final lightTheme = ThemeData(
  colorScheme: lightScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightScheme.primaryContainer,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: lightScheme.primary,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightScheme.tertiaryContainer,
    foregroundColor: lightScheme.onTertiaryContainer,
  ),
);
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkScheme.primaryContainer,
    ),
  ),
  cardTheme: CardTheme(
    color: darkScheme.surfaceContainer,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: darkScheme.primary,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkScheme.tertiaryContainer,
    foregroundColor: darkScheme.onTertiaryContainer,
  ),
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
