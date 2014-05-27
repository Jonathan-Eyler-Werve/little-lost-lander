// Generated by CoffeeScript 1.7.1
var Building, FRAMERATE, FireTower, INTERVAL, addGameControls, addMenus, clearCanvas, currentControl, drawCollection, drawEverything, drawOne, endGame, gameControls, gameControlsCode, generateTerrain, imgBase, level100, levelInitialize, levelLoop, menuCode, removeGameControls, removeMenus, runLevel, runTests, setAlias, setSizes, startLoop, toGrid,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

FRAMERATE = 10;

INTERVAL = 1000 / FRAMERATE;

imgBase = new Image(50, 50);

imgBase.src = "images/icon_18231.svg";

window.game = {
  towers: [],
  movers: [],
  terrain: []
};

menuCode = "<div id='startMenu' class='over-canvas'> <p>Hello game, this is game.</p> <a href='#' class='menuLinkOne'>Start level one.</a> </div>";

gameControlsCode = "<div id='gameControls' class='over-canvas'> <p>This is gameControls.</p> <a href='#' class='addBuilding'>Make a building appear.</a> <a href='#' class='endLevel'>End this level.</a> </div>";

currentControl = function(message) {
  if ($("#currentControl").length > 0) {
    $("#currentControl").remove();
  }
  return "<div id='currentControl' class='top-right-panel'> " + message + " </div>";
};

removeMenus = function() {
  console.log("removeMenus() runs");
  if ($("#startMenu").length === 0) {
    console.log("removeMenus warning: no #startMenu to remove");
  }
  if ($("#startMenu").length > 0) {
    return $("#startMenu").remove();
  }
};

addMenus = function() {
  console.log("addMenus() runs");
  if ($("#startMenu").length > 0) {
    console.log("addMenus warning: #startMenu already exists");
  }
  if ($("#startMenu").length === 0) {
    $('#menu').append(function() {
      return menuCode;
    });
    return $('.menuLinkOne').on('click', function() {
      console.log(".menuLinkOne click event");
      return runLevel(100);
    });
  }
};

addGameControls = function() {
  console.log("addGameControls() runs");
  if ($("#gameControls").length > 0) {
    console.log("addMenus warning: #gameControls already exists");
  }
  if ($("#gameControls").length === 0) {
    console.log("menu selector", $('#menu').length);
    $('#menu').append(function() {
      return gameControlsCode;
    });
    $('.addBuilding').on('click', function() {
      return gameControls("addBuilding");
    });
    return $('.endLevel').on('click', function() {
      console.log("endLevel button event");
      return gameControls("endLevel");
    });
  }
};

removeGameControls = function() {
  console.log("removeGameControls() runs");
  if ($("#gameControls").length === 0) {
    console.log("removeGameControls warning: no #startMenu to remove");
  }
  if ($("#gameControls").length > 0) {
    return $("#gameControls").remove();
  }
};

gameControls = function(command) {
  if (command === "addBuilding") {
    console.log("#top-right-panel grabbed as");
    console.log($('#top-right-panel').length);
    $('#top-right-panel').append(function() {
      return currentControl("Place tower");
    });
  }
  if (command === "endLevel") {
    return window.game.status = "endLevel";
  }
};

setSizes = function() {
  var _centerX, _centerY;
  window.game.canvas.width = $(window).width();
  window.game.canvas.height = $(window).height();
  _centerX = toGrid(window.game.canvas.width / 2);
  _centerY = toGrid(window.game.canvas.height / 2);
  return window.game.center = {
    x: _centerX,
    y: _centerY
  };
};

$(window).resize(function() {
  return setSizes();
});

runLevel = function(levelName) {
  console.log("runLevel runs level:", levelName);
  window.game.currentLevel = levelName;
  this.loopCounter = 0;
  console.log("runLevel sets game.loopCounter to", loopCounter);
  removeMenus();
  setSizes();
  window.game.canvas = document.getElementById("canvas");
  console.log("runLevel creates new window.game.canvas:", window.game.canvas);
  console.log(window.game.status);
  if (window.game.status === "start") {
    return startLoop();
  } else {
    return window.game.status = "running";
  }
};

startLoop = function() {
  console.log("startLoop runs");
  window.game.status = "running";
  return setInterval(levelLoop, INTERVAL);
};

levelLoop = function() {
  if (this.loopCounter === 0) {
    levelInitialize(window.game.currentLevel);
  }
  if (window.game.status === "running" || window.game.status === "endLevel") {
    if (window.game.currentLevel === 100) {
      level100();
    }
    this.loopCounter += 1;
    return drawEverything();
  }
};

levelInitialize = function(level) {
  console.log("levelInitialize() runs for", level);
  setSizes();
  if (level === 100) {
    addGameControls();
    return this.towers.push(new FireTower(window.game.center.x, window.game.center.y));
  }
};

level100 = function() {
  if (window.game.status === "endLevel") {
    endGame();
  }
  if (this.loopCounter % (10 * FRAMERATE) === 0) {
    return console.log("level", 100, "is", window.game.status, "at loop", this.loopCounter);
  }
};

endGame = function() {
  console.log("endGame() runs");
  drawEverything();
  window.game.status = "paused";
  this.towers.pop(this.towers.length);
  removeGameControls();
  return addMenus();
};

drawEverything = function() {
  setSizes();
  clearCanvas();
  return drawCollection(towers);
};

