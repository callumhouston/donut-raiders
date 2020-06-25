local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

local gameMusicButton
local gamePauseButton
local playButtonP
local playButtonG
local highscoresButtonG
local highscoresButtonP
local helpButtonG
local helpButtonP
local quitButtonG
local quitButtonP

local function playButtonPPress()
  playButtonG.alpha = 1
  helpButtonG.alpha = 0
  highscoresButtonG.alpha = 0
  quitButtonG.alpha = 0
  buttonOn = "play"
end

local function helpButtonPPress()
  playButtonG.alpha = 0
  helpButtonG.alpha = 1
  highscoresButtonG.alpha = 0
  quitButtonG.alpha = 0
  buttonOn = "help"
end

local function quitButtonPPress()
  playButtonG.alpha = 0
  helpButtonG.alpha = 0
  highscoresButtonG.alpha = 0
  quitButtonG.alpha = 1
  buttonOn = "quit"
end

local function highscoresButtonPPress()
  playButtonG.alpha = 0
  helpButtonG.alpha = 0
  highscoresButtonG.alpha = 1
  quitButtonG.alpha = 0
  buttonOn = "highscores"
end

local function playButtonGPress()
  composer.gotoScene("game",{effect = "fade", time = 3000})
end

local function quitButtonGPress()
  if system.getInfo("platformName")=="Android" then
    native.requestExit()
  else os.exit()
  end
end

local function highscoresButtonGPress()
  composer.gotoScene("highscores",{effect = "fade", time = 3000})
end

local function helpButtonGPress()
end

local function enterPressed()
  if buttonOn == "quit" then
    quitButtonGPress()
  end
  if buttonOn == "play" then
    playButtonGPress()
  end
  if buttonOn == "highscores" then
    highscoresButtonGPress()
  end
end

local function upMenu()
  if buttonOn == "play" then
    quitButtonPPress()
  elseif buttonOn == "help" then
    playButtonPPress()
  elseif buttonOn == "highscores" then
    helpButtonPPress()
  elseif buttonOn == "quit" then
    highscoresButtonPPress()
  else
    playButtonPPress()
  end
end

local function downMenu()
  if buttonOn == "play" then
    helpButtonPPress()
  elseif buttonOn == "help" then
    highscoresButtonPPress()
  elseif buttonOn == "highscores" then
    quitButtonPPress()
  elseif buttonOn == "quit" then
    playButtonPPress()
  else
    playButtonPPress()
  end
end

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
    }
  },
}

local spriteSheet = graphics.newImageSheet( "spriteSheet.png", sheetOptions )

local function MusicPausePressed()
  audio.resume(loop)
  gamePauseButton.alpha = 0
  gameMusicButton.alpha = 1
  music = "on"
  print("Music On")
end

local function MusicPlayPressed()
  audio.pause(loop)
  gameMusicButton.alpha = 0
  gamePauseButton.alpha = 1
  music = "off"
  print("Music Off")
end

local function keyPressed(event)
    if event.keyName == "m" and event.phase == "up" then
      if music == "on" then
        MusicPlayPressed()
      else
        MusicPausePressed()
      end
    end
    if event.keyName == "up" and event.phase == "down" then
      upMenu()
    end
    if event.keyName == "down" and event.phase == "down" then
      downMenu()
    end
    if event.keyName == "enter" and event.phase == "up" then
      enterPressed()
    end
    return false
end

Runtime:addEventListener( "key", keyPressed )

