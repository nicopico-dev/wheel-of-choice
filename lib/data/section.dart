import 'dart:math';
import 'dart:ui';

import 'package:wheel_of_choice/data/choice.dart';

class Section {
  final Choice choice;
  final double startAngle;
  final double sweepAngle;

  const Section(this.choice, this.startAngle, this.sweepAngle);

  double get endAngle => startAngle + sweepAngle;
  String get label => choice.name;
  Color get color => choice.color;

  @override
  String toString() => "Section {$label, $startAngle, $endAngle}";
}

Iterable<Section> convertToSections(Iterable<Choice> choices, {int minimum = 0}) {
  var paddedChoices = _padChoices(choices, minimum);

  final sweepAngle = (2 * pi) / paddedChoices.length;
  var sectionStartAngle = 0.0;
  // The map must be converted to a list, otherwise sectionStartAngle 
  // will keep incrementing after each state change!
  return paddedChoices.map((c) {
    var section = Section(c, sectionStartAngle, sweepAngle);
    sectionStartAngle = section.endAngle;
    return section;
  }).toList();
}

Iterable<Choice> _padChoices(Iterable<Choice> choices, int minCount) {
  if (choices.length >= minCount || choices.length == 0) {
    return choices;
  } else {
    return _padChoices(choices.followedBy(choices), minCount);
  }
}
