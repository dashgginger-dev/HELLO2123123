local GameManager = {}
GameManager.currentDay = 1
GameManager.maxDays = 100
GameManager.isNight = false
GameManager.dayDuration = 120 -- 2 minutes in seconds
GameManager.nightDuration = 60 -- 1 minute in seconds
GameManager.playerHealth = 100
GameManager.maxHealth = 100
GameManager.gameActive = true

function GameManager:startGame()
	print("Game Started! Survive for 100 days!")
	self:startDayNightCycle()
end

function GameManager:startDayNightCycle()
	while self.gameActive and self.currentDay <= self.maxDays do
		self:runDay()
		if not self.gameActive then break end
		self:runNight()
		if self.gameActive then
			self.currentDay = self.currentDay + 1
		end
	end
	
	if self.currentDay > self.maxDays then
		self:winGame()
	end
end

function GameManager:runDay()
	self.isNight = false
	print("Day " .. self.currentDay .. " - Stay safe!")
	wait(self.dayDuration)
end

function GameManager:runNight()
	self.isNight = true
	print("Night " .. self.currentDay .. " - Evil Pikachu is coming!")
	wait(self.nightDuration)
	print("Night " .. self.currentDay .. " - Survived!")
end

function GameManager:takeDamage(amount)
	self.playerHealth = self.playerHealth - amount
	print("Player Health: " .. self.playerHealth .. "/" .. self.maxHealth)
	
	if self.playerHealth <= 0 then
		self:gameOver()
	end
end

function GameManager:gameOver()
	self.gameActive = false
	print("Game Over! You survived " .. self.currentDay - 1 .. " days")
end

function GameManager:winGame()
	self.gameActive = false
	print("Victory! You survived all 100 days!")
end

function GameManager:getGameStatus()
	return {
		down = self.currentDay,
		isNight = self.isNight,
		health = self.playerHealth,
		maxHealth = self.maxHealth,
		daysRemaining = self.maxDays - self.currentDay + 1
	}
end

return GameManager