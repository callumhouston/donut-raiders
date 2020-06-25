local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
display.setStatusBar( display.HiddenStatusBar )



-- Defining Variables
numberOfHomers = 5
rowsOfHomers = 1
numberOfFlanders = 3
rowsOfFlanders = 1
numberOfBarts = 1
rowsOfBarts = 1
homersSpeed = 46.8
movingSpeed = 1000
invaderBulletSpeed = 10
gameEnded = false
invadersStopped = false
stopUsed = false
lives = 3
score = 0
bulletSpeed = 26
roundNumber = 0
alienPasses = 0
walkingSpeed = 8
alienMoving = "no"
dieing = "no"
bulletOn = "no"
invBulletOn = "no"
updated = "yes"
movingBullets = "off"

local pew = audio.loadSound( "pew.m4a" )
local homerTable = {}
local alien

leftWalkStart = "paused"
local sheetOptions =
{
  frames =
  {
    { -- 1) Music On Button
      x = 0,
      y = 0,
      width = 431,
      height = 250
    },
    { -- 2) Music Off Button
      x = 0,
      y = 250,
      width = 386,
      height = 250
    },
    { -- 3) "Raiders" Text
      x = 0,
      y = 500,
      width = 422,
      height = 64
    },
    { -- 4) "Donut" Text
      x = 0,
      y = 564,
      width = 296,
      height = 64
    },
    { -- 5) Donut Picture
      x = 0,
      y = 629,
      width = 216,
      height = 220
    },
    { -- 6) Purple Play Button
      x = 2014,
      y = 0,
      width = 866,
      height = 159,
    },
    { -- 7) Green Play Button
      x = 2014,
      y = 159,
      width = 866,
      height = 159,
    },
    { -- 8) Purple Help Button
      x = 2014,
      y = 318,
      width = 866,
      height = 158,
    },
    { -- 9) Green Help Button
      x = 2014,
      y = 477,
      width = 866,
      height = 158,
    },
    { -- 10) Purple Quit Button
      x = 2014,
      y = 636,
      width = 866,
      height = 158,
    },
    { -- 11) Green Quit Button
      x = 2014,
      y = 795,
      width = 866,
      height = 159,
    },
    { -- 12) Purple Highscores Button
      x = 2014,
      y = 954,
      width = 866,
      height = 158,
    },
    { -- 13) Green Highscores Button
      x = 2014,
      y = 1113,
      width = 866,
      height = 159,
    },
    { -- 14) Space Background
      x = 0,
      y = 848,
      width = 352,
      height = 622,
    },
    { -- 15) The Structure in the game that players walks on
      x = 2038,
      y = 1272,
      width = 841,
      height = 160,
    },
    { -- 16) Game Stop Button
      x = 238,
      y = 640,
      width = 91,
      height = 91,
    },
    { -- 17) Game Start Button
      x = 238,
      y = 736,
      width = 91,
      height = 91,
    },
    { -- 18) Wiggum Left-Walk 1
      x = 434,
      y = 0,
      width = 119,
      height = 191,
    },
    { -- 19 Wiggum Left-Walk 2
      x = 555,
      y = 0,
      width = 119,
      height = 191,
    },
    { -- 20) Wiggum Left-Walk 3
      x = 676,
      y = 0,
      width = 119,
      height = 191,
    },
    { -- 21) Wiggum Left-Stand
      x = 797,
      y = 0,
      width = 119,
      height = 191,
    },
    { -- 22) Wiggum Right-Stand
      x = 919,
      y = 0,
      width = 119,
      height = 191,
    },
    { -- 23) Wiggum Right-Walk 1
      x = 1040,
      y = 0,
      width = 119,
      height = 191,
    },
    { -- 24) Wiggum Right-Walk 2
      x = 1161,
      y = 0,
      width = 119,
      height = 191,
    },
    { -- 25) Wiggum Right-Walk 3
      x = 1283,
      y = 0,
      width = 119,
      height = 191,
    },
    { -- 26) Golden Donut
      x = 340,
      y = 629,
      width = 216,
      height = 220,
    },
    { -- 27) Mini Homer Bullet
      x = 1423,
      y = 24,
      width = 67,
      height = 157,
    },
    { -- 28) Red Laser Bullet
      x = 1505,
      y = 33,
      width = 39,
      height = 142,
    },
    { -- 29) Big Homie
      x = 1569,
      y = 21,
      width = 129,
      height = 163,
    },
    { -- 30) Flanders
      x = 1699,
      y = 18,
      width = 136,
      height = 168,
    },
    { -- 31) Alien Boy
      x = 1850,
      y = 23,
      width = 131,
      height = 160,
    },
    { -- 32) Bart
      x = 414,
      y = 209,
      width = 138,
      height = 197,
    },
    { -- 33) Stop sign
      x = 574,
      y = 220,
      width = 169,
      height = 169,
    }
  },
}

