import 'package:flutter/widgets.dart';
import 'package:wheel_of_choice/animation/spinner.dart';
import 'package:wheel_of_choice/components/wheel.dart';
import 'package:wheel_of_choice/data/choice.dart';

class SpinningChoiceWheel extends StatefulWidget {
  final Spinner spinner;
  final double needleAngle;
  final Wheel wheel;
  final Sink<Choice> resultSink;
  final Sink<Choice> realtimeSink;

  const SpinningChoiceWheel({
    @required this.spinner,
    @required this.wheel,
    this.resultSink,
    this.realtimeSink,
    this.needleAngle = 0.0,
  });

  @override
  SpinningChoiceWheelState createState() {
    return new SpinningChoiceWheelState();
  }
}

class SpinningChoiceWheelState extends State<SpinningChoiceWheel> {
  VoidCallback _animListener;
  AnimationStatusListener _statusListener;

  @override
  void initState() {
    super.initState();

    _animListener = _createAnimListener(widget);
    _statusListener = _createStatusListener(widget);
    _bindListeners(widget.spinner.animation);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: widget.spinner.animation,
      child: widget.wheel,
    );
  }

  @override
  void didUpdateWidget(SpinningChoiceWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _unbindListeners(oldWidget.spinner.animation);

    _animListener = _createAnimListener(widget);
    _statusListener = _createStatusListener(widget);
    _bindListeners(widget.spinner.animation);
  }

  @override
  void dispose() {
    _unbindListeners(widget.spinner.animation);
    super.dispose();
  }

  void _bindListeners(Animation animation) {
    if (_animListener != null) {
      animation.addListener(_animListener);
    }
    if (_statusListener != null) {
      animation.addStatusListener(_statusListener);
    }
  }

  void _unbindListeners(Animation animation) {
    if (_animListener != null) {
      animation.removeListener(_animListener);
    }
    if (_statusListener != null) {
      animation.removeStatusListener(_statusListener);
    }
  }
}

AnimationStatusListener _createStatusListener(SpinningChoiceWheel widget) =>
    widget.resultSink != null
        ? ((status) {
            if (status == AnimationStatus.completed) {
              var choice = widget.wheel.getChoice(
                wheelTurns: widget.spinner.animation.value,
                needleAngle: widget.needleAngle,
              );
              widget.resultSink.add(choice);
            }
          })
        : null;

VoidCallback _createAnimListener(SpinningChoiceWheel widget) =>
    widget.realtimeSink != null
        ? () {
            var choice = widget.wheel.getChoice(
              wheelTurns: widget.spinner.animation.value,
              needleAngle: widget.needleAngle,
            );
            widget.realtimeSink.add(choice);
          }
        : null;