-- create()
function scene:create( event )

    local sceneGroup = self.view


    local background = display.newImageRect( spriteSheet, 14, display.contentWidth, display.contentHeight )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background.width = display.contentWidth
    background.height = display.contentHeight
    sceneGroup:insert(background)

    local donutTxt = display.newImageRect( spriteSheet, 4, 750, 200 )
    donutTxt.x = display.contentCenterX
    donutTxt.y = 200
    sceneGroup:insert(donutTxt)

    local raidersTxt = display.newImageRect( spriteSheet, 3, 1100, 200 )
    raidersTxt.x = display.contentCenterX
    raidersTxt.y = 450
    sceneGroup:insert(raidersTxt)

    local donut_1 = display.newImageRect( spriteSheet, 5, 250, 250 )
    donut_1.x = 1336
    donut_1.y = 200
    sceneGroup:insert(donut_1)

    local donut_2 = display.newImageRect( spriteSheet, 5, 250, 250 )
    donut_2.x = 200
    donut_2.y = 200
    sceneGroup:insert(donut_2)

    gameMusicButton = display.newImageRect( spriteSheet, 1, 133, 100 )
    gameMusicButton.x = 118
    gameMusicButton.y = 1945
    sceneGroup:insert(gameMusicButton)

    gamePauseButton = display.newImageRect( spriteSheet, 2, 119, 100 )
    gamePauseButton.x = 113
    gamePauseButton.y = 1945
    gamePauseButton.alpha = 0
    sceneGroup:insert(gamePauseButton)

    gamePauseButton:addEventListener("tap", MusicPausePressed)
    gameMusicButton:addEventListener("tap", MusicPlayPressed)

    playButtonP = display.newImageRect( spriteSheet, 6, 866, 159 )
    playButtonP.x = display.contentCenterX
    playButtonP.y = 900
    sceneGroup:insert(playButtonP)

    playButtonG = display.newImageRect( spriteSheet, 7, 866, 159 )
    playButtonG.x = display.contentCenterX
    playButtonG.y = 900
    playButtonG.alpha = 0
    sceneGroup:insert(playButtonG)

    helpButtonP = display.newImageRect( spriteSheet, 8, 866, 159 )
    helpButtonP.x = display.contentCenterX
    helpButtonP.y = 1100
    sceneGroup:insert(helpButtonP)

    helpButtonG = display.newImageRect( spriteSheet, 9, 866, 159 )
    helpButtonG.x = display.contentCenterX
    helpButtonG.y = 1100
    helpButtonG.alpha = 0
    sceneGroup:insert(helpButtonG)

    highscoresButtonP = display.newImageRect (spriteSheet, 12, 866, 159)
    highscoresButtonP.x = display.contentCenterX
    highscoresButtonP.y = 1300
    sceneGroup:insert(highscoresButtonP)

    highscoresButtonG = display.newImageRect (spriteSheet, 13, 866, 159)
    highscoresButtonG.x = display.contentCenterX
    highscoresButtonG.y = 1300
    highscoresButtonG.alpha = 0
    sceneGroup:insert(highscoresButtonG)

    quitButtonP = display.newImageRect( spriteSheet, 10, 866, 159)
    quitButtonP.x = display.contentCenterX
    quitButtonP.y = 1500
    sceneGroup:insert(quitButtonP)

    quitButtonG = display.newImageRect( spriteSheet, 11, 866, 159)
    quitButtonG.x = display.contentCenterX
    quitButtonG.y = 1500
    quitButtonG.alpha = 0
    sceneGroup:insert(quitButtonG)

    playButtonP:addEventListener("tap", playButtonPPress)
    helpButtonP:addEventListener("tap", helpButtonPPress)
    highscoresButtonP:addEventListener("tap", highscoresButtonPPress)
    quitButtonP:addEventListener("tap", quitButtonPPress)
    playButtonG:addEventListener("tap", playButtonGPress)
    helpButtonG:addEventListener("tap", helpButtonGPress)
    highscoresButtonG:addEventListener("tap", highscoresButtonGPress)
    quitButtonG:addEventListener("tap", quitButtonGPress)
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- Image sheet options and declaration

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
      Runtime:removeEventListener( "key", keyPressed )
      composer.removeScene("menu-screen")
        -- Code here runs immediately after the scene goes entirely off screen

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
