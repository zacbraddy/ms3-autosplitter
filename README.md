# ms3-autosplitter
An autosplitter implementation for Metal Slug 3 for use with LiveSplit  https://github.com/LiveSplit/LiveSplit

Currently this is in development and is not ready for release.

Current functionality available:
- Start splits when the character lands on the water
- Resets splits if the timer is not completed and the player goes to the main menu
- Splits on:
  - Between the screen change after the player enters the capsule at the end of the overground section of the first level.
  - Between the screen change between the underground section of the first level and the huge hermit.
  - When the huge hermit dies
  - When the 10 commandments of moses dies
  - Between the screen change after the player enters the tunnel that leads to the boardwalk on the third level.
  - Between the screen change after the player leaves the boardwalk and enters the jupiter king.

Current functionality drawbacks:
- Current Jupiter King split is broken, need a better memory address to watch
- Not sure if this is just an autosplitter thing or not but if you have the splits in a complete state then they won't reset you have to reset them manually, the reset only works if you have a split in progress.
