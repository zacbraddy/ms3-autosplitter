state("mslug3") {
  byte yPos : 0x000F0D24, 0x528
}

startup {
  Func<int, bool> isAtFirstSplit = (splitNo) => splitNo == 0;
  Func<byte, bool> characterHasLandedInWaterOnFirstMission = (yPos) => yPos == 96;
  Func<int, byte, bool> startSplitting = (splitNo, yPos) => isAtFirstSplit(splitNo) && characterHasLandedInWaterOnFirstMission(yPos);

  vars.startSplitting = startSplitting;

  vars.split = 0;
}

init {
  vars.split = 0;
}

start {
  if (vars.startSplitting(vars.split, current.yPos)) {
    vars.split++;
    return true;
  }
}