local leftSequenceData = {
  { name = "leftWalk", frames = {18,19,20,19}, time = 1000, loopCount = 0},
}

local rightSequenceData = {
  { name = "rightWalk", frames = {23,24,25,24}, time = 1000, loopCount = 0}
}

local spriteSheet = graphics.newImageSheet( "spriteSheet.png", sheetOptions )

local leftWalk = display.newSprite( spriteSheet, leftSequenceData, 1000, 1000 )
leftWalk.x = display.contentWidth/2
leftWalk.y = 1665
leftWalk:scale( 1.7, 1.7 )
leftWalk.isVisible = false

local leftStand = display.newImageRect( spriteSheet, 21, 119*1.7, 191*1.7)
leftStand.x = display.contentWidth/2
leftStand.y = 1665
leftStand.alpha = 0

local rightWalk = display.newSprite( spriteSheet, rightSequenceData, 1000, 1000 )
rightWalk.x = display.contentWidth/2
rightWalk.y = 1665
rightWalk:scale( 1.7, 1.7 )
rightWalk.isVisible = false

local rightStand = display.newImageRect( spriteSheet, 22, 119*1.7, 191*1.7)
rightStand.x = display.contentWidth/2
rightStand.y = 1665
rightStand.alpha = 1

local function endGame()
  gameEnded = true
  composer.setVariable( "finalScore", score )
  composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
end

local function wiggumAlphaOff()
  leftStand.alpha = 0
  rightStand.alpha = 0
  rightWalk.isVisible = false
  leftWalk.isVisible = false
end

local function wiggumAlphaOn()
  leftStand.alpha = 1
end

local function notDieing()
  dieing = "no"
end

local function died()
  dieing = "yes"
  lives = lives - 1
  wiggumAlphaOff()
  leftWalk.x = display.contentCenterX
  leftStand.x = display.contentCenterX
  rightWalk.x = display.contentCenterX
  rightStand.x = display.contentCenterX
  timer.performWithDelay( 100, wiggumAlphaOn )
  timer.performWithDelay( 200, wiggumAlphaOff )
  timer.performWithDelay( 300, wiggumAlphaOn )
  timer.performWithDelay( 400, wiggumAlphaOff )
  timer.performWithDelay( 500, wiggumAlphaOn )
  timer.performWithDelay( 550, notDieing)
end

local function checkLives()
  if lives > 0 then
    donutLife1.alpha = 1
  else
    donutLife1.alpha = 0
    endGame()
  end
  if lives > 1 then
    donutLife2.alpha = 1
  else
    donutLife2.alpha = 0
  end
  if lives > 2 then
    donutLife3.alpha = 1
  else
    donutLife3.alpha = 0
  end
  if lives > 3 then
    goldenLife.alpha = 1
  else
    goldenLife.alpha = 0
  end
end

local function createInvader()
  homerPos = (display.contentWidth - 200*(numberOfHomers-1))/2
  invadersHeight = 300
  for i = 1, rowsOfHomers do
    for j = 1, numberOfHomers do
        local newHomer = display.newImageRect( spriteSheet, 29, 129, 163 )
        newHomer.x = homerPos
        newHomer.y = invadersHeight
        table.insert( homerTable, newHomer )
        homerPos = homerPos + 200
    end
    invadersHeight = invadersHeight + 220
    homerPos = (display.contentWidth - 200*(numberOfHomers-1))/2
  end
  flandersPos = (display.contentWidth - 200*(numberOfFlanders-1))/2
  for i = 1, rowsOfFlanders do
    for j = 1, numberOfFlanders do
      local newFlanders = display.newImageRect( spriteSheet, 30, 136, 168 )
      newFlanders.x = flandersPos
      newFlanders.y = invadersHeight
      table.insert( homerTable, newFlanders )
      flandersPos = flandersPos + 200
    end
    invadersHeight = invadersHeight + 220
    flandersPos = (display.contentWidth - 200*(numberOfFlanders-1))/2
  end
  bartPos = (display.contentWidth - 200*(numberOfBarts-1))/2
  for i = 1, rowsOfBarts do
    for j = 1, numberOfBarts do
      local newBart = display.newImageRect( spriteSheet, 32, 138, 197 )
      newBart.x = bartPos
      newBart.y = invadersHeight
      table.insert( homerTable, newBart )
      bartPos = bartPos + 200
    end
    invadersHeight = invadersHeight + 220
    bartPos = (display.contentWidth - 200*(numberOfBarts-1))/2
  end
