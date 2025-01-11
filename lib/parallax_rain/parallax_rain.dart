part of 'package:background_animated/background_animated.dart';

class ParallaxRain extends StatefulWidget {
  const ParallaxRain({
    super.key,
    this.numberOfDrops = 200,
    this.dropFallSpeed = 1,
    this.numberOfLayers = 3,
    this.dropHeight = 20,
    this.dropWidth = 5,
    this.dropColors = const [Colors.greenAccent],
    this.trailStartFraction = 0.3,
    this.distanceBetweenLayers = 1,
    this.child,
    this.rainIsInBackground = true,
    this.trail = false,
    this.alignment = Alignment.center,
    this.degrees = 0,
    this.shape = const CircleBorder(side: BorderSide()),
    this.fillShape = false,
  })  : assert(numberOfLayers >= 1, "The minimum number of layers is 1"),
        assert(dropColors.length >= 1, "The drop colors list cannot be empty"),
        assert(distanceBetweenLayers > 0,
            "The distance between layers cannot be 0, try setting the number of layers to 1 instead");

  /// Number of drops on screen at any moment
  final int numberOfDrops;

  /// Speed at which a drop falls in the vertical direction per frame
  final double dropFallSpeed;

  /// Number of layers for the parallax effect
  final int numberOfLayers;

  /// Height of each drop, the smaller from width and height is used as the limit for the drop size
  final double dropHeight;

  /// Width of each drop, the smaller from width and height is used as the limit for the drop size
  final double dropWidth;

  /// Color of each drop
  final List<Color> dropColors;

  /// Fraction of the drop at which the trail effect begins, value ranges from 0.0 to 1.0
  final double trailStartFraction;

  /// Whether the drops have a trail or not, it is visible only when shape is filled
  final bool trail;

  /// Distance between each layer
  final double distanceBetweenLayers;

  /// Whether the rain should be painted behind or in front of the child widget
  final bool rainIsInBackground;

  /// The child widget alignment
  final AlignmentGeometry? alignment;

  /// The child widget to display in the rain
  final Widget? child;

  /// The degrees to rotate the rain by
  final double degrees;

  /// The shape that btw needs a BorderSide() otherwise it will not be visible due to BorderSide.none
  final OutlinedBorder shape;

  /// Whether the shape should be filled or not
  final bool fillShape;

  @override
  State<StatefulWidget> createState() => ParallaxRainState();
}

class ParallaxRainState extends State<ParallaxRain> {
  final ValueNotifier notifier = ValueNotifier(false);
  late final ParallaxRainPainter parallaxRainPainter;

  runAnimation() async {
    while (true) {
      notifier.value = !notifier.value;
      await Future.delayed(Duration(microseconds: 16666));
    }
  }

  @override
  void initState() {
    super.initState();
    runAnimation();
    parallaxRainPainter = ParallaxRainPainter(
      shape: widget.shape,
      fillShape: widget.fillShape,
      degrees: widget.degrees,
      numberOfDrops: widget.numberOfDrops,
      dropFallSpeed: widget.dropFallSpeed,
      numberOfLayers: widget.numberOfLayers,
      trail: widget.trail,
      dropHeight: widget.dropHeight,
      dropWidth: widget.dropWidth,
      dropColors: widget.dropColors,
      trailStartFraction: widget.trailStartFraction,
      distanceBetweenLayers: widget.distanceBetweenLayers,
      notifier: notifier,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: (widget.rainIsInBackground) ? parallaxRainPainter : null,
        foregroundPainter:
            (widget.rainIsInBackground) ? null : parallaxRainPainter,
        child: Container(
          alignment: widget.alignment,
          child: widget.child,
        ),
      ),
    );
  }
}
