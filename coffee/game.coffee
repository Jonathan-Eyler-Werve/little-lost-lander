# THIS SCRIPT IS RUN WHEN game.html LOADS. 

# "global" values
canvasEdgeX = $(window).width();
canvasEdgeY = $(window).height();
frameRate = 1 # frames per second 
interval = 1000 / frameRate
levelOver = false 
gameLoopCounter = 0 


#UI elements 
menuCode = 
	"<div id='startMenu'>
	<p>Hello game, this is game.</p>
	<a href='#' class='menuLinkOne'>Start level one.</a>
	</div>
	"

# resize #canvas to window
setSizes = () -> 
	console.log("setSizes runs")
	canvasEdgeX = $(window).width() 
	canvasEdgeY = $(window).height() 
	canvas.width = canvasEdgeX
	canvas.height = canvasEdgeY

removeMenus = () -> 
	console.log("removeMenus runs")
	$("#startMenu").remove()

loopId = () -> setInterval (
	gameLoop
), interval 

startLoop = () -> 
	console.log("startLoop runs")
	console.log("levelOver =", levelOver)
	loopId()

gameLoop = () -> 
	console.log("gameLoop runs")
	endGame() if levelOver == true
	gameLoopCounter += 1 
	levelOver = true if gameLoopCounter == 5
	console.log("gameLoopCounter =", gameLoopCounter)

endGame = () -> 
	console.log("endGame runs")
	console.log("loopId =", loopId())
	clearInterval(loopId)

	$('#menu').append -> 
		menuCode  

runLevel = (levelName) -> 
	console.log("runLevel runs")
	removeMenus()
	startLoop()
	# startGame(levelName)
	 



# create canvas
jQuery -> 
	canvas = document.getElementById("canvas")
	setSizes()

	$('#menu').append -> 
		menuCode  

	$('.menuLinkOne').on 'click' , -> 
		runLevel(100)







# view menu

# on menu click 
# run chapter 

# on chapter  
# create canvas
# create containers 
# create starting UI 
# run game loop 
# do things 



