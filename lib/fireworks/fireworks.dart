part of 'package:background_animated/background_animated.dart';

class Fireworks extends StatefulWidget {
  const Fireworks({
    super.key,
    this.height = 20,
    this.width = 10,
    this.numberOfFireworks = 10,
    this.shapeColors = const [Colors.greenAccent],
    this.child,
    this.isInBackground = true,
    this.alignment = Alignment.center,
    this.shape = const CircleBorder(side: BorderSide()),
    this.fillShape = false,
    this.particleShape = const StarBorder(side: BorderSide()),
    this.fillParticleShape = false,
    this.particleWidth = 20,
    this.particleHeight = 10,
    this.numberOfParticles = 20,
    this.particleColors = const [Colors.amberAccent],
  })  : assert(
            shapeColors.length >= 1, "The shape colors list cannot be empty"),
        assert(particleColors.length >= 1,
            "The particle colors list cannot be empty");

  /// Color of each shape
  final List<Color> shapeColors;

  /// Whether the animation should be painted behind or in front of the child widget
  final bool isInBackground;

  /// The child widget alignment
  final AlignmentGeometry? alignment;

  /// The child widget to display in the animation
  final Widget? child;

  /// The shape that btw needs a BorderSide() otherwise it will not be visible due to BorderSide.none
  final OutlinedBorder shape;

  /// Whether the shape should be filled or not
  final bool fillShape;

  /// Width of the shape, the smaller from width and height is used as the limit for the size
  final double width;

  /// Height of the shape, the smaller from width and height is used as the limit for the size
  final double height;

  /// Number of fireworks on screen at any time
  final int numberOfFireworks;

  /// The particle shape that btw needs a BorderSide() otherwise it will not be visible due to BorderSide.none
  final OutlinedBorder particleShape;

  /// Whether the particle shape should be filled or not
  final bool fillParticleShape;

  /// Width of the particle, the smaller from width and height is used as the limit for the size
  final double particleWidth;

  /// Height of the particle, the smaller from width and height is used as the limit for the size
  final double particleHeight;

  /// Number of particles per firework
  final int numberOfParticles;

  /// Color of each firework's particle
  final List<Color> particleColors;

  @override
  State<Fireworks> createState() => _FireworksState();
}

class _FireworksState extends State<Fireworks> {
  final ValueNotifier notifier = ValueNotifier(false);
  late final FireworksPainter endlessTilingPainter;

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
    endlessTilingPainter = FireworksPainter(
      numberOfFireworks: widget.numberOfFireworks,
      notifier: notifier,
      colors: widget.shapeColors,
      shape: widget.shape,
      width: widget.width,
      fillShape: widget.fillShape,
      height: widget.height,
      particleShape: widget.particleShape,
      fillParticleShape: widget.fillParticleShape,
      particleWidth: widget.particleWidth,
      particleHeight: widget.particleHeight,
      numberOfParticles: widget.numberOfParticles,
      particleColors: widget.particleColors,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: (widget.isInBackground) ? endlessTilingPainter : null,
        foregroundPainter:
            (widget.isInBackground) ? null : endlessTilingPainter,
        child: Container(
          alignment: widget.alignment,
          child: widget.child,
        ),
      ),
    );
  }
}
