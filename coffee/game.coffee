# THIS SCRIPT INCLUDED WHEN game.html LOADS. 

# compile with...
# coffee --watch --compile --output js/ coffee/

############################################################
# "global" constants

FRAMERATE = 10 # frames per second 
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
	"<div id='startMenu' class='over-canvas'>
	<p>Hello game, this is game.</p>
	<a href='#' class='menuLinkOne'>Start level one.</a>
	</div>
	"

gameControlsCode = 
	"<div id='gameControls' class='over-canvas'>
	<p>This is gameControls.</p>
	<a href='#' class='addBuilding'>Make a building appear.</a>
	<a href='#' class='endLevel'>End this level.</a>	
	</div>
	"

setCurrentControl = (_control) -> 
	console.log("setCurrentControl("+_control+") runs")
	window.game.currentControl = _control 
	$("#currentControl").remove() if $("#currentControl").length > 0 	
	
	_message = "Place a tower" if _control == "addBuilding"
	_currentControlCode = "<div id='currentControl' class='top-right-panel'> " + _message + " </div>"	
	
	$('#top-right-panel').append -> _currentControlCode unless _control == "none" || _control == "start"

	return _message

removeMenus = () -> 
	console.log("removeMenus() runs")
	console.log("removeMenus warning: no #startMenu to remove") if $("#startMenu").length == 0 
	$("#startMenu").remove() if $("#startMenu").length > 0

addMenus = () -> 
	console.log("addMenus() runs")
	console.log("addMenus warning: #startMenu already exists") if $("#startMenu").length > 0 
	if ($("#startMenu").length == 0)
		$('#menu').append -> menuCode 
		$('.menuLinkOne').on 'click' , -> 
			console.log(".menuLinkOne click event")
			runLevel(100)

addGameControls = () ->				
	console.log("addGameControls() runs")
	console.log("addMenus warning: #gameControls already exists") if $("#gameControls").length > 0 
	if ($("#gameControls").length == 0)
		console.log("menu selector", $('#menu').length)
		$('#menu').append -> gameControlsCode 
		
		$('.addBuilding').on 'click' , -> 
			console.log("addBuilding button event")
			gameControls("addBuilding")

		$('.endLevel').on 'click' , -> 
			console.log("endLevel button event")
			gameControls("endLevel")	

removeGameControls = () -> 
	console.log("removeGameControls() runs")
	console.log("removeGameControls warning: no #startMenu to remove") if $("#gameControls").length == 0 
	$("#gameControls").remove() if $("#gameControls").length > 0

gameControls = (command) -> 
	if command == "addBuilding"
		setCurrentControl(command)
		# other things that happen because we are in window.game.currentControl == "addBuiding"
		# possible state toggle of the button UI (ie, cancel currentControl)

	window.game.status = "endLevel"	if command == "endLevel"


############################################################
# resize #canvas to window

setSizes = () -> 
	# console.log("setSizes() runs")
	window.game.canvas.width = $(window).width() 
	window.game.canvas.height = $(window).height() 

	_centerX = toGrid(window.game.canvas.width / 2)
	_centerY = toGrid(window.game.canvas.height / 2)
	window.game.center = 
		x: _centerX
		y: _centerY

$(window).resize -> 
  setSizes();	

############################################################
# game loop control

runLevel = (levelName) -> 
	console.log("runLevel runs level:", levelName)
	window.game.currentLevel = levelName
	@loopCounter = 0 
	console.log("runLevel sets game.loopCounter to", loopCounter)
	
	removeMenus()
	setSizes()
	window.game.canvas = document.getElementById("canvas")
	console.log("runLevel creates new window.game.canvas:", window.game.canvas)

	# generateTerrain()

	console.log(window.game.status)
	if window.game.status == "start" # prevents duplicate loops
		startLoop() 
	else
		window.game.status = "running"	

startLoop = () -> 
	console.log("startLoop runs")
	window.game.status = "running"
	setInterval (levelLoop), INTERVAL 

levelLoop = () -> 

	levelInitialize(window.game.currentLevel) if @loopCounter == 0 # level initialize

	if window.game.status == "running" || window.game.status == "endLevel"

	#LEVELS 	
		level100() if window.game.currentLevel == 100 

	# ALL LEVELS
		@loopCounter += 1 # gameloop counter increments only when level is active
		# console.log("levelLoop is active. status =", window.game.status)
		# console.log("loopCounter =", @loopCounter)

		setCursorState(window.game.currentControl)
		drawEverything()

levelInitialize = (level) -> 
	console.log("levelInitialize() runs for", level)
	setSizes()
			
	if level == 100 
		addGameControls()
		# draw terrain
		# start wave timer
			# create creeps 

