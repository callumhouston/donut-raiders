-- This file is just preset to launch the composer function and redirect app to the menu screen

-- This function hides the IOS menu bar
display.setStatusBar( display.HiddenStatusBar )

-- This function activates and loads the composer library
local composer = require("composer")

local loop =  audio.loadStream("menuMusic.mp3")
audio.play(loop)
music = "on"


-- This inbuilt function fades into the menu-screen file in 5s
composer.gotoScene("menu-screen", {effect = "fade", time = 3000})
