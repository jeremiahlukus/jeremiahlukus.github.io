const PADDLE_HEIGHT = 100;
const PADDLE_THICKNESS = 10;
const WINNING_SCORE = 3;
var canvas;
var canvasContext;
var ballX = 750;
var ballSpeedX = 20;
var ballY = 50;
var ballSpeedY = 4;

var paddle1Y = 250;
var paddle2Y = 250;

var player1Score = -1;
var player2Score = 0;

function draw() {
  computerMovement();
  //background
  colorRect(0, 0, canvas.width, canvas.height, "black");
  drawNet();
  //left paddle
  colorRect(0, paddle1Y, PADDLE_THICKNESS, PADDLE_HEIGHT, "white");
  // right paddle
  colorRect(
    canvas.width - PADDLE_THICKNESS,
    paddle2Y,
    PADDLE_THICKNESS,
    PADDLE_HEIGHT,
    "white"
  );
  // 100px from left,  200px from top and size of rec is 50 by 25
  makeBall(ballX, ballY, 10, "white");
  canvasContext.fillText(player1Score, 100, 100);
  canvasContext.fillText(player2Score, canvas.width - 100, 100);
}

function drawNet(){
  for(var i = 0; i < canvas.height; i += 40){
    colorRect(canvas.width/2-1, i , 2, 20, 'white')
  }
}

function computerMovement() {
  var paddle2YCenter = paddle2Y + PADDLE_HEIGHT / 2;
  if (paddle2Y < ballY - 35) {
    paddle2Y += 10;
  } else if (paddle2YCenter > ballY + 35) {
    paddle2Y -= 10;
  }
}

function move() {
  ballX += ballSpeedX;
  ballY += ballSpeedY;
  if (ballX > canvas.width) {
    if (ballY > paddle2Y + 10 && ballY < paddle2Y + 10 + PADDLE_HEIGHT) {
      ballSpeedX = -ballSpeedX;
      var deltaY = ballY - (paddle2Y + PADDLE_HEIGHT / 2);
      ballSpeedY = deltaY * 0.35;
    } else {
      player1Score++;
      ballReset();
    }
  }
  if (ballX < 0) {
    if (ballY > paddle1Y +20 && ballY < paddle1Y + 20 + PADDLE_HEIGHT) {
      ballSpeedX = -ballSpeedX;
      var deltaY = ballY - (paddle1Y + PADDLE_HEIGHT / 2);
      ballSpeedY = deltaY * 0.35;
    } else {
      player2Score++;
      ballReset();
    }
    //ballSpeedX = -ballSpeedX;
  }
  if (ballY > canvas.height) {
    ballSpeedY = -ballSpeedY;
  }
  if (ballY < 0) {
    ballSpeedY = -ballSpeedY;
  }
}

function makeBall(centerX, centerY, radius, color) {
  canvasContext.fillStyle = color;
  canvasContext.beginPath();
  canvasContext.arc(centerX, centerY, radius, 0, Math.PI * 2, true);
  canvasContext.fill();
}

function ballReset() {
  if (player1Score === WINNING_SCORE) {
    alert("\t PLAYER 1 WINS!! \n " + player1Score + " to " + player2Score);
    player1Score = 0;
    player2Score = 0;
  }
  if (player2Score === WINNING_SCORE) {
    alert("\t PLAYER 2 WINS!! \n     " + player2Score + " to " + player1Score);
    player1Score = 0;
    player2Score = 0;
  }

  ballSpeedX = -ballSpeedX;
  ballX = canvas.width / 2;
  ballY = canvas.height / 2;
}

function colorRect(leftX, topY, width, heigh, drawColor) {
  canvasContext.fillStyle = drawColor;
  canvasContext.fillRect(leftX, topY, width, heigh, drawColor);
}

function calculateMousePosition(evt) {
  var rect = canvas.getBoundingClientRect();
  var root = document.documentElement;
  var mouseX = evt.clientX - rect.left - root.scrollLeft;
  var mouseY = evt.clientY - rect.top - root.scrollTop;

  return {
    x: mouseX,
    y: mouseY
  };
}

window.onload = function() {
  canvas = document.getElementById("gameCanvas");
  canvasContext = canvas.getContext("2d");
  var framesPerSecond = 30;
  setInterval(function() {
    draw();
    move();
  }, 1000 / framesPerSecond);

  canvas.addEventListener("mousemove", function(evt) {
    var mousePos = calculateMousePosition(evt);
    paddle1Y = mousePos.y - PADDLE_HEIGHT / 2;
  });
};
