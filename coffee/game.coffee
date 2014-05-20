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
# image paths 

imgBase = new Image 
	src: "images/icon_18231.svg"
	height: 50
	width: 50 

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
	console.log("canvasEdgeX is ", canvasEdgeX)
	console.log("canvasEdgeY is ", canvasEdgeY)
		# locate center of screen 

	centerX = grid(canvasEdgeX / 2)
	centerY = grid(canvasEdgeY / 2)
	console.log("centerX is ", centerX)
	console.log("centerY is ", centerY)

		# translate positon to grid system 

	# draw terrain 
	# draw bullets 
	# draw towers


	# draw creeps 

grid = (number) -> 
	Math.floor(number / 50) * 50  
	
generateTerrain = () ->
	console.log("generateTerrain runs")
	console.log("generateTerrain error: empty function")

############################################################
# start game on jQuery document.ready 

jQuery -> 
	console.log("document ready!")
	setSizes()
	addMenus()

############################################################
# tests

console.log("testing: grid()")
console.log(grid(0) == 0)
console.log(grid(1) == 0)
console.log(grid(50) == 50)
console.log(grid(51) == 50)
console.log(grid(999) == 950)
console.log(grid(-1) == -50)
console.log(grid(-51) == -100)
