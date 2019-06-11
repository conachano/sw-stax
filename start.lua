-- Game: Summoners War
-- Version: 0.1
-- Author: will3ms

-- Options
wins = 0
lost = 0
fullscreen = Region(0, 0, 2960, 1440)
activityPos = Region()

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
	fullscreen:highlightOff()
	setHighlightTextStyle(0x4d000000,0xf8ffffff, 12)
	fullscreen:highlight(act)
	setHighlightStyle(0x8ffff00, false)
end

-- Click on random spot of the image
function clickImage()
	if getLastMatch() ~= nil then
		local lastmatch = getLastMatch()
		local coords = { ["x"] = lastmatch:getX(), ["y"] = lastmatch:getY(), ["w"] = lastmatch:getW(), ["h"] = lastmatch:getH() }
		local loc = Location(coords["x"] + math.random(coords["w"]), coords["y"] + math.random(coords["h"]))
		click(loc)
	end
end

-- Click on random spot of the screen
function clickScreen()
	local loc = Location(fullscreen:getX() + math.random(fullscreen:getW()), fullscreen:getY() + math.random(fullscreen:getH()))
	click(loc)
end

-- Check if can start battle
function startBattle()
	if (imageExists(Pattern("startBattle.png"):similar(0.7))) then
		changeActivity("Started battle")
		wait(math.random(3, 15))
		clickImage()
	end
end

-- Check if you can get loot
function endBattle()
	if (imageExists(Pattern("victory.png"))) then
		changeActivity("Victory!")
		wait(math.random(3, 8))
		clickScreen()

		local reward = imageExists(Pattern("battleReward.png"))

		if reward then
			changeActivity("Opening chest...")
			wait(math.random(0.3, 2))
			clickImage()

			if (imageExists(Pattern("getButton.png"):similar(0.7))) or (imageExists(Pattern("okButton.png"):similar(0.7))) then
				wait(math.random(2, 10))
				clickImage()
			end
		end

		if (imageExists(Pattern("replayBattle.png"):similar(0.7))) or (imageExists(Pattern("prepareBattle.png"):similar(0.7))) then
			changeActivity("Clicking replay...")
			wait(math.random(0.3, 5))
			clickImage()
		end
	elseif (imageExists(Pattern("defeated.png"))) then
		changeActivity("Defeated!")
		wait(math.random(3, 8))
		clickScreen()

		if (imageExists(Pattern("noButton.png"):similar(0.7))) then
			wait(math.random(0.3, 5))
			clickImage()
		end

		if (imageExists(Pattern("replayBattle.png"):similar(0.7))) or (imageExists(Pattern("prepareBattle.png"):similar(0.7))) then
			wait(math.random(0.3, 5))
			clickImage()
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