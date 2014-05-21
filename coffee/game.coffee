# THIS SCRIPT INCLUDED WHEN game.html LOADS. 

############################################################
# "global" constants

FRAMERATE = 1 # frames per second 
INTERVAL = 1000 / FRAMERATE
@W = $(window)

############################################################
# image paths 

# structures
imgBase = new Image 50, 50 
imgBase.src = "images/icon_18231.svg"

# movers

# terrain

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
	W.game.canvas.width = $(window).width() 
	W.game.canvas.height = $(window).height() 

W.resize -> 
  setSizes();	

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
	W.game.currentLevel = levelName
	W.game.loopCounter = 0 
	console.log("runLevel sets gameLoopCounter to", W.game.loopCounter)
	W.game.canvas = document.getElementById("canvas")
	console.log("runLevel creates new W.game.canvas:", W.game.canvas)
	removeMenus()
	generateTerrain()
	startLoop() if W.game.over == false #if prevents duplicate loops
	W.game.over = false

############################################################	
#game levels

gameLoop = () -> 

	if W.game.currentLevel == 100 && W.game.over == false
		console.log("level 100 bizness logics, yo")
		towers[0] = new Tower W.game.centerX, W.game.centerY


		W.game.over = true if W.game.loopCounter >= 3
		endGame() if W.game.over == true

	if W.game.over == false
		W.game.loopCounter += 1 # gameloop counter increments only when level is active
		console.log("gameLoop is active")
		console.log("W.game.loopCounter =", W.game.loopCounter)
		draw()
		
############################################################
# drawing functions 

draw = () ->
	console.log("draw runs")

	# locate center of screen 

	centerX = toGrid(W.game.canvas.width / 2)
	centerY = toGrid(W.game.canvas.height / 2)
	W.game.center = new Object 
		x: centerX
		y: centerY

	# draw terrain 
	# draw bullets 
	# draw towers
	# draw creeps 

toGrid = (location) -> 
	Math.floor(location / 50) * 50  
	
generateTerrain = () ->
	console.log("generateTerrain runs")
	console.log("generateTerrain error: empty function")


############################################################	
#towers 

class Tower 
	constructor: (posX, posY) ->		
		this.posX = toGrid(posX)
		this.posY = toGrid(posY)
		this.bornCycle = W.game.loopCounter

	drawTower: -> 
		console.log("tower.drawTower is called")
		console.log("drawTower error: empty function")

	rotate: ->
		console.log("tower.rotate is called")
		console.log("rotate error: empty function")

class Turret extends Tower
	constructor: (posX, posY) ->
		this.image = imgBase 
		super posX, posY

# drawTower = (ctx) -> 
# 	ctx.save()
# 	ctx.translate(this.posX, this.posY)
# 	ctx.drawImage(this.image,-50,-50);
# 	ctx.restore





############################################################
# start game on jQuery document.ready 

jQuery -> 
	console.log("$ document ready")

	W.game = new Object 
		loopCounter: 0 
		currentLevel: 0
		over: false 
		canvas: document.getElementById("canvas")
		context: canvas.getContext("2d")
		towers: []
	
	setSizes()
	addMenus()
	runTests()


 


############################################################
# tests

runTests = () -> 
	console.log("")

	console.log("testing: game object creation")
	console.log(W != undefined)
	console.log(W.game.constructor == Object)
	console.log(W.game.canvas.constructor == HTMLCanvasElement)
	console.log("")

	console.log("testing: image object creation")	
	console.log(imgBase.constructor == Image)
	console.log(imgBase.src != "")
	console.log("")

	console.log("testing setSizes()")
	console.log(W.game.canvas.width != undefined)
	console.log(W.game.canvas.height != undefined)
	console.log(W.game.canvas.width == $(window).width() )
	console.log(W.game.canvas.height == $(window).height() )
	console.log("")

	console.log("testing: toGrid()")
	console.log(toGrid(0) == 0)
	console.log(toGrid(1) == 0)
	console.log(toGrid(50) == 50)
	console.log(toGrid(51) == 50)
	console.log(toGrid(999999999999999) == 999999999999950)
	console.log(toGrid(-1) == -50)
	console.log(toGrid(-51) == -100)
	console.log("")

	console.log("testing: draw()")
	console.log("")


	console.log("testing: tower creation")

	console.log("")

	console.log("testing: tower creation")
	testTower = new Object 
		posX: 0
		posY: 0
		image: imgBase
	W.game.towers.push testTower

	console.log(W.game.towers[W.game.towers.length - 1].posX == 0)
	console.log(W.game.towers[W.game.towers.length - 1].image.src == "file:///Users/jonathan/gdrive/CODE/little-lost-lander/images/icon_18231.svg")
	console.log("")
	console.log("")				
	console.log("")

	W.game.towers.pop(1) # cleaning up test data




