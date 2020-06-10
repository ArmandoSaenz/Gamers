//********************************************************
// AUTHOR: JOSE ARMANDO SAENZ ESQUEDA
// DATE: JUNE 09 2020 
// PROJECT: MY FIRST NGAME
//********************************************************

//Libraries
import processing.sound.*;
//Public Variables
float x=0, y=0;
float yp=0,ypp=50, xb=0,yb=0;
int a,b;
int diameter = 75;
float theta=0;
enum Limite {Bottom,Top,Left, Right,End,None};
Limite LLimite = Limite.None;
Limite ALimite;
int score;
boolean play = true;
SoundFile file;
void setup()
{
  fullScreen(P2D);
  x = (int)random(diameter,width-diameter);
  y = diameter/2;
  yb=height-100;
  a = width/5;
  b = 25;
  file = new SoundFile(this, "pingpong.mp3");
}

void draw()
{
  textSize(32);
  if(!play)
  {
    text("\t GAME OVER \r \n PRESS Y TO CONTINUE", width/2-00, height/2);
    return;
  }
  background(0);
  ellipseMode(CENTER);
  rectMode(CENTER);
  text("POINTS: " + str(score), width/2-100, height-35); 

  ellipse(x,y,diameter,diameter);
  rect(xb,yb,a,b);
  xb = mouseX;
  yp = yp + ypp*1/60;
  y = y + yp*1.0/60.0*cos(theta);
  x = x + yp*1.0/60.0*sin(theta);
  delay(1/60);
  ALimite = Bump();
  if(LLimite == ALimite)
  {
    return;
  }
  LLimite = ALimite;
  switch(ALimite)
  {
    
    case Bottom:
    file.play();
    if(sin(theta)==0)
    {
      if(x<xb)
        theta -= radians(120);
      else
        theta += radians(120);
        score++;
        break;
    }
    if(sin(theta)<0)
    {
      theta -= PI/2; 
    }
    if(sin(theta)>0)
    {
      theta += PI/2; 
    }
    score++;
    break;
    
    case Top:
    file.play();
    if(sin(theta)<0)
    {
      theta += PI/2; 
    }
    else
    {
      theta -= PI/2; 
    }
    break;
    
    case Left:
    file.play();
    if(cos(theta)<0)
    {
      theta -= PI/2; 
    }
    else
    {
      theta += PI/2; 
    }
    break;
    
    case Right:
    file.play();
    if(cos(theta)<0)
    {
      theta += PI/2; 
    }
    else
    {
      theta -= PI/2; 
    }
    break;
    
    case End:
      play=false;
    break;
  }
}

void keyPressed()
{
  if(!play && (keyCode == 'Y' || keyCode == 'y'))
  {
    play = true;
    x = (int)random(diameter,width-diameter);
    y = diameter/2;
    yp = 0;
    score = 0;
    theta=0;
  }
}

Limite Bump()
{
  if((yb-y)<=diameter/2 && (x+diameter/2)>=(xb-a/2) && (x-diameter/2)<=(xb+a/2))
  {
    return Limite.Bottom;
  } 
  if((yb-(y+diameter/2)<=-b))
  {
    return Limite.End;
  }

  if((width - x)<=diameter/2)
  {
    return Limite.Right;
  }
  if(x<=diameter/2)
  {
    return Limite.Left;
  }
   if(y<=diameter/2)
  {
    return Limite.Top;
  }
  return Limite.None;
}
