state("mslug3") {
  byte yPos : 0x000F0D24, 0x528;
  byte gameState : "libcocos2d.dll", 0x001672FC, 0x18, 0x0C;
  int mission1PhaseState: 0xF1E7C;
  int hugeHermitState: 0xFAE48;
  int tenCommandmentsOfMosesState: 0xF22C8;
  int mission3PhaseState: 0xF0E6C;
  int jupiterKingState: 0xF1EB8; 
  int mission4PhaseState: 0xF0DAC;
  int solDaeRokkerState: 0xF20D4;
  int isInOneilPhaseState: 0xF2DA4;
  byte isOneilDead: 0xF2F45;
  int isHiDoDead: 0xF3F34;
  int isRugnameDead: 0xFC53C;
  int mission5LevelState: 0xF0DF4;
  int isCloneBubbleDead: 0xF0DC8;
  int isTrueRootMarsDead: 0xF80C8;
}

startup {
  // Memory Flags
  vars.IN_GAME = 0x2E;
  vars.MAIN_MENU = 38;
  vars.THE_GROUND_ON_FIRST_LEVEL = 96;
  vars.MISSION1_BEACH = 6291456; // Not used in the script but can in the future if you want it this is used in mission1LeveStae
  vars.MISSION1_STORAGE = 325058560;
  vars.MISSION1_HUGEHERMIT = 1868562432;
  vars.MISSION1_HUGE_HERMIT_ALIVE = 356515840;
  vars.MISSION2_IN_10_COMMMANDENTS_OF_MOSSES_PHASE = 1952480779;
  vars.MISSION3_SCUBA = 342403584;
  vars.MISSION3_BOARD_WALK = 308340765;
  vars.MISSION3_JUPITER_KING = 291554718;
  vars.MISSION3_JUPITER_KING_ALIVE = 321974931;
  vars.MISSION4_DESERT = 325119846; // Again not used but it's the level state if future developers need it
  vars.MISSION4_TEMPLE = 509635901;
  vars.MISSION4_SOL_DAE_ROKKER = 308310380;
  vars.MISSION4_SOL_DAE_ROKKER_ALIVE = 325122318;
  vars.MISSION5_ONEIL = 393226953;
  vars.MISSION5_ONEIL_DEAD = 0xFF;
  vars.MISSION5_HI_DO_DEAD = 326118544;
  vars.MISSION5_RUGNAME_CHUTE = 275788071;
  vars.MISSION5_SAVE_MORDEN = 275788183;
  vars.MISSION5_FAKE_ROOT_MARS_CORRIDOR = 275789385;
  vars.MISSION5_IN_FAKE_ROOT_MARS = 493893209; // Also not used but can be if needed
  vars.MISSION5_IN_CLONE_BUBBLE_CORRIDOR = 359675891;
  vars.MISSION5_CLONE_BUBBLE_DEAD = 292567903;
  vars.MISSION5_IN_CLONE_BUBBLE = 274726912;
  vars.MISSION5_IN_TRUE_ROOT_MARS = 292568862;
  vars.MISSION5_TRUE_ROOT_MARS_DEAD = 339738624;

  vars.split = 0;
}

reset {
  if (current.gameState == vars.MAIN_MENU) {
    vars.split = 0;
    return true;
  }
}

start {
  // Settings don't cause a restart so this is the best way of reloading split settings without having to reload the autosplitter
  if (current.gameState == vars.IN_GAME
      && old.yPos != vars.THE_GROUND_ON_FIRST_LEVEL // Some of the menus for some reason register as being in game we only want to start splitting if our last position wasn't ground level, this stops the scenario where you landed on the first mission and then just quit out
      && current.yPos == vars.THE_GROUND_ON_FIRST_LEVEL) {
    vars.split = 0;
    return true;
  }
}

