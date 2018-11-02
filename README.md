# ms3-autosplitter
An autosplitter implementation for Metal Slug 3 for use with LiveSplit  https://github.com/LiveSplit/LiveSplit

Currently this is in development and is not ready for release.

Current functionality available:
- Start splits when the character lands on the water
- Resets splits if the timer is not completed and the player goes to the main menu
- Splits on:
  - Between the screen change after the player enters the capsule at the end of the overground section of the first level.
  - Between the screen change between the underground section of the first level and the first boss.
  - When the first boss dies
  - When the second boss dies

Current functionality drawbacks:
- There is no way to specify which splits you want to use you are forced to use my very granular splits in future I'd like to put in settings so you can configure which splits you want to use.
- Not sure if this is just an autosplitter thing or not but if you have the splits in a complete state then they won't reset you have to reset them manually, the reset only works if you have a split in progress.
