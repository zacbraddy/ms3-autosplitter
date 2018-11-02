state("mslug3") {
  byte yPos : 0x000F0D24, 0x528;
  byte gameState : "libcocos2d.dll", 0x001672FC, 0x18, 0x0C;
  byte levelState: 0x00090B1C, 0xC0;
  int level1BossState: 0xFAE48;
}

startup {
  // Memory Flags
  byte IN_GAME = 0x2E;
  byte MAIN_MENU = 38;
  byte THE_GROUND_ON_FIRST_LEVEL = 96;
  byte LEVEL1_OVERGROUND_SPLIT_AT = 99;
  byte LEVEL1_UNDERGROUND_SPLIT_AT = 75;
  int LEVEL1_BOSS_IS_ALIVE = 356515840;

  // Start Functions
  Func<int, bool> isAtFirstSplit = (splitNo) => splitNo == 0;
  Func<byte, bool> characterHasLandedInWaterOnFirstMission = (yPos) => yPos == THE_GROUND_ON_FIRST_LEVEL;
  Func<byte, bool> isInGame = (ptr) => ptr == IN_GAME;

  Func<int, byte, byte, byte, bool> startSplitting = 
    (splitNo, oldYPos, yPos, ptr) => 
    isInGame(ptr) // Don't start splitting if we aren't in the game
      && oldYPos != THE_GROUND_ON_FIRST_LEVEL // Some of the menus for some reason register as being in game we only want to start splitting if our last position wasn't ground level, this stops the scenario where you landed on the first mission and then just quit out
      && isAtFirstSplit(splitNo) // We might meet this Y coordinate in other parts of the game so only start if we aren't already started
      && characterHasLandedInWaterOnFirstMission(yPos); // Start the split when the character hits the water

  vars.startSplitting = startSplitting;

  // Reset/Update Functions
  Func<byte, bool> isAtMainMenu = (ptr) => ptr == MAIN_MENU;
  vars.isAtMainMenu = isAtMainMenu;

  // Splitting Functions
  Func<byte, bool> isAtLevel1OvergroundSplit = (levelState) => levelState == LEVEL1_OVERGROUND_SPLIT_AT;
  Func<byte, bool> isAtLevel1UndergroundSplit = (levelState) => levelState == LEVEL1_UNDERGROUND_SPLIT_AT;
  Func<int, bool> isLevel1BossDead = (level1BossState) => level1BossState != LEVEL1_BOSS_IS_ALIVE;

  vars.isAtLevel1OvergroundSplit = isAtLevel1OvergroundSplit;
  vars.isAtLevel1UndergroundSplit = isAtLevel1UndergroundSplit;
  vars.isLevel1BossDead = isLevel1BossDead;

  // Init split marker
  vars.split = 0;
}

init {
  vars.split = 0;
}

update {
  if (vars.split > 0 && vars.isAtMainMenu(current.gameState)) {
    vars.split = 0;
    return true;
  }
}

reset {
  if (vars.isAtMainMenu(current.gameState)) {
    vars.split = 0;
    return true;
  }

  return false;
}

start {
  if (vars.startSplitting(vars.split, old.yPos, current.yPos, current.gameState)) {
    vars.split++;
    return true;
  }
}

split {
  var shouldSplit = false;
  switch ((int)vars.split) {
    case 1:
      shouldSplit = vars.isAtLevel1OvergroundSplit(current.levelState);
      break;
    case 2:
      shouldSplit = vars.isAtLevel1UndergroundSplit(current.levelState);
      break;
    case 3:
      shouldSplit = vars.isLevel1BossDead(current.level1BossState);
      break;
  }

  if (shouldSplit) vars.split++;

  return shouldSplit;
}

