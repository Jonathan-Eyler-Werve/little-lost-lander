# THIS SCRIPT INCLUDED WHEN game.html LOADS. 

# "global" configuration constants

FRAMERATE = 1 # frames per second 
INTERVAL = 1000 / FRAMERATE

# "global" game state

canvasEdgeX = $(window).width();
canvasEdgeY = $(window).height();

gameLoopCounter = 0 
currentLevel = 0
levelOver = false 

# UI elements 
menuCode = 
	"<div id='startMenu'>
	<p>Hello game, this is game.</p>
	<a href='#' class='menuLinkOne'>Start level one.</a>
	</div>
	"

removeMenus = () -> 
	console.log("removeMenus runs")
	console.log("removeMenus warning: no #startMenu to remove") if $("#startMenu").length == 0 
	$("#startMenu").remove() if $("#startMenu").length > 0

addMenus = () -> 
	console.log("addMenus runs")
	console.log("removeMenus warning: #startMenu already exists") if $("#startMenu").length > 0 
	if ($("#startMenu").length == 0)
		$('#menu').append -> menuCode 
		$('.menuLinkOne').on 'click' , -> 
			runLevel(100)

# resize #canvas to window
setSizes = () -> 
	console.log("setSizes runs")
	canvasEdgeX = $(window).width() 
	canvasEdgeY = $(window).height() 
	canvas.width = canvasEdgeX
	canvas.height = canvasEdgeY

# game loop control

# loopId = => setInterval (
# 	gameLoop
# ), INTERVAL 
# Can't seem to get a handle to clearInterval with using CoffeeScript

startLoop = () -> 
	console.log("startLoop runs")
	setInterval (gameLoop), INTERVAL 

endGame = () -> 
	console.log("endGame runs")
	## game curnently set up to keep interval going. :( 
	# console.log("loopId is...", loopId)
	# clearInterval(loopId)
	addMenus()

runLevel = (levelName) -> 
	console.log("runLevel runs level:", levelName)
	gameLoopCounter = 0 
	console.log("runLevel sets gameLoopCounter to", gameLoopCounter)
	canvas = document.getElementById("canvas")
	console.log("runLevel creates new canvas:", canvas)
	setSizes()
	removeMenus()
	startLoop() if levelOver == false #prevents duplicate loops
	levelOver = false
	currentLevel = levelName
	
#game levels

gameLoop = () -> 

	if currentLevel == 100 && levelOver == false
		console.log("level 100 bizness logics, yo")

	if levelOver == false
		gameLoopCounter += 1 # gameloop counter increments only when level is active
		console.log("gameLoop is active")
		console.log("gameLoopCounter =", gameLoopCounter)
		draw()
		levelOver = true if gameLoopCounter >= 3
		endGame() if levelOver == true

# frame drawing functions 
draw = () ->
	console.log("draw runs")


# create menu on jQuery document ready 
jQuery -> 
	setSizes()
	addMenus()









# view menu

# on menu click 
# run chapter 
# hide menus

# to run chapter... 
# create canvas
# create containers 
# create starting UI 
# run game loop 
# do things 
# end game loop
# add menus 



