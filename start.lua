-- Game: Summoners War
-- Version: 0.1
-- Author: will3m5

-- Options
wins = 0
lost = 0
fullscreen = Region(0, 0, 2960, 1440)
activityPos = Region(math.floor(2960/3), 1440-75, 986, 75)

-- Functions
-- Check if image exists
function imageExists(pattern)
	return exists(pattern)
end

-- Check if image exists within the given time
function waitImageExists(pattern, time)
	return exists(pattern, time)
end

-- Activity overlay
function changeActivity(act)
	activityPos:highlightOff()
	setHighlightTextStyle(0x4d000000,0xf8ffffff, 12)
	activityPos:highlight(act)
	setHighlightStyle(0x8ffff00, false)
end

function clickRandom(region)
	if region ~= nil then
		if region:getLastMatch() ~= nil then
			match = region:getLastMatch()
		else
			match = region
		end
	else
		match = getLastMatch()
	end

	local location = Location(match:getX() + math.random(match:getW()), match:getY() + math.random(match:getH()))
	click(location)
end

-- Check if can start battle
function startBattle()
	if (imageExists(Pattern("startBattle.png"):similar(0.7))) then
		wait(math.random(3, 15))
		clickRandom()
		changeActivity("Battle started!")
	end
end

-- Check if you can get loot
function endBattle()
	if (imageExists(Pattern("victory.png"))) then
		changeActivity("Victory!")
		wait(math.random(3, 8))
		clickRandom(fullscreen)

		local reward = imageExists(Pattern("battleReward.png"))

		if reward then
			changeActivity("Opening chest...")
			wait(math.random(0, 2))
			clickRandom()

			if (imageExists(Pattern("getButton.png"):similar(0.7))) or (imageExists(Pattern("okButton.png"):similar(0.7))) then
				changeActivity("Getting loot...")
				wait(math.random(1, 5))
				clickRandom()
			end
		end

		if (imageExists(Pattern("replayBattle.png"):similar(0.7))) or (imageExists(Pattern("prepareBattle.png"):similar(0.7))) then
			changeActivity("Clicking replay...")
			wait(math.random(0.3, 5))
			clickRandom()
			changeActivity("In battle...")
		end
	elseif (imageExists(Pattern("defeated.png"))) then
		changeActivity("Defeated!")
		wait(math.random(3, 8))
		clickRandom(fullscreen)

		if (imageExists(Pattern("noButton.png"):similar(0.7))) then
			wait(math.random(0.3, 5))
			clickRandom()
		end

		if (imageExists(Pattern("replayBattle.png"):similar(0.7))) or (imageExists(Pattern("prepareBattle.png"):similar(0.7))) then
			changeActivity("Clicking replay...")
			wait(math.random(0.3, 5))
			clickRandom()
			changeActivity("In battle...")
		end
	end
end

-- Cairos dungeon loop
function cairosDungeon()
	while true do
		startBattle()
		endBattle()
	end
end

-- Start of the script
cairosDungeon()