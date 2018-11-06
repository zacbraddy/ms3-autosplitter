state("mslug3") {
  byte yPos : 0x000F0D24, 0x528;
  byte gameState : "libcocos2d.dll", 0x001672FC, 0x18, 0x0C;
  int mission1PhaseState: 0xF1E7C;
  int hugeHermitState: 0xFAE48;
  int tenCommandmentsOfMosesState: 0xF22C8;
  int mission3PhaseState: 0xF0E6C;
  int jupiterKingState: 0xF1EBC; 
  int mission4PhaseState: 0xF0DAC;
  int solDaeRokkerState: 0xF20D4;
}

startup {
  vars.DONT_SPLIT = 0;
  vars.QUIET_SPLIT = 1;
  vars.SPLIT = 2;

  Func<dynamic, dynamic, Func<dynamic, dynamic, bool>, int> quietSplit = (thisOld, thisCurrent, splitFn) => {
    if (splitFn(thisOld, thisCurrent)) {
      return vars.QUIET_SPLIT;
    }

    return vars.DONT_SPLIT;
  };

  Func<dynamic, dynamic, Func<dynamic, dynamic, bool>, int> split = (thisOld, thisCurrent, splitFn) => {
    if (splitFn(thisOld, thisCurrent)) {
      return vars.SPLIT;
    }

    return vars.DONT_SPLIT;
  };

  // Memory Flags
  byte IN_GAME = 0x2E;
  byte MAIN_MENU = 38;
  byte THE_GROUND_ON_FIRST_LEVEL = 96;
  int MISSION1_BEACH = 6291456;
  int MISSION1_STORAGE = 325058560;
  int MISSION1_HUGEHERMIT = 1868562432;
  int MISSION1_HUGE_HERMIT_ALIVE = 356515840;
  int MISSION2_IN_10_COMMMANDENTS_OF_MOSSES_PHASE = 1952480779;
  int MISSION3_SCUBA = 342403584;
  int MISSION3_BOARD_WALK = 308340765;
  int MISSION3_JUPITER_KING = 291554718;
  int MISSION3_JUPITER_KING_ALIVE = 321974883;
  int MISSION4_DESERT = 325119846;
  int MISSION4_TEMPLE = 509635901;
  int MISSION4_SOL_DAE_ROKKER = 308310380;
  int MISSION4_SOL_DAE_ROKKER_ALIVE = 325122318;

  // Start Functions
  Func<byte, bool> characterHasLandedInWaterOnFirstMission = yPos => yPos == THE_GROUND_ON_FIRST_LEVEL;
  Func<byte, bool> isInGame = gameState => gameState == IN_GAME;

  Func<dynamic, dynamic, bool> startSplittingTest = 
    (thisOld, thisCurrent) => 
    isInGame(thisCurrent.gameState) // Don't start splitting if we aren't in the game
      && thisOld.yPos != THE_GROUND_ON_FIRST_LEVEL // Some of the menus for some reason register as being in game we only want to start splitting if our last position wasn't ground level, this stops the scenario where you landed on the first mission and then just quit out
      && characterHasLandedInWaterOnFirstMission(thisCurrent.yPos); // Start the split when the character hits the water

  Func<dynamic, dynamic, int> startSplitting = (thisOld, thisCurrent) => split(thisOld, thisCurrent, startSplittingTest);

  vars.isInGame = isInGame;

  // Reset/Update Functions
  Func<byte, bool> isAtMainMenu = ptr => ptr == MAIN_MENU;
  vars.isAtMainMenu = isAtMainMenu;

  // Splitting Functions
  Func<dynamic, dynamic, bool> finishedMission1BeachSplitTest = (thisOld, thisCurrent) => thisCurrent.mission1PhaseState == MISSION1_STORAGE;
  Func<dynamic, dynamic, bool> finishedMission1StorageSplitTest = (thisOld, thisCurrent) => thisCurrent.mission1PhaseState == MISSION1_HUGEHERMIT;
  Func<dynamic, dynamic, bool> isInHugeHermitSplit = (thisOld, thisCurrent) => thisCurrent.mission1PhaseState == MISSION1_HUGEHERMIT;
  Func<dynamic, dynamic, bool> isHugeHermitDead = (thisOld, thisCurrent) => thisCurrent.hugeHermitState != MISSION1_HUGE_HERMIT_ALIVE;
  Func<dynamic, dynamic, bool> finishedHugeHermitTest = (thisOld, thisCurrent) => isInHugeHermitSplit(thisOld, thisCurrent) && isHugeHermitDead(thisOld, thisCurrent);
  Func<dynamic, dynamic, bool> isIn10CommandmentsOfMosesPhaseTest = (thisOld, thisCurrent) => thisCurrent.tenCommandmentsOfMosesState == MISSION2_IN_10_COMMMANDENTS_OF_MOSSES_PHASE;
  Func<dynamic, dynamic, bool> is10CommandmentsOfMosesDeadTest = (thisOld, thisCurrent) => !isIn10CommandmentsOfMosesPhaseTest(thisOld, thisCurrent);
  Func<dynamic, dynamic, bool> isInMission3ScubaTest = (thisOld, thisCurrent) => thisCurrent.mission3PhaseState == MISSION3_SCUBA;
  Func<dynamic, dynamic, bool> finishedMission3ScubaTest = (thisOld, thisCurrent) => thisCurrent.mission3PhaseState == MISSION3_BOARD_WALK;
  Func<dynamic, dynamic, bool> finishedMission3BoardwalkTest = (thisOld, thisCurrent) => thisCurrent.mission3PhaseState == MISSION3_JUPITER_KING;
  Func<dynamic, dynamic, bool> isInJupiterKingSplit = (thisOld, thisCurrent) => thisCurrent.mission3PhaseState == MISSION3_JUPITER_KING;
  Func<dynamic, dynamic, bool> hasJupiterKingSpawnedTest = (thisOld, thisCurrent) => isInJupiterKingSplit(thisOld, thisCurrent) && thisCurrent.jupiterKingState == MISSION3_JUPITER_KING_ALIVE;
  Func<dynamic, dynamic, bool> isJupiterKingDead = (thisOld, thisCurrent) => thisCurrent.jupiterKingState != MISSION3_JUPITER_KING_ALIVE;
  Func<dynamic, dynamic, bool> finishedJupiterKingTest = (thisOld, thisCurrent) => isInJupiterKingSplit(thisOld, thisCurrent) && isJupiterKingDead(thisOld, thisCurrent);
  Func<dynamic, dynamic, bool> finishedMission4DesertTest = (thisOld, thisCurrent) => thisCurrent.mission4PhaseState == MISSION4_TEMPLE;
  Func<dynamic, dynamic, bool> finishedMission4TempleTest = (thisOld, thisCurrent) => thisCurrent.mission4PhaseState == MISSION4_SOL_DAE_ROKKER;
  Func<dynamic, dynamic, bool> isInSolDaeRokkerSplit = (thisOld, thisCurrent) => thisCurrent.mission4PhaseState == MISSION4_SOL_DAE_ROKKER;
  Func<dynamic, dynamic, bool> isSolDaeRokkerDead = (thisOld, thisCurrent) => thisCurrent.solDaeRokkerState != MISSION4_SOL_DAE_ROKKER_ALIVE;
  Func<dynamic, dynamic, bool> finishedSolDaeRokkerTest = (thisOld, thisCurrent) => isInSolDaeRokkerSplit(thisOld, thisCurrent) && isSolDaeRokkerDead(thisOld, thisCurrent);

  Func<dynamic, dynamic, int> finishedMission1BeachSplit = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedMission1BeachSplitTest);
  Func<dynamic, dynamic, int> finishedMission1StorageSplit = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedMission1StorageSplitTest);
  Func<dynamic, dynamic, int> finishedHugeHermit = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedHugeHermitTest);
  Func<dynamic, dynamic, int> isIn10CommandmentsOfMosesPhase = (thisOld, thisCurrent) => quietSplit(thisOld, thisCurrent, isIn10CommandmentsOfMosesPhaseTest);
  Func<dynamic, dynamic, int> is10CommandmentsOfMosesDead = (thisOld, thisCurrent) => split(thisOld, thisCurrent, is10CommandmentsOfMosesDeadTest);
  Func<dynamic, dynamic, int> isInMission3Scuba = (thisOld, thisCurrent) => quietSplit(thisOld, thisCurrent, isInMission3ScubaTest);
  Func<dynamic, dynamic, int> finishedMission3Scuba = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedMission3ScubaTest);
  Func<dynamic, dynamic, int> finishedMission3Boardwalk = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedMission3BoardwalkTest);
  Func<dynamic, dynamic, int> hasJupiterKingSpawned = (thisOld, thisCurrent) => quietSplit(thisOld, thisCurrent, hasJupiterKingSpawnedTest);
  Func<dynamic, dynamic, int> finishedJupiterKing = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedJupiterKingTest);
  Func<dynamic, dynamic, int> finishedMission4Desert = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedMission4DesertTest);
  Func<dynamic, dynamic, int> finishedMission4Temple = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedMission4TempleTest);
  Func<dynamic, dynamic, int> finishedSolDaeRokker = (thisOld, thisCurrent) => split(thisOld, thisCurrent, finishedSolDaeRokkerTest);

  // Function to initialise split queue ready for a new run
  Action<dynamic> initialiseSplits = thisSettings => {
    vars.splits = new Queue<Func<dynamic, dynamic, int>>();
    if (thisSettings["mission1"]) vars.splits.Enqueue(startSplitting);

    if (thisSettings["mission1_Beach"]) vars.splits.Enqueue(finishedMission1BeachSplit);
    if (thisSettings["mission1_Storage"]) vars.splits.Enqueue(finishedMission1StorageSplit);
    if (thisSettings["mission1_HugeHermit"]) vars.splits.Enqueue(finishedHugeHermit);

    if (thisSettings["mission2_10CommandmentsOfMoses"]) {
      vars.splits.Enqueue(isIn10CommandmentsOfMosesPhase);
      vars.splits.Enqueue(is10CommandmentsOfMosesDead);
    }

    if (thisSettings["mission3_Scuba"]) { 
      if(vars.splits.Count > 1) vars.splits.Enqueue(isInMission3Scuba);
      vars.splits.Enqueue(finishedMission3Scuba);
    }

    if (thisSettings["mission3_Boardwalk"]) vars.splits.Enqueue(finishedMission3Boardwalk);

    if (thisSettings["mission3_JupiterKing"]) {
      vars.splits.Enqueue(hasJupiterKingSpawned);
      vars.splits.Enqueue(finishedJupiterKing);
    }

    if (thisSettings["mission4_Desert"]) vars.splits.Enqueue(finishedMission4Desert);
    if (thisSettings["mission4_Temple"]) vars.splits.Enqueue(finishedMission4Temple);
    if (thisSettings["mission4_SolDaeRokker"]) vars.splits.Enqueue(finishedSolDaeRokker);
  };

  vars.initialiseSplits = initialiseSplits;

  // Setting specifications
  settings.Add("mission1", true, "Mission 1 - A Couple's Love Land");
  settings.Add("mission1_Beach", true, "Mission 1 - Beach", "mission1");
  settings.Add("mission1_Storage", true, "Mission 1 - Storage", "mission1");
  settings.Add("mission1_HugeHermit", true, "Mission 1 - Huge Hermit (Boss)", "mission1");

  settings.Add("mission2", true, "Mission 2 - Wandering at Midnight");
  settings.Add("mission2_10CommandmentsOfMoses", true, "Mission 2 - The Ten Commandments of Moses (Second phase of Boss)", "mission2");

  settings.Add("mission3", true, "Mission 3 - Eyes Over the Waves");
  settings.Add("mission3_Scuba", true, "Mission 3 - Scuba", "mission3");
  settings.Add("mission3_Boardwalk", true, "Mission 3 - Boardwalk", "mission3");
  settings.Add("mission3_JupiterKing", true, "Mission 3 - Jupiter King (Boss)", "mission3");

  settings.Add("mission4", true, "Mission 4 - Tombstone of Sand");
  settings.Add("mission4_Desert", true, "Mission 4 - Desert", "mission4");
  settings.Add("mission4_Temple", true, "Mission 4 - Temple", "mission4");
  settings.Add("mission4_SolDaeRokker", true, "Mission 4 - Sol Dae Rokker (Boss)", "mission4");
}

init {
  vars.initialiseSplits(settings);
}

reset {
  if (vars.isAtMainMenu(current.gameState)) {
    vars.initialiseSplits(settings);
    return true;
  }
}

start {
  // Settings don't cause a restart so this is the best way of reloading split settings without having to reload the autosplitter
  vars.initialiseSplits(settings);
  if (settings["mission1_Beach"] && vars.splits.Peek()(old, current) > vars.DONT_SPLIT) {
    vars.splits.Dequeue();
    return true;
  }
}

split {
  if (vars.splits.Count == 0) return false;

  var currentSplitAction = vars.splits.Peek()(old, current);
  if (currentSplitAction > vars.DONT_SPLIT) {
    vars.splits.Dequeue();
    if (currentSplitAction == vars.SPLIT) return true;
  }
}

