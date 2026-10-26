# Flutter Lab: Study Tracker

Name: Bibi Rabbia
Roll no: 04072313042

A1: 23
A2: 6
A3: 9
A4: 17

B1: LabApp, HomePage, StudentCard and GoalBanner are Stateless. They only show the data that is given to them, and they never change on their own. Tally, Countdown and BuggyCounter are Stateful. They keep data that changes (the count, the seconds left and the clicks), so they need setState to update the screen.

B2: A Timer does not stop by itself when the widget is removed from the screen. If I do not cancel it in dispose(), it keeps running and calls setState on a widget that is already gone. This gives the error "setState() called after dispose()". It also wastes memory.

B3: These can be const: MaterialApp, HomePage, Tally, Countdown, BuggyCounter, SizedBox, EdgeInsets.all(16) and fixed texts like Text('Reset'). A const widget is made only once and reused again and again. This saves memory, and Flutter does not need to rebuild it every time.