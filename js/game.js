// Generated by CoffeeScript 1.7.1
(function() {
  var FRAMERATE, INTERVAL, addMenus, canvasEdgeX, canvasEdgeY, currentLevel, draw, endGame, gameLoop, gameLoopCounter, generateTerrain, levelOver, menuCode, removeMenus, runLevel, setSizes, startLoop;

  FRAMERATE = 1;

  INTERVAL = 1000 / FRAMERATE;

  canvasEdgeX = $(window).width();

  canvasEdgeY = $(window).height();

  gameLoopCounter = 0;

  currentLevel = 0;

  levelOver = false;

  menuCode = "<div id='startMenu'> <p>Hello game, this is game.</p> <a href='#' class='menuLinkOne'>Start level one.</a> </div>";

  removeMenus = function() {
    console.log("removeMenus runs");
    if ($("#startMenu").length === 0) {
      console.log("removeMenus warning: no #startMenu to remove");
    }
    if ($("#startMenu").length > 0) {
      return $("#startMenu").remove();
    }
  };

  addMenus = function() {
    console.log("addMenus runs");
    if ($("#startMenu").length > 0) {
      console.log("removeMenus warning: #startMenu already exists");
    }
    if ($("#startMenu").length === 0) {
      $('#menu').append(function() {
        return menuCode;
      });
      return $('.menuLinkOne').on('click', function() {
        return runLevel(100);
      });
    }
  };

  setSizes = function() {
    console.log("setSizes runs");
    canvasEdgeX = $(window).width();
    canvasEdgeY = $(window).height();
    canvas.width = canvasEdgeX;
    return canvas.height = canvasEdgeY;
  };

  startLoop = function() {
    console.log("startLoop runs");
    return setInterval(gameLoop, INTERVAL);
  };

  endGame = function() {
    console.log("endGame runs");
    return addMenus();
  };

  runLevel = function(levelName) {
    var canvas;
    console.log("runLevel runs level:", levelName);
    currentLevel = levelName;
    gameLoopCounter = 0;
    console.log("runLevel sets gameLoopCounter to", gameLoopCounter);
    canvas = document.getElementById("canvas");
    console.log("runLevel creates new canvas:", canvas);
    setSizes();
    removeMenus();
    generateTerrain();
    if (levelOver === false) {
      startLoop();
    }
    return levelOver = false;
  };

  gameLoop = function() {
    if (currentLevel === 100 && levelOver === false) {
      console.log("level 100 bizness logics, yo");
    }
    if (levelOver === false) {
      gameLoopCounter += 1;
      console.log("gameLoop is active");
      console.log("gameLoopCounter =", gameLoopCounter);
      draw();
      if (gameLoopCounter >= 3) {
        levelOver = true;
      }
      if (levelOver === true) {
        return endGame();
      }
    }
  };

  draw = function() {
    return console.log("draw runs");
  };

  generateTerrain = function() {
    console.log("generateTerrain runs");
    return console.log("generateTerrain error: empty function");
  };

  jQuery(function() {
    setSizes();
    return addMenus();
  });

}).call(this);
