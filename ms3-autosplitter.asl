state("mslug3") {
  byte yPos : 0x000F0D24, 0x528;
  byte gameState : "libcocos2d.dll", 0x001672FC, 0x18, 0x0C;
  int level1PhaseState: 0xF1E7C;
  int level1BossState: 0xFAE48;
  int level2BossState: 0xF22C8;
  int level3PhaseState: 0xF0E6C;
  int level3BossState: 0xF8EB0;
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
  int LEVEL3_UNDER_WATER = 342403584;
  int LEVEL3_BOARD_WALK = 308340765;
  int LEVEL3_BOSS = 291554718;
  int LEVEL3_BOSS_IS_ALIVE = 305194592;

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
  Func<int, bool> finishedLevel1OvergroundSplit = level1PhaseState => level1PhaseState != LEVEL1_OVERGROUND;
  Func<int, bool> finishedLevel1UndergroundSplit = level1PhaseState => level1PhaseState != LEVEL1_UNDERGROUND;
  Func<int, bool> isInLevel1BossSplit = level1PhaseState => level1PhaseState == LEVEL1_BOSS;
  Func<int, bool> isLevel1BossDead = level1BossState => level1BossState != LEVEL1_BOSS_IS_ALIVE;
  Func<int, bool> isLevel2BossInSecondPhase = level2BossState => level2BossState == LEVEL2_BOSS_IN_SECOND_PHASE;
  Func<int, bool> isInLevel3UnderWater = level3PhaseState => level3PhaseState == LEVEL3_UNDER_WATER;
  Func<int, bool> finishedLevel3UnderWater = level3PhaseState => level3PhaseState != LEVEL3_UNDER_WATER;
  Func<int, bool> finishedLevel3BoardWalk = level3PhaseState => level3PhaseState != LEVEL3_BOARD_WALK;
  Func<int, bool> isInLevel3BossSplit = level3PhaseState => level3PhaseState == LEVEL3_BOSS;
  Func<int, bool> isLevel3BossDead = level3BossState => level3BossState != LEVEL3_BOSS_IS_ALIVE;

  vars.finishedLevel1OvergroundSplit = finishedLevel1OvergroundSplit;
  vars.finishedLevel1UndergroundSplit = finishedLevel1UndergroundSplit;
  vars.isLevel1BossDead = isLevel1BossDead;
  vars.isInLevel1BossSplit = isInLevel1BossSplit;
  vars.isLevel2BossInSecondPhase = isLevel2BossInSecondPhase;
  vars.isInLevel3UnderWater = isInLevel3UnderWater;
  vars.finishedLevel3UnderWater = finishedLevel3UnderWater;
  vars.finishedLevel3BoardWalk = finishedLevel3BoardWalk;
  vars.isInLevel3BossSplit = isInLevel3BossSplit;
  vars.isLevel3BossDead = isLevel3BossDead;

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
      shouldSplit = vars.finishedLevel1OvergroundSplit(current.level1PhaseState);
      break;
    case 2:
      shouldSplit = vars.finishedLevel1UndergroundSplit(current.level1PhaseState);
      break;
    case 3:
      shouldSplit = vars.isInLevel1BossSplit(current.level1PhaseState) && vars.isLevel1BossDead(current.level1BossState);
      break;
    case 4:
      if(vars.isLevel2BossInSecondPhase(current.level2BossState)) vars.split++;
      break;
    case 5:
      shouldSplit = !vars.isLevel2BossInSecondPhase(current.level2BossState);
      break;
    case 6:
      if(vars.isInLevel3UnderWater(current.level3PhaseState)) vars.split++;
      break;
    case 7:
      shouldSplit = vars.finishedLevel3UnderWater(current.level3PhaseState);
      break;
    case 8:
      shouldSplit = vars.finishedLevel3BoardWalk(current.level3PhaseState);
      break;
    case 9:
      shouldSplit = vars.isInLevel3BossSplit(current.level3PhaseState) && vars.isLevel3BossDead(current.level3BossState);
      break;
  }

  if (shouldSplit) vars.split++;

  return shouldSplit;
}

