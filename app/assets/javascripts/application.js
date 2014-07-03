// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require foundation
$(function(){ $(document).foundation(); });

var P = null;
var O = null;
var N = null;
var G = null;

var PONG = {
  P1UP: false,
  P1DOWN: false,
  P2UP: false,
  P2DOWN: false,
  P1: null,
  P2: null,
  P1SCORE: 0,
  P2SCORE: 0,
  PADDLEWIDTH: 25,
  PADDLEHEIGHT: 100,
  PADDLESPEED: 16,
  PADDLEMARGIN: 20,
  BALL: null,
  BALLWIDTH: 15,
  BALLHEIGHT: 15,
  BALLSPEED: 15,
  BALLX: 0,
  BALLY: 0,
  RANDOMBALLGO: function() {
    PONG.BALL.css({
      left: PONG.WINDOWWIDTH/2 - PONG.BALLWIDTH/2 + 'px',
      top: PONG.WINDOWHEIGHT/2 - PONG.BALLHEIGHT/2 + 'px'
    });
    if (Math.random() < 0.5) {
      PONG.BALLX = -PONG.BALLSPEED;
    } else {
      PONG.BALLX = PONG.BALLSPEED;
    }
    
    if (Math.random() < 0.5) {
      PONG.BALLY = PONG.BALLSPEED;
    } else {
      PONG.BALLY = -PONG.BALLSPEED;
    }
  },
  WINDOWWIDTH: 900,
  WINDOWHEIGHT: 600,
  DELTATIME: 20
};

