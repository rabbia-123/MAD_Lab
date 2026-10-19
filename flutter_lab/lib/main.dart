// main.dart - Study Tracker lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Bibi Rabbia';
const String rollNo = '04072313042'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u]; // your course name
final int startCount = 3 + u; // where the tally starts
final int stepSize = 1 + t % 4; // how much + and - change the tally
final int maxCount = 20 + 2 * t; // the tally may never go above this
final int startSeconds = 5 + (t + u) % 6; // where the countdown starts
final int bugStep = 1 + u % 4; // used by BuggyCounter in Step 7
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
// Stateless: it only builds the MaterialApp and holds no changing data.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Study Tracker', home: HomePage());
  }
}

// Think: runApp receives the root widget of the whole app (LabApp),
// while MaterialApp receives as home only the first screen (HomePage).
// Stateless: the page only arranges other widgets and never changes itself.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Think: widget tree (LabApp > MaterialApp > HomePage > Scaffold >
    // SingleChildScrollView > Column > Row > Text('Max: ..')). Counting
    // from LabApp, the Text('Max: ..') is 7 levels deep.
    return Scaffold(
      appBar: AppBar(title: Text('Study Tracker: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(name: studentName, roll: rollNo, course: course),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('info-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),
            const SizedBox(height: 12),
            const Tally(),
            const SizedBox(height: 12),
            const Countdown(),
            const SizedBox(height: 12),
            const BuggyCounter(),
          ],
        ),
      ),
    );
  }
}

// Think: The fields of a StatelessWidget are final because a widget is
// immutable: if the data must change, Flutter creates a new widget. Without
// final, the analyzer/compiler complains that the fields of an @immutable
// class must be final.
// Stateless: name, roll and course are only inputs and never change.
class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;

  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}

// Think: GoalBanner does not need setState because it is a StatelessWidget:
// it only displays the count and max given to it. To make it show a new
// count, the parent State (Tally) must call setState so Flutter rebuilds
// GoalBanner with a new count value.
// Stateless: count and max come from the parent, it remembers nothing.
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  const GoalBanner({super.key, required this.count, required this.max});

  @override
  Widget build(BuildContext context) {
    final int percent = count * 100 ~/ max;
    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

// Think: Tally is split into two classes because a widget is the immutable
// configuration (like a blueprint) and the State is the mutable memory that
// holds the changing count. State survives rebuilds, while the widget itself
// can be recreated at any time by its parent.
// Stateful: the count changes when the user taps the buttons.
class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

// Think: With hot reload while the count is 12, it stays 12, because hot
// reload only injects the new widget code and keeps the State object alive.
// A hot restart throws away the State and starts the app again, so a new
// State is created and the count goes back to startCount.
class _TallyState extends State<Tally> {
  int _count = startCount;

  void _plus() {
    setState(() {
      _count += stepSize;
      if (_count > maxCount) _count = maxCount;
    });
  }

  void _minus() {
    setState(() {
      _count -= stepSize;
      if (_count < 0) _count = 0;
    });
  }

  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        GoalBanner(count: _count, max: maxCount),
        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// Think: If _timer.cancel() is deleted from dispose and the widget is
// removed, the timer keeps running and calls setState on a State that is
// already disposed. The console shows the error
// "setState() called after dispose()".
// Stateful: the seconds left and the build count change every second.
class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

// Think: It increases by one per second and not by two because each tick
// calls setState exactly once, and one setState causes exactly one build.
// initState runs only once. To prove that dispose ran, lifecycleLog can be
// printed, for example with debugPrint(lifecycleLog.toString()) in main or
// inside dispose.
class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;
  int _builds = 0;

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState');
    _left = startSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _left--);
      if (_left <= 0) timer.cancel(); // stop at zero
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _left > 0
            ? Text('Time left: $_left s', key: const Key('time-left'))
            : const Text('Time is up!', key: Key('time-left')),
        Text('Builds: $_builds', key: const Key('builds')),
      ],
    );
  }
}

// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
// Think: Before the fix, after 3 taps _clicks inside the State was
// 3 * bugStep = 9, but the screen still showed 0, because without setState
// Flutter never called build again.
// Stateful: _clicks changes on every tap and must be shown on the screen.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            setState(() {
              _clicks += bugStep;
            });
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}
