class Caster{
  PVector pos;
  int rays_n;
  float FOV;
  ArrayList<Ray> rays;
  float[] distances;
  
  Caster(PVector pos, int rays_n, float FOV){
    this.pos = pos;
    this.rays_n = rays_n;
    this.FOV = FOV;
    this.rays = new ArrayList<Ray>();
    this.distances = new float[rays_n+1];
    this.generate_rays();
  }
  
  void display(){
    pushMatrix();
      stroke(0, 255, 0);
      strokeWeight(20);
      point(this.pos.x, this.pos.y);
    popMatrix();
  }
  
  private void generate_rays(){
    float r_FOV = radians(FOV);
    for(float phi = 0; phi<r_FOV; phi+=r_FOV/this.rays_n){
      rays.add(new Ray(this.pos, phi));
    }
  }
  
  void show_rays(){
    for(Ray r: rays){
        r.display();
    }
  }
  
  void resolve_collision(PVector[] boundaries){
    int index = 0;
    for(Ray r: rays){
      r.resolve_collision(boundaries);
      if(r.intersect) {
        this.distances[index] = dist(r.pos.x, r.pos.y, r.point.x, r.point.y);
      } else this.distances[index] = 3.40282347E+38;
      index++;
    }
  }
  
  void move(float xacc, float yacc){
    this.pos.x+=xacc;
    this.pos.y+=yacc;
    for(Ray r: rays){
      r.intersect=false;
    }
  }
  
  void rotate_view(float rotation){
    for(Ray r: rays){
        r.add_rotation(radians(rotation));
        r.intersect=false;
    }
    
  }
}
