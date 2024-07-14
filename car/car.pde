Perlin controller_p;
MarchingSquares ms;
Caster c1;
Render r;
PVector[] boundaries;
int scale, rays;

void setup() {
  size(1600, 800);
  
  scale = 2;
  rays = 200;
  controller_p = new Perlin(scale, width/2, height);
  controller_p.generate_vector();
  c1 = new Caster(new PVector(width/4, height/2), rays, 30);
  ms = new MarchingSquares(controller_p.matrix, scale);
  r = new Render(rays, width/2, width/2);
  ms.calculate_boundaries();
}

void draw() {
  background(0, 0, 0);
  
  //controller_p.display(); 
  boundaries = ms.points.toArray(new PVector[ms.points.size()]);
  ms.display();
  //controller_p.update(0.02);
   
   
  //for(PVector p: ms.points){
  //  strokeWeight(5);
  //  stroke(255);
  //  point(p.x, p.y);
  //} 
    
  //c1.show_rays();
  c1.resolve_collision(boundaries);
  c1.rotate_view(map(mouseX, width/2, width, -180, 180));
  c1.display();
  
  pushMatrix();
  fill(0);
  stroke(255);
  strokeWeight(1);
  //rect(width/2, -1, width, height);
  popMatrix();
  
  
  r.display(c1.distances);
  
}

void keyPressed(){
  if(key=='w' || key=='W') c1.move(0, -5);
  if(key=='a' || key=='A') c1.move(-5, 0);
  if(key=='s' || key=='S') c1.move(0, 5);
  if(key=='d' || key=='D') c1.move(5, 0);
}
