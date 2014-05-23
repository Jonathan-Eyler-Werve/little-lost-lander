# THIS SCRIPT INCLUDED WHEN game.html LOADS. 

# compile with...
# coffee --watch --compile --output js/ coffee/

############################################################
# "global" constants

FRAMERATE = 1 # frames per second 
INTERVAL = 1000 / FRAMERATE

############################################################
# image paths 

# structures
imgBase = new Image 50, 50 
imgBase.src = "images/icon_18231.svg"

window.game = 
	towers: []
	movers: []
	terrain: []
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
	window.game.canvas.width = $(window).width() 
	window.game.canvas.height = $(window).height() 

$(window).resize -> 
  setSizes();	

############################################################
# game loop control

runLevel = (levelName) -> 
	console.log("runLevel runs level:", levelName)
	window.game.currentLevel = levelName
	loopCounter = 0 
	console.log("runLevel sets game.loopCounter to", loopCounter)
	window.game.canvas = document.getElementById("canvas")
	console.log("runLevel creates new window.game.canvas:", window.game.canvas)
	removeMenus()
	generateTerrain()
	startLoop() if window.game.over == false #if prevents duplicate loops
	window.game.over = false

startLoop = () -> 
	console.log("startLoop runs")
	setInterval (levelLoop), INTERVAL 

levelLoop = () -> 

# LEVEL 100 
	if window.game.currentLevel == 100 && window.game.over == false
		console.log("level 100 bizness logics, yo")
		towers[0] = new FireTower window.game.center.x, window.game.center.Y if loopCounter == 2

		W.game.over = true if loopCounter >= 5
		endGame() if W.game.over == true

# ALL LEVELS
	if W.game.over == false
		W.game.loopCounter += 1 # gameloop counter increments only when level is active
		console.log("levelLoop is active")
		console.log("W.game.loopCounter =", loopCounter)
		drawEverything()

endGame = () -> 
	console.log("endGame runs")
	W.game.towers = []
	addMenus()		
		
############################################################
# drawing functions 

drawEverything = () ->
	console.log("draw runs")

	# relocate center of screen 

	_centerX = toGrid(W.game.canvas.width / 2)
	_centerY = toGrid(W.game.canvas.height / 2)
	window.game.center = 
		x: _centerX
		y: _centerY
	
	# draw terrain <- collections, bottom layer up
	# draw bullets 
	console.log(towers)
	drawCollection(towers)	
	# draw movers

drawCollection = (collection) -> 
	console.log
	drawOne(thing) for thing in collection 

drawOne = (thing) ->
	console.log("drawOne runs for ", thing)

toGrid = (location) -> 
	Math.floor(location / 50) * 50  
	
generateTerrain = () ->
	console.log("generateTerrain runs")
	console.log("generateTerrain error: empty function")






############################################################	
#towers 

class Building 
	constructor: (posX, posY) ->		
		this.posX = toGrid(posX)
		this.posY = toGrid(posY)
		this.bornCycle = @loopCounter

	drawTower: -> 
		console.log("tower.drawTower is called")
		console.log("drawTower error: empty function")

	rotate: ->
		console.log("tower.rotate is called")
		console.log("rotate error: empty function")

class FireTower extends Building
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
	window.game = 
		loopCounter: 0 
		currentLevel: 0
		over: false 
		towers: []
		movers: []
		terrain: []
		canvas: undefined
		context: undefined

	window.game.canvas = document.getElementById("canvas")
	window.game.context = window.game.canvas.getContext("2d")	 

	setAlias()
	setSizes()
	addMenus()
	runTests()

setAlias = () -> 
	console.log("setAlias runs")
	@towers = window.game.towers 
	@movers = window.game.movers 
	@terrain = window.game.terrain
	@loopCounter = window.game.loopCounter

############################################################
# tests

runTests = () -> 
	console.log("")
	console.log("runTests() runs")
	console.log("")

	console.log("testing: game object creation")
	console.log(window.game)
	console.log(window.game != undefined)
	console.log(window.game.constructor == Object)
	console.log(window.game.canvas.constructor == HTMLCanvasElement)
	console.log("")

	console.log("testing: setAlias")
	console.log(@towers == window.game.towers, "tower alias" )
	console.log(@terrain == window.game.terrain, "terrain alias")
	console.log(@terrain == window.game.terrain, "movers alias")
	console.log(@loopCounter == window.game.loopCounter, "loopCounter alias")
	console.log("")

	console.log("testing: image object creation")	
	console.log(imgBase.constructor == Image)
	console.log(imgBase.src != "")
	console.log("")

	console.log("testing setSizes()")

	setSizes()
	console.log(window.game.canvas.width != undefined)
	console.log(window.game.canvas.height != undefined)
	console.log(window.game.canvas.width == $(window).width() )
	console.log(window.game.canvas.height == $(window).height(), "height definition = current height" )
	console.log(window.game.canvas.height, $(window).height(), "heights")
	# I don't know why this isn't breaking things. Will figure out later. 
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
	console.log("Error: ain't got no tests")
	console.log("")

	console.log("testing: towers collection")
	testTower = 
		posX: 0
		posY: 0
		image: imgBase
	window.game.towers.push testTower
	console.log(towers == window.game.towers)
	console.log(towers[@towers.length - 1].posX == 0)
	console.log(towers[@towers.length - 1].image.src == "file:///Users/jonathan/gdrive/CODE/little-lost-lander/images/icon_18231.svg")
	console.log("")
	window.game.towers.pop(1) # cleaning up test data

	console.log("testing: class FireTower")
	fireTest = new FireTower 51, 1 
	console.log(fireTest.image == imgBase)
	console.log(fireTest.posX == 50)
	console.log(fireTest.posY == 0)
	console.log("")
