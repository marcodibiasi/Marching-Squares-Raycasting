class Ray{
  float phi;
  PVector pos;
  PVector dir;
  PVector point;
  boolean intersect;
  
  Ray(PVector pos, float phi){
      this.phi = phi;
      this.pos = pos;
      this.dir = PVector.fromAngle(phi);
      this.point = new PVector();
      this.intersect = false;
  }
  
  void display(){
    pushMatrix();
    strokeWeight(1);
    stroke(255, 0, 0); //<>//
    translate(this.pos.x, this.pos.y);
    line(0, 0, this.dir.x*1000, this.dir.y*1000);
    popMatrix();
  }
  
  void resolve_collision(PVector[] boundaries){
    PVector closest = new PVector();
    float finalx, finaly;
    for(int i=0; i<boundaries.length-1; i+=2){
      //first wall points
      final float x1 = boundaries[i].x;
      final float y1 = boundaries[i].y;
      
      //second wall points
      final float x2 = boundaries[i+1].x;
      final float y2 = boundaries[i+1].y;
      
      //first ray points
      final float x3 = this.pos.x;
      final float y3 = this.pos.y;
      
      //second ray points
      final float x4 = this.pos.x+this.dir.x;
      final float y4 = this.pos.y+this.dir.y;
      
      //resolve collision
      final float denominator = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4);
      if(denominator == 0) return;
      
      final float t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4)) / denominator;
      final float u = -((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3)) / denominator;

      if(t>0 && t<1 && u>0){
        finalx = x1+t*(x2-x1);
        finaly = y1+t*(y2-y1);
        this.intersect = true;
        if(dist(this.pos.x, this.pos.y, closest.x, closest.y) > dist(this.pos.x, this.pos.y, finalx, finaly)) {
          closest.x = finalx;
          closest.y = finaly;
          this.point = closest;
        }
      }     
    }
    if(this.intersect) display_collision();
  }
  
  void display_collision(){
    pushMatrix();
    strokeWeight(1);
    stroke(255, 0, 0);
    line(this.pos.x, this.pos.y, this.point.x, this.point.y);
    popMatrix();
  }
  
  void add_rotation(float angle){
    this.dir = PVector.fromAngle(phi+angle);
  }
  
}