level100 = () -> 
		endGame() if window.game.status == "endLevel"
		console.log("level", 100, "is", window.game.status, "at loop", @loopCounter) if @loopCounter % (10 * FRAMERATE) == 0

endGame = () -> 
	console.log("endGame() runs")
	setCurrentControl("none")
	drawEverything()
	window.game.status = "paused"
	@towers.pop(@towers.length) #emptys array while keeping alias
	# clear @movers 
	# clear @terrain 
	removeGameControls()
	addMenus()		
		
		
############################################################
# user input functions 

setCursorState = (_control) -> # !runs during levelLoop 
	$(window).unbind()

	if _control == "addBuilding" 

		# do things to the cursor image

		# bind to the click event 
		console.log("window click is bound")

		$(window).on 'click' , -> 
			$(window)
			console.log("window click event (during addBuilding control state)")
			placeTower(event, "FireTower")
			window.game.currentControl = "none"
			$(window).unbind( "click" );

placeTower = (event, towerType) -> 
	console.log("placeTower() runs")
	
	_posX = toGrid(event.pageX)
	_posY = toGrid(event.pageY)
	console.log("placeTower at positions...", _posX, _posY)
	setCursorState("none")
	setCurrentControl("none")

	@towers.push(new FireTower _posX, _posY)

	# console.log(@towers)
	return "foo"




	# create tower object at posx, posy





############################################################
# drawing functions 

drawEverything = () ->
	# console.log("drawEverything runs")
	# relocate center of screen 
	setSizes()
	clearCanvas()
	# draw terrain <- collections, bottom layer up
	# draw bullets 
	drawCollection(towers)	
	# draw movers

drawOne = (thing) ->
	# console.log("drawOne runs for ", thing)
	window.game.context.save()
	window.game.context.translate(thing.posX, thing.posY)
	window.game.context.rotate(thing.direction)
	window.game.context.drawImage(thing.image,0,0)
	window.game.context.restore()
	#shift context to thing location 
	#rotate conext to thing rotation
	#draw object 
	#restore context 

drawCollection = (collection) -> 
	# console.log("drawCollection for", collection)
	drawOne(thing) for thing in collection 

clearCanvas = () -> 
	window.game.context.clearRect(0, 0, window.game.canvas.width, window.game.canvas.height)  
	window.game.context.fillStyle = "rgba(0, 255, 0, 1)";       

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
		this.bornCycle = window.game.loopCounter
		this.direction = 0

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
	console.clear 
	console.log("$ document ready")
	window.game = 
		loopCounter: 0 
		currentLevel: 0
		status: "start" 
		towers: []
		movers: []
		terrain: []
		currentControl: "start"
		canvas: undefined
		context: undefined

	window.game.canvas = document.getElementById("canvas")
	window.game.context = window.game.canvas.getContext("2d") 

	setAlias()
	setSizes()
	addMenus()
	runTests()

setAlias = () -> 
	console.log("setAlias() runs")
	@towers = window.game.towers 
	@movers = window.game.movers 
	@terrain = window.game.terrain
	@loopCounter = window.game.loopCounter

############################################################
# tests

runTests = () -> 
	console.log("runTests() runs")
	console.log("")

	console.log("testing: game object creation")
	console.log(window.game != undefined)
	console.log(window.game.constructor == Object)
	console.log(window.game.canvas.constructor == HTMLCanvasElement)
	console.log((window.game.status == "start"), "game initializes with game.status == start")	
	console.log("")

	console.log("testing: runLevel")
	@loopCounter = 1
	window.game.status = "running"
	runLevel()
	console.log(@loopCounter == 0, "loopCounter is reset to 0")
	console.log("")
	window.game.status = "start" #cleaning up test state

	console.log("testing: endGame()")
	# window.game.towers.push("foo")
	endGame()
	console.log($("#startMenu").length > 0, "endGame restores menus")
	console.log(@towers[@towers.length - 1] != "foo", "endGame clears towers")
	console.log("")
	window.game.status = "start" #cleaning up test state

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
	console.log(window.game.canvas.constructor == HTMLCanvasElement, "canvas exists")
	console.log(window.game.context.constructor == CanvasRenderingContext2D, "context exists")
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

	console.log("testing: selectors")
	console.log(($('#menu').length > 0), "#menu")
	console.log(($('#top-right-panel').length > 0), "#top-right-panel")
	console.log("")
 
	console.log("testing: setCurrentControl()")
	setCurrentControl("none")
	console.log($("#currentControl").length == 0)
	setCurrentControl("addBuilding")
	console.log($("#currentControl").length > 0)
	console.log(window.game.currentControl == "addBuilding")
	setCurrentControl("start")
	console.log(window.game.currentControl == "start")
	console.log("")