function doPONG() {
  PONG.P1 = document.createElement('p');
  PONG.P1 = $(PONG.P1);
  PONG.P2 = document.createElement('p');
  PONG.P2 = $(PONG.P2);
  
  PONG.P1.css({
    position: 'fixed',
    width: PONG.PADDLEWIDTH + 'px',
    height: PONG.PADDLEHEIGHT + 'px',
    left: PONG.PADDLEMARGIN + 'px',
    top: PONG.WINDOWHEIGHT/2 - PONG.PADDLEHEIGHT/2 + 'px',
    backgroundColor: 'white',
    border: '2px solid black',
    textAlign: 'center',
    verticalAlign: 'middle'
  });
  
  PONG.P2.css({
    position: 'fixed',
    width: PONG.PADDLEWIDTH + 'px',
    height: PONG.PADDLEHEIGHT + 'px',
    left: PONG.WINDOWWIDTH - PONG.PADDLEWIDTH - PONG.PADDLEMARGIN +'px',
    top: PONG.WINDOWHEIGHT/2 - PONG.PADDLEHEIGHT/2 + 'px',
    backgroundColor: 'white',
    border: '2px solid black',
    textAlign: 'center',
    verticalAlign: 'middle'
  });
  
  var keyDownHandler = function(event) {
    switch (String.fromCharCode(event.which)) {
      case 'Q':
        PONG.P1UP = true;
        break;
      case 'A':
        PONG.P1DOWN = true;
        break;
      case 'P':
        PONG.P2UP = true;
        break;
      case 'L':
        PONG.P2DOWN = true;
        break;
    }
  }
  
  var keyUpHandler = function(event) {
    switch (String.fromCharCode(event.which)) {
      case 'Q':
        PONG.P1UP = false;
        break;
      case 'A':
        PONG.P1DOWN = false;
        break;
      case 'P':
        PONG.P2UP = false;
        break;
      case 'L':
        PONG.P2DOWN = false;
        break;
    }
  }
  
  $(document).on("keydown", keyDownHandler);
  $(document).on("keyup", keyUpHandler);
  
  PONG.BALL = document.createElement('p');
  PONG.BALL = $(PONG.BALL);
  
  PONG.BALL.css({
    position: 'fixed',
    width: PONG.BALLWIDTH,
    height: PONG.BALLHEIGHT,
    backgroundColor: 'white',
    border: '2px solid black'
  });
  
  
  background = document.createElement('p');
  background = $(background);
  background.css({
    position: 'fixed',
    top: '0px',
    left: '0px',
    backgroundColor: 'black',
    width: PONG.WINDOWWIDTH + 'px',
    height: PONG.WINDOWHEIGHT + 'px'
  });
  
  background.append(PONG.P1).append(PONG.P2).append(PONG.BALL);
  $('body').append(background);
  
  PONG.RANDOMBALLGO();
  
  var game = function() {
    bp = PONG.BALL.position();
    p1p = PONG.P1.position();
    p2p = PONG.P2.position();
    
    if (bp.top < 0) {
      PONG.BALLY = PONG.BALLSPEED;
    } else if (bp.top + PONG.BALLHEIGHT > PONG.WINDOWHEIGHT) {
      PONG.BALLY = -PONG.BALLSPEED;
    }
    
    if (bp.left < 0) {
      PONG.P2SCORE += 1;
      PONG.P2.text(PONG.P2SCORE.toString());
      PONG.RANDOMBALLGO();
    } else if (bp.left + PONG.BALLWIDTH > PONG.WINDOWWIDTH) {
      PONG.P1SCORE += 1;
      PONG.P1.text(PONG.P1SCORE.toString());
      PONG.RANDOMBALLGO();
    } else if (bp.left < PONG.PADDLEMARGIN + PONG.PADDLEWIDTH) {
      if (bp.top + PONG.BALLHEIGHT > p1p.top &&
          bp.top < p1p.top + PONG.PADDLEHEIGHT) {
        PONG.BALLX = PONG.BALLSPEED;
        if (PONG.P1UP) {
          PONG.BALLY = -PONG.BALLSPEED;
        } else if (PONG.P1DOWN) {
          PONG.BALLY = PONG.BALLSPEED;
        }
      }
    } else if (bp.left > p2p.left) {
      if (bp.top + PONG.BALLHEIGHT > p2p.top &&
          bp.top < p2p.top + PONG.PADDLEHEIGHT) {
        PONG.BALLX = -PONG.BALLSPEED;
        if (PONG.P2UP) {
          PONG.BALLY = -PONG.BALLSPEED;
        } else if (PONG.P2DOWN) {
          PONG.BALLY = PONG.BALLSPEED;
        }
      }
    }
    
    PONG.BALL.stop();
    PONG.P1.stop();
    PONG.P2.stop();
    
    PONG.BALL.animate({
      left: '+=' + PONG.BALLX + 'px',
      top: '+=' + PONG.BALLY + 'px'
    }, PONG.DELTATIME);
    
    if (PONG.P1UP) {
      PONG.P1.animate({
        top: '-=' + PONG.PADDLESPEED
      }, PONG.DELTATIME);
    } else if (PONG.P1DOWN) {
      PONG.P1.animate({
        top: '+=' + PONG.PADDLESPEED
      }, PONG.DELTATIME);
    }
    
    if (PONG.P2UP) {
      PONG.P2.animate({
        top: '-=' + PONG.PADDLESPEED
      }, PONG.DELTATIME);
    } else if (PONG.P2DOWN) {
      PONG.P2.animate({
        top: '+=' + PONG.PADDLESPEED
      }, PONG.DELTATIME);
    }
    
    window.setTimeout(game, PONG.DELTATIME);
  }
  
  window.setTimeout(game, PONG.DELTATIME);
}

function gHandler(event) {
  if (String.fromCharCode(event.which) == 'g') {
    if (G == null) {
      G = true;
      $(document).off("keypress", pHandler);
      doPONG();
    }
  }
}

function nHandler(event) {
  if (String.fromCharCode(event.which) == 'n') {
    if (N == null) {
      N = window.setTimeout(function() {
        $(document).off("keypress", gHandler);
        N = null;
      }, 500);
      $(document).on("keypress", gHandler);
    }
  }
}

function oHandler(event) {
  if (String.fromCharCode(event.which) == 'o') {
    if (O == null) {
      O = window.setTimeout(function() {
        $(document).off("keypress", nHandler);
        O = null;
      }, 500);
      $(document).on("keypress", nHandler);
    }
  }
}

function pHandler(event) {
  if (String.fromCharCode(event.which) == 'p') {
    if (P == null) {
      P = window.setTimeout(function() {
        $(document).off("keypress", oHandler);
        P = null;
      }, 500);
      $(document).on("keypress", oHandler);
    }
  }
}

$(document).ready(function() {
  $(document).on("keypress", pHandler);
});