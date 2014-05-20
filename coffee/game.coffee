# THIS SCRIPT INCLUDED WHEN game.html LOADS. 

############################################################
# "global" configuration constants

FRAMERATE = 1 # frames per second 
INTERVAL = 1000 / FRAMERATE

############################################################
# "global" game state

game = new Object 
	loopCounter: 0 
	currentLevel: 0
	over: false 

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
	canvas.width = $(window).width() 
	canvas.height = $(window).height() 

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
	game.currentLevel = levelName
	game.loopCounter = 0 
	console.log("runLevel sets gameLoopCounter to", game.loopCounter)
	game.canvas = document.getElementById("canvas")
	console.log("runLevel creates new game.canvas:", game.canvas)
	setSizes()
	removeMenus()
	generateTerrain()
	startLoop() if game.over == false #if prevents duplicate loops
	game.over = false


############################################################	
#game levels

gameLoop = () -> 

	if game.currentLevel == 100 && game.over == false
		console.log("level 100 bizness logics, yo")

	if game.over == false
		game.loopCounter += 1 # gameloop counter increments only when level is active
		console.log("gameLoop is active")
		console.log("game.loopCounter =", game.loopCounter)
		draw()
		game.over = true if game.loopCounter >= 3
		endGame() if game.over == true

############################################################
# drawing functions 

draw = () ->
	console.log("draw runs")

	# locate center of screen 

	centerX = toGrid(game.canvas.width / 2)
	centerY = toGrid(game.canvas.height / 2)

	# draw terrain 
	# draw bullets 
	# draw towers


	# draw creeps 

toGrid = (number) -> 
	Math.floor(number / 50) * 50  
	
generateTerrain = () ->
	console.log("generateTerrain runs")
	console.log("generateTerrain error: empty function")

############################################################
# start game on jQuery document.ready 

jQuery -> 
	console.log("$ document ready")
	setSizes()
	addMenus()

############################################################
# tests

console.log("testing: grid()")
console.log(toGrid(0) == 0)
console.log(toGrid(1) == 0)
console.log(toGrid(50) == 50)
console.log(toGrid(51) == 50)
console.log(toGrid(999999999999999) == 999999999999950)
console.log(toGrid(-1) == -50)
console.log(toGrid(-51) == -100)
