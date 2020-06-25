--          Within this file I create a new composer scene which displays the highscores achieved by the player in game. These are displayed after dieing,
--          or by clicking the highscores button in the menu.

--          Alot of the code used within this file was taken and adapted from the Corona SDK tutorial "Getting Started Lesson 6: Implementing High Score"

-- Setting up composer
local composer = require( "composer" )
local scene = composer.newScene()

-- Defining sprite sheet and images within the sprite sheet
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
    }
  },
}

local spriteSheet = graphics.newImageSheet( "spriteSheet.png", sheetOptions )

-- Loads the json library resource. This is a function built into Corona SDK and it is pretty much used to sort data efficiently and easily
local json = require( "json" )

-- creating scoresTable
local scoresTable = {}

-- Finding doc where scores are stored
local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )

-- This function loads the stored highscores from the file on your computer. If the file is not present then a json file is created.
local function loadScores()

    local file = io.open( filePath, "r" )

    if file then
        local contents = file:read( "*a" )
        io.close( file )
        scoresTable = json.decode( contents )
    end

    if ( scoresTable == nil or #scoresTable == 0 ) then
        scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    end
end

-- This function first of all cuts the highscores list down to 10, then rewrites the highscores file with the new score(s)
local function saveScores()

    for i = #scoresTable, 11, -1 do
        table.remove( scoresTable, i )
    end

    local file = io.open( filePath, "w" )

    if file then
        file:write( json.encode( scoresTable ) )
        io.close( file )
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- load scores function
    loadScores()

    -- set background
    local background = display.newImageRect( spriteSheet, 14, display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- places score fron gane into scores table (only if highscore is accessed after death, not from menu)
    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
    composer.setVariable( "finalScore", 0 )

    -- function that sorts a and b within table
    local function compare( a, b )
        return a > b
    end

    -- sorting
    table.sort( scoresTable, compare )

    -- displaying text
    local highScoresHeader = display.newText("High Scores", display.contentCenterX, 250, "ARCADE.TTF", 200 )

    -- saves new scores
    saveScores()

    -- This function places the numbers from 1-10 down the screen as well as the highscores in order next to them
    local function displayScores(i)
      local rankNum = display.newText( i .. ")", display.contentCenterX-50, yPos, "ARCADE.TTF", 150 )
      rankNum:setFillColor( 0.8 )
      rankNum.anchorX = 1

      local thisScore = display.newText( scoresTable[i], display.contentCenterX-30, yPos, "ARCADE.TTF", 150 )
      thisScore.anchorX = 0
    end
    for i = 1, 10 do
        if ( scoresTable[i] ) then
            local yPos = 250 + ( i * 150 )

            local rankNum = display.newText( i .. ")", display.contentCenterX-50, yPos, "ARCADE.TTF", 150 )
            rankNum:setFillColor( 0.8 )
            rankNum.anchorX = 1

            local thisScore = display.newText( scoresTable[i], display.contentCenterX-30, yPos, "ARCADE.TTF", 150 )
            thisScore.anchorX = 0
        end
    end

end


-- show()
function scene:show( event )

    local sceneGroup = self.view

    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

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
