part of 'package:background_animated/background_animated.dart';

class Starfield extends StatefulWidget {
  const Starfield({
    super.key,
    this.numberOfShapes = 200,
    this.speed = 1,
    this.colors = const [Colors.greenAccent],
    this.child,
    this.isInBackground = true,
    this.trail = false,
    this.alignment = Alignment.center,
    this.shape = const CircleBorder(side: BorderSide()),
    this.fillShape = false,
  }) : assert(colors.length >= 1, "The shape colors list cannot be empty");

  /// Number of shapes on screen at any moment
  final int numberOfShapes;

  /// Speed at which a shape moves per frame
  final double speed;

  /// Color of each shape
  final List<Color> colors;

  /// Whether the shapes have a trail or not
  final bool trail;

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

  @override
  State<Starfield> createState() => _StarfieldState();
}

class _StarfieldState extends State<Starfield> {
  final ValueNotifier notifier = ValueNotifier(false);
  late final StarfieldPainter starfieldPainter;

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
    starfieldPainter = StarfieldPainter(
      notifier: notifier,
      numberOfStars: widget.numberOfShapes,
      speed: widget.speed,
      trail: widget.trail,
      starColors: widget.colors,
      shape: widget.shape,
      fillShape: widget.fillShape,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: (widget.isInBackground) ? starfieldPainter : null,
        foregroundPainter: (widget.isInBackground) ? null : starfieldPainter,
        child: Container(
          alignment: widget.alignment,
          child: widget.child,
        ),
      ),
    );
  }
}
