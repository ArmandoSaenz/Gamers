int xs[],ys[];
int large=10;
int _size;
int num;
int m1,m2;
int dt=500;
IntList dir = new IntList();
int pointX, pointY;
int tmpDir;
int LastDir;
boolean gover = false;
void setup()
{
  size(810,610,P2D);
  num = 80*60;
  xs = new int[num];
  ys = new int[num];
  m1=millis();
  Initialize();
}

void draw()
{
  m2 = millis()-m1;
  if(gover)
  {
    fill(255,255,0);
    text("\t GAME OVER \r \n SCORE: " + str(_size-3) + "\r \n PRESS Y TO CONTINUE", width/2-00, height/2);
    return;
  }
  if(m2<=dt)
  {
    return;
  }
  m1 = millis();
  background(0);
  if(dir.size()>0)
  {
    LastDir = dir.get(0);
    dir.remove(0);
  }
  for(int i = _size-1; i>=0;i--)
  {
    if(i!=0)
    {
      xs[i] = xs[i-1];
      ys[i] = ys[i-1];
    }
    else
    {
      switch(LastDir)
      {
        case UP:
            ys[i] -= 10; //<>//
          break;
        case DOWN:
            ys[i] += 10;
          break;
        case LEFT:
        case 0:
            xs[i] -= 10;
          break;
        case RIGHT:
            xs[i] += 10;
          break;
      }
      if(xs[i]<0)
        xs[i] = 795;
        
      if(xs[i]>800)
        xs[i] = 5;
        
      if(ys[i]<0)
        ys[i] = 595;
       
      if(ys[i]>600)
        ys[i] = 5;
    }
  }
  fill(0,0,255);
  square(xs[0],ys[0],large);
  fill(255);
  for(int i = 1; i<_size; i++)
  {
    if(xs[i]==xs[0] && ys[i]==ys[0])
    {
      gover = true;
      continue; //<>//
    }
    square(xs[i],ys[i],large);
  }
  if(pointX==xs[0] && pointY==ys[0])
  {
    do
    {
    pointX = (int)random(0,79)*10+5;
    pointY = (int)random(0,59)*10+5;
    }
    while(pointX==xs[0] ||pointY==ys[0]);
    _size++;
    if(dt>50)
    {
      dt-=20;
    }
  }
  fill(0,255,0);
  square(pointX,pointY,large);
}

void keyPressed()
{
  if(dir.size()==0)
  {
    tmpDir = LastDir;
  }
  else
  {
    tmpDir = dir.get(dir.size()-1); //<>//
  }
  if(((tmpDir==LEFT || tmpDir==0) && keyCode!=RIGHT) || (tmpDir==RIGHT && keyCode!=LEFT) || (tmpDir==UP && keyCode!=DOWN) || (tmpDir==DOWN && keyCode!=UP))
  {
    dir.append(keyCode);
    println(dir);
  }
  if((keyCode == 'Y' || keyCode == 'y') && gover)
      Initialize();
}

void Initialize()
{
  xs[0] = (int)random(0,79)*10+5;
  ys[0] = (int)random(0,59)*10+5;
  xs[1] = xs[0]+large;
  ys[1] = ys[0];
  xs[2] = xs[1]+large;
  ys[2] = ys[1];
  do
  {
    pointX = (int)random(0,79) * 10 + 5;
    pointY = (int)random(0,59) * 10 + 5;
  }
  while(pointX==xs[0] ||pointY==ys[0]);
  _size=3;
  gover = false;
  LastDir = LEFT;
}
