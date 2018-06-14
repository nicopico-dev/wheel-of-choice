import 'dart:math';

import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

class Spinner {
  AnimationController _controller;
  AnimationStatusListener _listener;

  Spinner({@required TickerProvider vsync, double initialTurns = 0.0}) {
    _controller = AnimationController(
      vsync: vsync,
      value: initialTurns,
      upperBound: double.infinity,
    );
  }

  Animation<double> get animation => _controller.view;
  bool get isSpinning => _controller.isAnimating;

  set listener(AnimationStatusListener listener) {
    if (_listener != null) {
      _controller.removeStatusListener(_listener);
    }
    _listener = listener;
    _controller.addStatusListener(_listener);
  }

  void spin() {
    var simulation = _SpinSimulation(_controller.value);
    _controller
      ..reset()
      ..animateWith(simulation);
  }

  void dispose() {
    _controller.dispose();
  }
}

final _random = Random();

class _SpinSimulation extends Simulation {
  Simulation _launchSimulation;
  Simulation _finishSimulation;

  double _latestLaunchSimulationTime;

  _SpinSimulation(double start, {double velocity = 2.0})
      : assert(velocity > 0) {
    var accelEnd = start + 2.0;
    var end = accelEnd + 2.0 + 1.27 * _random.nextDouble();
    _launchSimulation = GravitySimulation(velocity, start, accelEnd, 0.0);
    _finishSimulation =
        FrictionSimulation.through(accelEnd, end, velocity - .1, 0.01);
  }

  @override
  double dx(double time) {
    if (!_isLaunching(time)) {
      return _launchSimulation.dx(time);
    } else {
      return _finishSimulation.dx(_finishTime(time));
    }
  }

  @override
  bool isDone(double time) {
    return _launchSimulation.isDone(time) &&
        _finishSimulation.isDone(_finishTime(time));
  }

  @override
  double x(double time) {
    if (_isLaunching(time)) {
      return _launchSimulation.x(time);
    } else {
      return _finishSimulation.x(_finishTime(time));
    }
  }

  bool _isLaunching(double time) {
    var isLaunching = !_launchSimulation.isDone(time);
    if (isLaunching) {
      _latestLaunchSimulationTime = time;
    }
    return isLaunching;
  }

  double _finishTime(time) {
    return time - _latestLaunchSimulationTime;
  }
}