drawOne = function(thing) {
  window.game.context.save();
  window.game.context.translate(thing.posX, thing.posY);
  window.game.context.rotate(thing.direction);
  window.game.context.drawImage(thing.image, 0, 0);
  return window.game.context.restore();
};

drawCollection = function(collection) {
  var thing, _i, _len, _results;
  _results = [];
  for (_i = 0, _len = collection.length; _i < _len; _i++) {
    thing = collection[_i];
    _results.push(drawOne(thing));
  }
  return _results;
};

clearCanvas = function() {
  window.game.context.clearRect(0, 0, window.game.canvas.width, window.game.canvas.height);
  return window.game.context.fillStyle = "rgba(0, 255, 0, 1)";
};

toGrid = function(location) {
  return Math.floor(location / 50) * 50;
};

generateTerrain = function() {
  console.log("generateTerrain runs");
  return console.log("generateTerrain error: empty function");
};

Building = (function() {
  function Building(posX, posY) {
    this.posX = toGrid(posX);
    this.posY = toGrid(posY);
    this.bornCycle = window.game.loopCounter;
    this.direction = 0;
  }

  Building.prototype.rotate = function() {
    console.log("tower.rotate is called");
    return console.log("rotate error: empty function");
  };

  return Building;

})();

FireTower = (function(_super) {
  __extends(FireTower, _super);

  function FireTower(posX, posY) {
    this.image = imgBase;
    FireTower.__super__.constructor.call(this, posX, posY);
  }

  return FireTower;

})(Building);

jQuery(function() {
  console.log("$ document ready");
  window.game = {
    loopCounter: 0,
    currentLevel: 0,
    status: "start",
    towers: [],
    movers: [],
    terrain: [],
    controlState: "start",
    canvas: void 0,
    context: void 0
  };
  window.game.canvas = document.getElementById("canvas");
  window.game.context = window.game.canvas.getContext("2d");
  setAlias();
  setSizes();
  addMenus();
  return runTests();
});

setAlias = function() {
  console.log("setAlias() runs");
  this.towers = window.game.towers;
  this.movers = window.game.movers;
  this.terrain = window.game.terrain;
  return this.loopCounter = window.game.loopCounter;
};

runTests = function() {
  var fireTest, testTower;
  console.log("runTests() runs");
  console.log("");
  console.log("testing: game object creation");
  console.log(window.game !== void 0);
  console.log(window.game.constructor === Object);
  console.log(window.game.canvas.constructor === HTMLCanvasElement);
  console.log(window.game.status === "start", "game initializes with game.status == start");
  console.log("");
  console.log("testing: runLevel");
  this.loopCounter = 1;
  window.game.status = "running";
  runLevel();
  console.log(this.loopCounter === 0, "loopCounter is reset to 0");
  console.log("");
  window.game.status = "start";
  console.log("testing: selectors");
  console.log($('#menu').length > 0, "#menu");
  console.log($('#top-right-panel').length > 0, "#top-right-panel");
  console.log("");
  console.log("testing: endGame()");
  endGame();
  console.log($("#startMenu").length > 0, "endGame restores menus");
  console.log(this.towers[this.towers.length - 1] !== "foo", "endGame clears towers");
  console.log("");
  window.game.status = "start";
  console.log("testing: setAlias");
  console.log(this.towers === window.game.towers, "tower alias");
  console.log(this.terrain === window.game.terrain, "terrain alias");
  console.log(this.terrain === window.game.terrain, "movers alias");
  console.log(this.loopCounter === window.game.loopCounter, "loopCounter alias");
  console.log("");
  console.log("testing: image object creation");
  console.log(imgBase.constructor === Image);
  console.log(imgBase.src !== "");
  console.log("");
  console.log("testing setSizes()");
  setSizes();
  console.log(window.game.canvas.width !== void 0);
  console.log(window.game.canvas.height !== void 0);
  console.log(window.game.canvas.width === $(window).width());
  console.log(window.game.canvas.height === $(window).height(), "height definition = current height");
  console.log(window.game.canvas.height, $(window).height(), "heights");
  console.log("");
  console.log("testing: toGrid()");
  console.log(toGrid(0) === 0);
  console.log(toGrid(1) === 0);
  console.log(toGrid(50) === 50);
  console.log(toGrid(51) === 50);
  console.log(toGrid(999999999999999) === 999999999999950);
  console.log(toGrid(-1) === -50);
  console.log(toGrid(-51) === -100);
  console.log("");
  console.log("testing: draw()");
  console.log(window.game.canvas.constructor === HTMLCanvasElement, "canvas exists");
  console.log(window.game.context.constructor === CanvasRenderingContext2D, "context exists");
  console.log("");
  console.log("testing: towers collection");
  testTower = {
    posX: 0,
    posY: 0,
    image: imgBase
  };
  window.game.towers.push(testTower);
  console.log(towers === window.game.towers);
  console.log(towers[this.towers.length - 1].posX === 0);
  console.log(towers[this.towers.length - 1].image.src === "file:///Users/jonathan/gdrive/CODE/little-lost-lander/images/icon_18231.svg");
  console.log("");
  window.game.towers.pop(1);
  console.log("testing: class FireTower");
  fireTest = new FireTower(51, 1);
  console.log(fireTest.image === imgBase);
  console.log(fireTest.posX === 50);
  console.log(fireTest.posY === 0);
  return console.log("");
};
