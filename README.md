<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

[![Pub Version](https://img.shields.io/pub/v/parallax_rain.svg?style=flat-square)](https://pub.dev/packages/background_animated)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

# Background animated
Add cool effects, with plenty of customization!

## Installation

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
    background_animated:
```


### 2. Install it

You can install packages from the command line:

```bash
$ pub get
..
```

Alternatively, your editor might support pub. Check the docs for your editor to learn more.

### 3. Import it

Now in your Flutter code, you can use:

```Dart
import 'package:background_animated/background_animated.dart';
```

## Usage

If you want to give `YourWidget` a 3D rain background, simply wrap it with the `ParallaxRain` widget, with `YourWidget` as the child parameter. You can also have the rain effect in the foreground, use multiple drop colors, adjust the speed, add trails to your drops and lots more! 

For example: 

```Dart
ParallaxRain(
    dropColors: [
        ...Colors.primaries,
        ...Colors.accents,
    ],
    child: Text(
        "Text Here",
    ),
),
```

If you want to give `YourWidget` a 3D starfield background, just wrap it with the `Starfield` widget, with `YourWidget` as the child parameter. You can also have the Starfield effect in the foreground, use multiple colors, adjust the speed, add trails to your shapes and more! 

For example: 

```Dart
Starfield(
    colors: [
        ...Colors.primaries,
        ...Colors.accents,
    ],
    child: Text(
        "Text Here",
    ),
),
```

A full example can be found in the example directory

## About me

Visit my LinkedIn at https://www.linkedin.com/in/amr-elbasuony
or 
Add me on discord via zerstoria
