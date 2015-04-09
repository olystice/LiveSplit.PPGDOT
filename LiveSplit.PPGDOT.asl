state("ppg_win_steam")
{
	int roomNum : "ppg_win_steam.exe", 0x009DFDD4, 0x228, 0x58, 0xCC8;
    int gameState : "ppg_win_steam.exe", 0x009DFDD4, 0x228, 0x58, 0xD1C;
	uint bossHealth : "ppg_win_steam.exe", 0x009DFDD4, 0x228, 0x58, 0xC58;
}

start
{
	if (current.roomNum == 0 && old.gameState == 10 && current.gameState == 9)
	{
		current.PhaseOne = false;
		return true;
	}
}

split
{
	var segment = timer.CurrentSplit.Name.ToLower();
	if (current.roomNum == 45 && current.bossHealth > 2000000000 && (old.bossHealth > 0 && old.bossHealth < 2000000000))
		return true;
	
	if (current.roomNum == 99 && current.bossHealth > 2000000000 && (old.bossHealth > 0 && old.bossHealth < 2000000000) && (segment == "blue" || segment.Contains("bubbles")))
		return true;
	
	if (current.roomNum == 71 && current.bossHealth > 2000000000 && (old.bossHealth > 0 && old.bossHealth < 2000000000) && segment.Contains("mayo"))
		return true;

	if (current.roomNum == 95 && current.PhaseOne && current.bossHealth > 2000000000 && old.bossHealth < 2000000000)
		return true;
		
	if (current.roomNum == 95 && current.bossHealth > 2000000000 && old.bossHealth < 2000000000)
		current.PhaseOne = true;
}

reset
{
	bool saveGlitch = current.roomNum == 34 || current.roomNum == 74 || current.roomNum == 45 || current.roomNum == 85;
	return current.gameState < 9 && !saveGlitch;
}

isLoading
{
	return false;
}

gameTime
{
}