end

local function newRound()
  if numberOfHomers < 7 then
    numberOfHomers = numberOfHomers + 2
  end
  if numberOfFlanders < 7 then
    numberOfFlanders = numberOfFlanders + 2
  end
  if numberOfBarts < 7 then
    numberOfBarts = numberOfBarts + 2
  end
  roundNumber = roundNumber + 1
  createInvader()
end

local function moveInvaders()
  if invadersStopped == false then
    numba = #homerTable
    if changeDirection == true then
      homersSpeed = homersSpeed *-1
      for i = 1, numba do
        homerTable[i].y = homerTable[i].y + 50
      end
      changeDirection = false;
    else
      for i = 1, numba do
        homerTable[i].x = homerTable[i].x + homersSpeed
        if homerTable[i].x > 1471.5 or homerTable[i].x < 64.5 then
          changeDirection = true
        end
      end
    end
    if numba > (numberOfHomers*rowsOfHomers*0.75) then
      movingSpeed = 1000*(0.9^roundNumber)
      if movingSpeed < 40 then
        movingSpeed = 40
      end
    elseif numba > (numberOfHomers*rowsOfHomers*0.5) then
      movingSpeed = 700*(0.9^roundNumber)
      if movingSpeed < 40 then
        movingSpeed = 40
      end
    elseif numba > (numberOfHomers*rowsOfHomers*0.25) then
      movingSpeed = 400*(0.9^roundNumber)
      if movingSpeed < 40 then
        movingSpeed = 40
      end
    else
      movingSpeed = 200*(0.9^roundNumber)
      if movingSpeed < 40 then
        movingSpeed = 40
      end
    end
    if gameEnded == false then
      timer.performWithDelay( movingSpeed, moveInvaders )
    end
  end
end

local function moveAlien()
  if invadersStopped == false then
    if alien.x < -85 then
      display.remove(alien)
      alienMoving = "no"
    end
    if alienMoving == "yes" then
      alien.x = alien.x - 5
      timer.performWithDelay(10, moveAlien)
    end
  end
end

local function sane()
  walkingSpeed = 8
  bulletSpeed = 26
end
local function superSane()
  if lives > 3 then
    walkingSpeed = 32
    lives = 3
    bulletSpeed = 104
  end
  timer.performWithDelay(5000, sane)
end

local function alienPass()
  alienPasses = alienPasses + 1
  alien = display.newImageRect( spriteSheet, 31, 169.776, 207.36 )
  alien.x = display.contentWidth + 84.888
  alien.y = 120
  alienMoving = "yes"
  moveAlien()
end

local function checkCollision()
  for i=1, #homerTable do
    if bulletOn == "yes" then
      if bullet.x - 14.5 < homerTable[i].x + 64.5 and bullet.x + 14.5 > homerTable[i].x - 64.5 and bullet.y - 45 < homerTable[i].y + 81.5 and bullet.y + 45 > homerTable[i].y - 81.5  then
        Runtime:removeEventListener("enterFrame", checkCollision)
        updated = "no"
        display.remove(homerTable[i])
        table.remove(homerTable, i)
        display.remove(bullet)
        score = score + 50
        display.remove(scoreText)
        scoreText = display.newText(score, display.contentWidth/2, 1963, "ARCADE.TTF", 200)
        bulletOn = "no"
        for i=1,10 do
          if score/i == 1000 then
            alienPass()
          end
        end
      end
    end
  end
  if alienMoving == "yes" and bulletOn == "yes" then
    if alien.x - 85 < bullet.x + 14.5 and alien.x + 85 > bullet.x - 14.5 and bullet.y < 205 then
      display.remove(alien)
      display.remove(bullet)
      bulletOn = "no"
      alienMoving = "no"
      lives = lives + 1
    end
  end
  if #homerTable == 0 then
    newRound()
  end
end