split {
  if (vars.split == 0 && current.mission1PhaseState == vars.MISSION1_STORAGE) {
    vars.split++;
    return true;
  } else if (vars.split == 1 && current.mission1PhaseState == vars.MISSION1_HUGEHERMIT) {
    vars.split++;
    return true;
  } else if (vars.split == 2 && current.mission1PhaseState == vars.MISSION1_HUGEHERMIT && current.hugeHermitState != vars.MISSION1_HUGE_HERMIT_ALIVE) {
    vars.split++;
    return true;
  } else if (vars.split == 3 && current.tenCommandmentsOfMosesState == vars.MISSION2_IN_10_COMMMANDENTS_OF_MOSSES_PHASE) {
    vars.split++;
  } else if (vars.split == 4 && current.tenCommandmentsOfMosesState != vars.MISSION2_IN_10_COMMMANDENTS_OF_MOSSES_PHASE) {
    vars.split++;
    return true;
  } else if (vars.split == 5 && current.mission3PhaseState == vars.MISSION3_SCUBA) {
    vars.split++;
  } else if (vars.split == 6 && current.mission3PhaseState == vars.MISSION3_BOARD_WALK) {
    vars.split++;
    return true;
  } else if (vars.split == 7 && current.mission3PhaseState == vars.MISSION3_JUPITER_KING) {
    vars.split++;
    return true;
  } else if (vars.split == 8 && current.mission3PhaseState == vars.MISSION3_JUPITER_KING && current.jupiterKingState == vars.MISSION3_JUPITER_KING_ALIVE) {
    vars.split++;
  } else if (vars.split == 9 && current.mission3PhaseState == vars.MISSION3_JUPITER_KING && current.jupiterKingState != vars.MISSION3_JUPITER_KING_ALIVE ) {
    vars.split++;
    return true;
  } else if (vars.split == 10 && current.mission4PhaseState == vars.MISSION4_TEMPLE) {
    vars.split++;
    return true;
  } else if (vars.split == 11 && current.mission4PhaseState == vars.MISSION4_SOL_DAE_ROKKER) {
    vars.split++;
    return true;
  } else if (vars.split == 12 && current.mission4PhaseState == vars.MISSION4_SOL_DAE_ROKKER && current.solDaeRokkerState != vars.MISSION4_SOL_DAE_ROKKER_ALIVE) {
    vars.split++;
    return true;
  } else if (vars.split == 13 && current.isInOneilPhaseState == vars.MISSION5_ONEIL) {
    vars.split++;
    return true;
  } else if (vars.split == 14 && current.isOneilDead == vars.MISSION5_ONEIL_DEAD) {
    vars.split++;
    return true;
  } else if (vars.split == 15 && current.isHiDoDead == vars.MISSION5_HI_DO_DEAD) {
    vars.split++;
    return true;
  } else if (vars.split == 16 && current.mission5LevelState == vars.MISSION5_RUGNAME_CHUTE) {
    vars.split++;
    return true;
  } else if (vars.split == 17 && current.mission5LevelState == vars.MISSION5_SAVE_MORDEN) {
    vars.split++;
    return true;
  } else if (vars.split == 18 && current.mission5LevelState == vars.MISSION5_FAKE_ROOT_MARS_CORRIDOR) {
    vars.split++;
    return true;
  } else if (vars.split == 17 && current.mission5LevelState == vars.MISSION5_IN_CLONE_BUBBLE_CORRIDOR) {
    vars.split++;
    return true;
  } else if (vars.split == 18 && current.mission5LevelState == vars.MISSION5_IN_CLONE_BUBBLE && current.isCloneBubbleDead == vars.MISSION5_CLONE_BUBBLE_DEAD) {
    vars.split++;
    return true;
  } else if (vars.split == 19 && current.mission5LevelState == vars.MISSION5_IN_TRUE_ROOT_MARS && current.isTrueRootMarsDead == vars.MISSION5_TRUE_ROOT_MARS_DEAD) {
    vars.split++;
    return true;
  }
}

