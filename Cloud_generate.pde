ArrayList particles;
PImage sky;
PImage imgMask;
void setup()
{
  fullScreen();
  frameRate(60);
  rectMode(CENTER);
  noStroke();
    imgMask = loadImage("housemask2.png"); //map

  sky = createImage(width, height, RGB);     //creating the background colour
  for(int i = 0; i < width; i++)
  {
    for(int j = 0; j < height; j++)
    {
      sky.pixels[i + j * width] = lerpColor(#157ABC, #F4E69D, (float)j/height);  //hex colours, can edit
    }
    
      sky.mask(imgMask); //mask the imagmask (the black and white image of the house map) from the sky so ther sky doesnt go over the house
  
  }
  restart();
}



void restart()
{
  particles = new ArrayList();
  background(sky); //image just created is the new bacground 
}
void mouseReleased()
{
  particles.add(new Particle(mouseX, mouseY, 50, color(255), 12)); //add small white particles when mouse clicked
}
void keyReleased()
{
  if(key == 32) //if space is pressed, clear all the clouds
    restart();
  else
    filter(BLUR);  //blur the particles to look like clouds
}


void draw()
{
  for(int i = 0; i < particles.size(); i++)
  {
    Particle p = (Particle) particles.get(i);
    if(p.alive)
    {
      p.drawParticle();
      p.reproduce();
    }
    else
      particles.remove(i);
  }
}
 
class Particle
{
  PVector position;
  float oppacity;
  float w;
  color clr;
  boolean alive;
   
  protected Particle(float x, float y, float wth, color c, float o)
  {
    position = new PVector(x, y);
    w = wth;
    clr = c;
    oppacity = o;
    alive = true;
  }
   
  public void reproduce()
  {
    if(w > 1)
    {
      for(int i = 0; i < 2; i++)
      {
        float newX = position.x + random(-w, w);
        float newY = position.y + random(-w/2, w/4);
        float r = random(10);
        float newW = w - r;
        if(newW < 1)
          newW = 1;
        particles.add(new Particle(newX, newY, newW, clr, oppacity));
        alive = false;
      }
    }
  }
   
  public void drawParticle()
  {
    fill(clr, oppacity);
    ellipse(position.x, position.y, w, w);
  }
}