local function checkInvaderPos()
  numbor = #homerTable
  for i=1, numbor do
    if homerTable[i].y > 1746.5 then
      lives = 0
    end
  end
end

local function moveBullet()
  if gameEnded == false then
    if bulletOn == "yes" then
      if bullet.y > 0 then
        bullet.y = bullet.y - bulletSpeed
        timer.performWithDelay( 1, moveBullet )
      else
        display.remove(bullet)
        bulletOn = "no"
        Runtime:removeEventListener("enterFrame", checkCollision)
      end
    end
  end
end

local function removeInvaderBullet(i)
  display.remove(invaderBullet)
  invBulletOn = "no"
  movingBullets = "off"
end

local function moveInvaderBullet()
  if gameEnded == false then
    if invBulletOn == "yes" then
      if invaderBullet.y > 1700 and dieing ~= "yes" and invaderBullet.x - 13.5 < leftStand.x + 150 and invaderBullet.x + 13.5 > leftStand.x - 162.35 then
        died()
      end
      if invaderBullet.y < 1794.5 then
        invaderBullet.y = invaderBullet.y + 13
      else
        removeInvaderBullet(i)
      end
      timer.performWithDelay( invaderBulletSpeed, moveInvaderBullet )
    end
  end
end

local function invaderShoot()
  if invadersStopped == false then
    if invBulletOn == "no" then
      local whoShoot = math.random(1, numba)
      if homerTable[whoShoot] ~= nil then
        invaderBullet = display.newImageRect( spriteSheet, 27, 67, 157 )
        invaderBullet.x = homerTable[whoShoot].x
        invaderBullet.y = homerTable[whoShoot].y
        invBulletOn = "yes"
        if movingBullets == "off" then
          movingBullets = "on"
          moveInvaderBullet()
        end
      end
    end
    if gameEnded == false then
      timer.performWithDelay( 300, invaderShoot )
    end
  end
end

local function wiggumShoot()
  if bulletOn == "no" then
    bullet = display.newImageRect( spriteSheet, 28, 26, 90)
    bullet.x = leftWalk.x
    bullet.y = 1460
    audio.play(laserSound)
    Runtime:addEventListener("enterFrame", checkCollision)
    bulletOn = "yes"
    audio.play( pew )
    moveBullet()
  end
end

local function walkingLeft()
  if leftArrow == "down" and leftWalk.x > 0 then
    leftWalk.x = leftWalk.x - walkingSpeed
    leftStand.x = leftStand.x - walkingSpeed
    rightWalk.x = rightWalk.x - walkingSpeed
    rightStand.x = rightStand.x - walkingSpeed
    timer.performWithDelay( 1, walkingLeft )
  end
end

local function walkingRight()
  if rightArrow == "down" and rightWalk.x < 1536 then
    leftWalk.x = leftWalk.x + walkingSpeed
    leftStand.x = leftStand.x + walkingSpeed
    rightWalk.x = rightWalk.x + walkingSpeed
    rightStand.x = rightStand.x + walkingSpeed
    timer.performWithDelay( 1, walkingRight )
  end
end

local function walkToLeft()
  if rightArrow ~= "down" then
    leftStand.alpha = 0
    rightStand.alpha = 0
    leftWalk.isVisible = true
    leftWalk:play()
    if leftArrow ~= "down" then
      leftArrow = "down"
      walkingLeft()
    end
  end
end

local function walkToRight()
  if leftArrow ~= "down" then
    rightStand.alpha = 0
    leftStand.alpha = 0
    rightWalk.isVisible = true
    rightWalk:play()
    if rightArrow ~= "down" then
      rightArrow = "down"
      walkingRight()
    end
  end
end

local function stopWalkToLeft()
  if rightArrow ~= "down" and rightStand.alpha ~= 1 then
    leftStand.alpha = 1
    leftWalk.isVisible = false
    leftWalk:pause()
    leftArrow = "up"
  end
end

local function stopWalkToRight()
  if leftArrow ~= "down" and leftStand.alpha ~= 1 then
    rightStand.alpha = 1
    rightWalk.isVisible = false
    rightWalk:pause()
    rightArrow = "up"
  end
end

local function musicPausePressed()
  audio.resume(loop)
  pauseButton.alpha = 0
  musicButton.alpha = 1
  music = "on"
  print("Music On")
end

local function musicPlayPressed()
  audio.pause(loop)
  musicButton.alpha = 0
  pauseButton.alpha = 1
  music = "off"
  print("Music Off")
end

