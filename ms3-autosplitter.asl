state("mslug3") {
  byte yPos : 0x000F0D24, 0x528;
  byte gameState : "libcocos2d.dll", 0x001672FC, 0x18, 0x0C;
  int levelState: 0xF1E7C;
  int level1BossState: 0xFAE48;
  int level2BossState: 0xF22C8;
}

startup {
  // Memory Flags
  byte IN_GAME = 0x2E;
  byte MAIN_MENU = 38;
  byte THE_GROUND_ON_FIRST_LEVEL = 96;
  int LEVEL1_OVERGROUND = 6291456;
  int LEVEL1_UNDERGROUND = 325058560;
  int LEVEL1_BOSS = 1868562432;
  int LEVEL1_BOSS_IS_ALIVE = 356515840;
  int LEVEL2_BOSS_IN_SECOND_PHASE = 1952480779;

  // Start Functions
  Func<int, bool> isAtFirstSplit = splitNo => splitNo == 0;
  Func<byte, bool> characterHasLandedInWaterOnFirstMission = yPos => yPos == THE_GROUND_ON_FIRST_LEVEL;
  Func<byte, bool> isInGame = ptr => ptr == IN_GAME;

  Func<int, byte, byte, byte, bool> startSplitting = 
    (splitNo, oldYPos, yPos, ptr) => 
    isInGame(ptr) // Don't start splitting if we aren't in the game
      && oldYPos != THE_GROUND_ON_FIRST_LEVEL // Some of the menus for some reason register as being in game we only want to start splitting if our last position wasn't ground level, this stops the scenario where you landed on the first mission and then just quit out
      && isAtFirstSplit(splitNo) // We might meet this Y coordinate in other parts of the game so only start if we aren't already started
      && characterHasLandedInWaterOnFirstMission(yPos); // Start the split when the character hits the water

  vars.startSplitting = startSplitting;

  // Reset/Update Functions
  Func<byte, bool> isAtMainMenu = ptr => ptr == MAIN_MENU;
  vars.isAtMainMenu = isAtMainMenu;

  // Splitting Functions
  Func<int, bool> finishedLevel1OvergroundSplit = levelState => levelState != LEVEL1_OVERGROUND;
  Func<int, bool> finishedLevel1UndergroundSplit = levelState => levelState != LEVEL1_UNDERGROUND;
  Func<int, bool> isInLevel1BossSplit = levelState => levelState == LEVEL1_BOSS;
  Func<int, bool> isLevel1BossDead = level1BossState => level1BossState != LEVEL1_BOSS_IS_ALIVE;
  Func<int, bool> isLevel2BossInSecondPhase = level2BossState => level2BossState == LEVEL2_BOSS_IN_SECOND_PHASE;

  vars.finishedLevel1OvergroundSplit = finishedLevel1OvergroundSplit;
  vars.finishedLevel1UndergroundSplit = finishedLevel1UndergroundSplit;
  vars.isLevel1BossDead = isLevel1BossDead;
  vars.isInLevel1BossSplit = isInLevel1BossSplit;
  vars.isLevel2BossInSecondPhase = isLevel2BossInSecondPhase;

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
      shouldSplit = vars.finishedLevel1OvergroundSplit(current.levelState);
      break;
    case 2:
      shouldSplit = vars.finishedLevel1UndergroundSplit(current.levelState);
      break;
    case 3:
      shouldSplit = vars.isInLevel1BossSplit(current.levelState) && vars.isLevel1BossDead(current.level1BossState);
      break;
    case 4:
      if(vars.isLevel2BossInSecondPhase(current.level2BossState)) vars.split++;
      break;
    case 5:
      shouldSplit = !vars.isLevel2BossInSecondPhase(current.level2BossState);
      break;
  }

  if (shouldSplit) vars.split++;

  return shouldSplit;
}

