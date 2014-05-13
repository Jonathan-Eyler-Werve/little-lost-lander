# THIS SCRIPT IS RUN WHEN game.html LOADS. 

# "global" values
canvasEdgeX = $(window).width();
canvasEdgeY = $(window).height();

# resize #canvas to window
setSizes = () -> 
	canvasEdgeX = $(window).width(); 
	canvasEdgeY = $(window).height(); 
	canvas.width = canvasEdgeX;
	canvas.height = canvasEdgeY;

# create canvas
jQuery -> 
	canvas = document.getElementById("canvas");
	setSizes()
	




# view menu

# on menu click 
# run chapter 

# on chapter  
# create canvas
# create containers 
# create starting UI 
# run game loop 
# do things 



