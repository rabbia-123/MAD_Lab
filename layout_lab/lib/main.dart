// main.dart - Team Board lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Bibi Rabbia';
const String rollNo = '04072313042'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev', 'Data Structures', 'Operating Systems', 'Databases',
  'Networks', 'Software Eng', 'AI', 'Web Engineering', 'Graphics', 'Security',
];
const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];
const List<String> mains = [
  'start', 'center', 'end', 'spaceBetween', 'spaceAround', 'spaceEvenly',
];
const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];
const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5); // where the clock starts
final int tick = 1 + u % 3; // how much it adds every second
final int ticks = 4 + u % 4; // how many ticks until it stops
final int stopAt = startSec + ticks * tick; // the clock stops here

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3; // used by the experiment in Step 5

// Step 6: axes (the NAMES are printed on the settings card; you type the enum)
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5]; // use swatches[hue]!.shade100

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);
// ===========================================================================

// Step 2 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Team Board', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsCard(),
            const SizedBox(height: 12),
            // Add each new widget BELOW the previous one, in the order the
            // steps tell you, with a SizedBox(height: 12) between widgets.
            const Welcome(), // Step 4
            const SizedBox(height: 12),
            const Clock(), // Steps 1, 2, 3 (Clock contains the Probe)
            const SizedBox(height: 12),
            const SwapBoard(), // Step 5 (replaces the temporary Tile Row)
            const SizedBox(height: 12),
            const InfoPanel(), // Step 6
            const SizedBox(height: 12),
            const SummaryRow(), // Step 7
          ],
        ),
      ),
    );
  }
}

// ---- Provided: shows YOUR numbers. Keep it on the page. Do not rename.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC (taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}

// ---- Provided for Step 7. It overflows on purpose. Do not rename anything.
// Step 7 fix: each Text is wrapped in Expanded (the key stays on the Text).
//
// Think (Step 7): Why does Expanded make the Text wrap its words?
// A Row does not limit the width of its children, so a long Text wants one
// very long line and goes outside the screen (overflow). Expanded gives each
// child a fixed share of the width. "Constraints go down": the parent tells
// the Text "you only have this much width". "Sizes go up": the Text then
// breaks its words into many lines to fit and tells the parent its size.
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// Step 1: Clock (Timer in initState)
// ===========================================================================
class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0;

  // Think (Step 1): Why do we start the Timer in initState and not in build?
  // initState runs only ONE time, so we get only one timer.
  // build runs again and again (every setState calls it). If we started the
  // timer in build, every rebuild would start one more timer. Many timers
  // would run together, so the clock would become faster and faster.
  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);
      if (_seconds >= stopAt) timer.cancel(); // stop at your limit
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  // Think (Step 2): Why does Builds go up by one per second, not two?
  // Every second the timer calls setState one time. One setState means
  // one rebuild, so build runs one time and Builds goes up by one.
  // What if _timer.cancel() is missing in dispose?
  // The timer keeps running after the widget is gone. It calls setState on
  // a widget that is already removed, and the console shows an error like
  // "setState() called after dispose()". It also wastes memory.
  @override
  Widget build(BuildContext context) {
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session: $_seconds s', key: const Key('clock')),
        Text('Builds: $_builds', key: const Key('builds')),
        Probe(seconds: _seconds), // no const: its number changes
      ],
    );
  }
}

// ===========================================================================
// Step 3: Probe (Widget vs Element)
// ===========================================================================
// Think (Step 3): Which one is cheap and thrown away, and which keeps State?
// The Widget is cheap and thrown away. A new Widget is made on every
// rebuild, so its number changes. The Element stays alive and it keeps the
// State, so its number stays the same.
// Where is the RenderObject? It is the third part, below the Element.
// Its job is to do the real work: measure the size, set the position
// (layout) and draw the widget on the screen (paint).
class Probe extends StatelessWidget {
  final int seconds;

  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final bool above =
        context.findAncestorWidgetOfExactType<Scaffold>() != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seen at: $seconds s', key: const Key('probe-seen')),
        Text('Widget #${identityHashCode(this)}',
            key: const Key('probe-widget')),
        Text('Element #${identityHashCode(context)}',
            key: const Key('probe-element')),
        Text('Context belongs to: ${context.widget.runtimeType}',
            key: const Key('probe-context')),
        Text('Scaffold above me: $above', key: const Key('probe-above')),
      ],
    );
  }
}

// ===========================================================================
// Step 4: Welcome and Tile
// ===========================================================================
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome, $studentName', key: const Key('welcome')),
    );
  }
}

// Think (Step 4): What is this style called and why does Flutter like it?
// It is called COMPOSITION. We built Tile by putting small widgets together
// (an ElevatedButton and a Text) and we did not write "extends
// ElevatedButton". Flutter likes it because it is simple and flexible: we
// do not need a new subclass for every look, and the code is easier to
// change and reuse.
class Tile extends StatefulWidget {
  const Tile(this.label, {super.key});

  final String label;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => taps++),
      child: Text('${widget.label}: $taps'),
    );
  }
}

// ===========================================================================
// Step 5: SwapBoard (keys)
// ===========================================================================
// Think (Step 5): Without keys, why did the number stay on the left?
// Without keys Flutter matches by type and position only. After Swap, the
// new widgets have the labels in the new order, but Flutter reuses the old
// Element at each position. The count (taps) is saved in the State, and the
// State stays with the Element at the same position. So the widget (label)
// moved, but the Element and State (the number) stayed on the left.
// With ValueKey, the Element and State follow their own widget.
class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  var tiles = [
    Tile(tileA, key: ValueKey(tileA)),
    Tile(tileB, key: ValueKey(tileB)),
    Tile(tileC, key: ValueKey(tileC)),
  ];

  void swap() => setState(() => tiles = tiles.reversed.toList());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: tiles),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}

// ===========================================================================
// Step 6: InfoPanel (the two axes)
// ===========================================================================
// Think (Step 6): In a Column, which axis is the main axis?
// In a Column the main axis is vertical (up and down). The cross axis is
// the other one: horizontal (left and right). So crossAxisAlignment.center
// in a Column moves the children left or right (it centres them
// horizontally) and not up or down.
//
// Your values: row main axis = end, column cross axis = center.
class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Start: $startSec s', key: const Key('row-a')),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],
        ),
      ],
    );
  }
}