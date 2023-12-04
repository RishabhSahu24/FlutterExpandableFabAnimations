import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterExpandableFabAnimations());
}

class FlutterExpandableFabAnimations extends StatelessWidget {
  const FlutterExpandableFabAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AnimatedButtons());
  }
}

/// Widget that contains the animated buttons
class AnimatedButtons extends StatefulWidget {
  const AnimatedButtons({Key? key}) : super(key: key);

  @override
  State<AnimatedButtons> createState() => _AnimatedButtonsState();
}

/// State class for AnimatedButtons widget
class _AnimatedButtonsState extends State<AnimatedButtons>
    with SingleTickerProviderStateMixin {
  /// Flag to control the animation state
  bool play = false;

  /// Initial size of the containers
  double? containerSize = 60;

  int duration = 400;

  void playAnimation() {
    setState(() {
      play = !play;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        title: const Text('Expandable Fab Animations'),
      ),
      body: Center(
        child: SizedBox(
          height: containerSize! * 3,
          width: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              /// Left Container
              AnimatedPositioned(
                left: play
                    ? MediaQuery.of(context).size.width / 2 - containerSize! * 2
                    : MediaQuery.of(context).size.width / 2 -
                        containerSize! / 2,
                curve: play ? Curves.elasticOut : Curves.elasticIn,
                duration: Duration(milliseconds: duration),
                child: AnimatedRotationContainer(
                  play: play,
                  containerSize: containerSize,
                  iconData: Icons.water_drop_outlined,
                  backgroundColor: const Color(0xff2B84D2),
                ),
              ),

              /// Right Container
              AnimatedPositioned(
                right: play
                    ? MediaQuery.of(context).size.width / 2 - containerSize! * 2
                    : MediaQuery.of(context).size.width / 2 -
                        containerSize! / 2,
                curve: play ? Curves.elasticOut : Curves.elasticIn,
                duration: Duration(milliseconds: duration),
                child: AnimatedRotationContainer(
                  play: play,
                  containerSize: containerSize,
                  iconData: Icons.sports_gymnastics,
                  backgroundColor: const Color(0xff2B84D2),
                ),
              ),

              /// Top-Right Container
              AnimatedPositioned(
                top: play ? containerSize! * 0.75 : containerSize! * 2,
                right: play
                    ? MediaQuery.of(context).size.width / 2 -
                        containerSize! * 1.25
                    : MediaQuery.of(context).size.width / 2 -
                        containerSize! / 2,
                curve: play ? Curves.elasticOut : Curves.elasticIn,
                duration: Duration(milliseconds: duration),
                child: AnimatedRotationContainer(
                  play: play,
                  containerSize: containerSize,
                  iconData: Icons.thermostat,
                  backgroundColor: const Color(0xff299B3B),
                ),
              ),

              /// Top-Left Container
              AnimatedPositioned(
                top: play ? containerSize! * 0.75 : containerSize! * 2,
                left: play
                    ? MediaQuery.of(context).size.width / 2 -
                        containerSize! * 1.25
                    : MediaQuery.of(context).size.width / 2 -
                        containerSize! / 2,
                curve: play ? Curves.elasticOut : Curves.elasticIn,
                duration: Duration(milliseconds: duration),
                child: AnimatedRotationContainer(
                  play: play,
                  containerSize: containerSize,
                  iconData: Icons.coffee,
                  backgroundColor: const Color(0xffDF981A),
                ),
              ),

              ///
              /// Button that triggers the animation
              ///
              Transform.rotate(
                angle: play ? pi / 4 : 0,
                child: InkWell(
                  onTap: playAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    height: containerSize,
                    width: containerSize,
                    child: Center(
                      child: Icon(
                        Icons.add_outlined,
                        size: containerSize! * 0.9,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for a rotating container with an icon
class AnimatedRotationContainer extends StatelessWidget {
  const AnimatedRotationContainer({
    super.key,
    required this.play,
    required this.containerSize,
    required this.iconData,
    this.backgroundColor,
    this.duration,
    this.onTapButton,
  });

  /// Flag to determine whether the rotation animation should play or not
  final bool play;

  /// IconData representing the icon to be displayed in the container
  final IconData iconData;

  /// Size of the container; nullable to allow for automatic sizing if not provided
  final double? containerSize;

  /// Background color of the container; nullable for default color if not provided
  final Color? backgroundColor;

  /// Duration of the rotation animation; nullable for default duration if not provided
  final int? duration;

  /// Callback function triggered when the container is tapped
  final VoidCallback? onTapButton;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: play ? 0 : 2,
      duration: Duration(milliseconds: duration ?? 400),
      child: InkWell(
        onTap: onTapButton,
        child: Container(
          height: containerSize ?? 50,
          width: containerSize ?? 50,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              iconData,
              size: containerSize! * 0.6,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
