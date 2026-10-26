# Layout Lab: Team Board

Name: Bibi Rabbia
Roll no: 04072313042

A1: 43
A2: 7
A3: 3
A4: 66

B1: Stateless: LabApp, HomePage, SettingsCard, SummaryRow, Probe, Welcome, InfoPanel, ShareRow, InfoBox and StampStack. They only show the data that is given to them and never change on their own. Stateful: Clock, Tile and SwapBoard. They keep data that changes (the seconds and the build count in Clock, the taps in Tile, the list of tiles in SwapBoard), so they need a State object and setState to update the screen.

B2: The Widget is rebuilt on every setState. A new Widget object is made each time, so it is cheap and thrown away. The Element and the RenderObject are kept. The Element stays in the tree and holds the State. The RenderObject does the layout and painting. Probe showed this: every second the Widget number changed, but the Element number stayed the same.

B3: "Constraints go down, sizes go up" means a parent tells its child how much space it may use (constraints go down), and then the child picks its own size inside that space and reports it back to the parent (sizes go up). In Step 7, the Row did not limit the long Texts, so they overflowed. With Expanded, the Row gave each Text a fixed share of the width. The Text then wrapped its words onto several lines to fit and told the Row its size. In Step 8, the Expanded button had to fill its share, but the Flexible button could stay at its small natural size.
