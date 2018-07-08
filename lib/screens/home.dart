import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wheel_of_choice/animation/spinner.dart';
import 'package:wheel_of_choice/components/needle.dart';
import 'package:wheel_of_choice/components/spinning_wheel.dart';
import 'package:wheel_of_choice/components/wheel.dart';
import 'package:wheel_of_choice/components/wheel_pivot.dart';
import 'package:wheel_of_choice/data/choice.dart';
import 'package:wheel_of_choice/data/section.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Spinner _spinner;
  @override
  void initState() {
    super.initState();
    _spinner = Spinner(vsync: this, initialTurns: Random().nextDouble())
      ..listener = (status) => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wheel of Choice'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _handleEdit(context),
          )
        ],
      ),
      body: _BodyWidget(_spinner),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: _spinner.isSpinning ? null : _spinner.spin,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _handleEdit(BuildContext context) {
    Navigator.of(context).pushNamed("/settings");
  }

  @override
  void dispose() {
    _spinner.dispose();
    super.dispose();
  }
}

// Use a separate widget to be able to use Scaffold.of(context)
// This widget is stateful to clean-up the streams in the dispose() method
class _BodyWidget extends StatefulWidget {
  final Spinner spinner;

  const _BodyWidget(this.spinner);

  @override
  _BodyWidgetState createState() => new _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
  SpinningChoiceWheel wheel;

  StreamController<Choice> resultController;
  StreamSubscription<Choice> rSub;

  @override
  void initState() {
    super.initState();
    resultController = StreamController.broadcast();
  }

  @override
  Widget build(BuildContext context) {
    wheel = SpinningChoiceWheel(
      spinner: widget.spinner,
      wheel: Wheel(
        sections: convertToSections(
          ChoiceProvider.of(context),
          minimum: 5,
        ),
      ),
      resultSink: resultController.sink,
    );

    rSub?.cancel();
    rSub = resultController.stream.listen(
      (c) => Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Result: ${c.name}!"),
            ),
          ),
    );

    return LayoutBuilder(builder: (context, constraint) {
      var width = constraint.maxWidth;
      var height = constraint.maxHeight;
      var minSide = min(width, height);
      var wheelSize = minSide * 1.7;
      var bigWheel = buildBigWheel(wheelSize);

      var wheelOffset = Offset(
        -minSide / 2,
        0.0,
      );
      var needleLeft = (width + wheelSize) / 2 + wheelOffset.dx - 15;

      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Make the wheel bigger than the screen
          Transform.translate(
            offset: wheelOffset,
            child: bigWheel,
          ),
          Positioned(
            child: Needle(),
            left: needleLeft,
            width: 70.0,
            height: 30.0,
          ),
        ],
      );
    });
  }

  OverflowBox buildBigWheel(num wheelSize) {
    return OverflowBox(
      minWidth: wheelSize,
      maxWidth: wheelSize,
      minHeight: wheelSize,
      maxHeight: wheelSize,
      child: Stack(
        children: <Widget>[
          wheel,
          WheelPivot(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    rSub?.cancel();
    resultController.close();
    super.dispose();
  }
}
