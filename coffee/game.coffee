# THIS SCRIPT INCLUDED WHEN game.html LOADS. 

############################################################
# "global" configuration constants

FRAMERATE = 1 # frames per second 
INTERVAL = 1000 / FRAMERATE

############################################################
# "global" game state

canvasEdgeX = $(window).width();
canvasEdgeY = $(window).height();
gameLoopCounter = 0 
currentLevel = 0
levelOver = false 

############################################################
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

############################################################
# resize #canvas to window

setSizes = () -> 
	console.log("setSizes runs")
	canvasEdgeX = $(window).width() 
	canvasEdgeY = $(window).height() 
	canvas.width = canvasEdgeX
	canvas.height = canvasEdgeY

############################################################
# game loop control

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
	currentLevel = levelName
	gameLoopCounter = 0 
	console.log("runLevel sets gameLoopCounter to", gameLoopCounter)
	canvas = document.getElementById("canvas")
	console.log("runLevel creates new canvas:", canvas)
	setSizes()
	removeMenus()
	generateTerrain()
	startLoop() if levelOver == false #if prevents duplicate loops
	levelOver = false


############################################################	
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

############################################################
# drawing functions 

draw = () ->
	console.log("draw runs")
	# draw terrain 
	# draw bullets 
	# draw towers 
	# draw creeps 

generateTerrain = () ->
	console.log("generateTerrain runs")
	console.log("generateTerrain error: empty function")

############################################################
# start game on jQuery document.ready 

jQuery -> 
	setSizes()
	addMenus()


