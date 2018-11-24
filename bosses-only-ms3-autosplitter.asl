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
  int isHiDoDead: 0xF3F34;
  int mission5LevelState: 0xF0DF4;
  int isTrueRootMarsDead: 0xF80C8;
}

startup {
  // Memory Flags
  vars.IN_GAME = 0x2E;
  vars.MAIN_MENU = 38;
  vars.THE_GROUND_ON_FIRST_LEVEL = 96;
  vars.MISSION1_HUGE_HERMIT_ALIVE = 356515840;
  vars.MISSION2_IN_10_COMMMANDENTS_OF_MOSSES_PHASE = 1952480779;
  vars.MISSION3_JUPITER_KING = 291554718;
  vars.MISSION3_JUPITER_KING_ALIVE = 321974931;
  vars.MISSION4_SOL_DAE_ROKKER = 308310380;
  vars.MISSION4_SOL_DAE_ROKKER_ALIVE = 325122318;
  vars.MISSION5_HI_DO_DEAD = 326118544;
  vars.MISSION5_FAKE_ROOT_MARS_CORRIDOR = 275789385;
  vars.MISSION5_IN_CLONE_BUBBLE_CORRIDOR = 359675891;
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
  if (vars.split == 0 && current.mission1PhaseState == vars.MISSION1_HUGEHERMIT && current.hugeHermitState != vars.MISSION1_HUGE_HERMIT_ALIVE) {
    vars.split++;
    return true;
  } else if (vars.split == 1 && current.tenCommandmentsOfMosesState == vars.MISSION2_IN_10_COMMMANDENTS_OF_MOSSES_PHASE) {
    vars.split++;
  } else if (vars.split == 2 && current.tenCommandmentsOfMosesState != vars.MISSION2_IN_10_COMMMANDENTS_OF_MOSSES_PHASE) {
    vars.split++;
    return true;
  } else if (vars.split == 3 && current.mission3PhaseState == vars.MISSION3_JUPITER_KING && current.jupiterKingState == vars.MISSION3_JUPITER_KING_ALIVE) {
    vars.split++;
  } else if (vars.split == 4 && current.mission3PhaseState == vars.MISSION3_JUPITER_KING && current.jupiterKingState != vars.MISSION3_JUPITER_KING_ALIVE ) {
    vars.split++;
    return true;
  } else if (vars.split == 5 && current.mission4PhaseState == vars.MISSION4_SOL_DAE_ROKKER && current.solDaeRokkerState != vars.MISSION4_SOL_DAE_ROKKER_ALIVE) {
    vars.split++;
    return true;
  } else if (vars.split == 6 && current.isHiDoDead == vars.MISSION5_HI_DO_DEAD) {
    vars.split++;
    return true;
  } else if (vars.split == 7 && current.mission5LevelState == vars.MISSION5_FAKE_ROOT_MARS_CORRIDOR) {
    vars.split++;
    return true;
  } else if (vars.split == 8 && current.mission5LevelState == vars.MISSION5_IN_TRUE_ROOT_MARS && current.isTrueRootMarsDead == vars.MISSION5_TRUE_ROOT_MARS_DEAD) {
    vars.split++;
    return true;
  }
}


