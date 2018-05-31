import 'package:flutter/widgets.dart';

class RefreshOnChange extends StatefulWidget {
  final ChangeNotifier changeNotifier;
  final WidgetBuilder builder;

  const RefreshOnChange({Key key, @required this.changeNotifier, @required this.builder});

  @override
  State<StatefulWidget> createState() => _RefreshOnChangeState();
}

class _RefreshOnChangeState extends State<RefreshOnChange> {
  @override
  void initState() {
    super.initState();
    widget.changeNotifier.addListener(_refresh);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  @override
  void dispose() {
    super.dispose();
    widget.changeNotifier.removeListener(_refresh);
  }

  void _refresh() {
    setState(() {});
  }
}