local function continueInvaders()
  invadersStopped = false
  moveInvaders()
  if alienMoving == "yes" then
    moveAlien()
  end
end

local function stopInvaders()
  invadersStopped = true
  stopUsed = true
  display.remove(stopInvadersButton)
  timer.performWithDelay( 5000, continueInvaders )
end

local function keyPressed(event)
    if event.keyName == "m" and event.phase == "up" then
      if music == "on" then
        musicPlayPressed()
      else
        musicPausePressed()
      end
    end
    if event.keyName == "left" and event.phase == "down" then
      walkToLeft()
    end
    if event.keyName == "left" and event.phase == "up" then
      stopWalkToLeft()
    end
    if event.keyName == "right" and event.phase == "down" then
      walkToRight()
    end
    if event.keyName == "right" and event.phase == "up" then
      stopWalkToRight()
    end
    if event.keyName == "space" and event.phase == "up" then
      wiggumShoot()
    end
    if event.keyName == "e" and event.phase == "down" then
      superSane()
    end
    if event.keyName == "s" and event.phase == "down" and stopUsed == false then
      stopInvaders()
    end
    return false
end

-- create()
function scene:create( event )

    local sceneGroup = self.view

    createInvader()
    timer.performWithDelay( 5000, invaderShoot )

    background = display.newImageRect( spriteSheet, 14, display.contentWidth, display.contentHeight )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background.width = display.contentWidth
    background.height = display.contentHeight
    sceneGroup:insert(background)

    stopInvadersButton = display.newImageRect( spriteSheet, 33, 110, 110)
    stopInvadersButton.x = 282.96
    stopInvadersButton.y = 1945
    sceneGroup:insert(stopInvadersButton)

    musicButton = display.newImageRect( spriteSheet, 1, 133, 100 )
    musicButton.x = 118
    musicButton.y = 1945
    sceneGroup:insert(musicButton)

    pauseButton = display.newImageRect( spriteSheet, 2, 119, 100 )
    pauseButton.x = 113
    pauseButton.y = 1945
    sceneGroup:insert(pauseButton)

    if music == "on" then
      pauseButton.alpha = 0
    else
      musicButton.alpha = 0
    end

    donutLife1 = display.newImageRect( spriteSheet, 5, 120, 120)
    donutLife1.x = 1220
    donutLife1.y = 1945
    sceneGroup:insert(donutLife1)

    donutLife2 = display.newImageRect( spriteSheet, 5, 120, 120)
    donutLife2.x = 1290
    donutLife2.y = 1945
    sceneGroup:insert(donutLife2)

    donutLife3 = display.newImageRect( spriteSheet, 5, 120, 120)
    donutLife3.x = 1360
    donutLife3.y = 1945
    sceneGroup:insert(donutLife3)

    goldenLife = display.newImageRect( spriteSheet, 26, 120, 120 )
    goldenLife.x = 1430
    goldenLife.y = 1945
    sceneGroup:insert(goldenLife)

    platform = display.newImageRect( spriteSheet, 15, 1536, 220)
    platform.x = display.contentCenterX
    platform.y = 1938
    sceneGroup:insert(platform)

    scoreText = display.newText(score, display.contentWidth/2, 1963, "ARCADE.TTF", 200)
    sceneGroup:insert(scoreText)
    pauseButton:addEventListener("tap", musicPausePressed)
    musicButton:addEventListener("tap", musicPlayPressed)
    Runtime:addEventListener("key", keyPressed)

    sceneGroup:insert(leftWalk)
    sceneGroup:insert(rightWalk)
    sceneGroup:insert(leftStand)
    sceneGroup:insert(rightStand)

    local function putInScene()
      for i=1, #homerTable do
        sceneGroup:insert(homerTable[i])
      end
      Runtime:removeEventListener("enterFrame", putInScene)
    end

    Runtime:addEventListener("enterFrame", checkLives)
    Runtime:addEventListener("enterFrame", putInScene)
    Runtime:addEventListener("enterFrame", checkInvaderPos)
    stopInvadersButton:addEventListener("touch", stopInvaders)
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        timer.performWithDelay( 1000, moveInvaders())
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        Runtime:removeEventListener( "key", keyPressed )
        Runtime:removeEventListener("enterFrame", checkLives)
        Runtime:removeEventListener("enterFrame", putInScene)
        Runtime:removeEventListener("enterFrame", checkInvaderPos)
        composer.removeScene("menu-screen")
    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
