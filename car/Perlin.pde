class Perlin{
  int scale;
  int [][] matrix;
  int dimx, dimy;
  boolean generated = false;
  float z;
  int w, h;
  
  Perlin(int scale, int w, int h){
    this.w = w;
    this.h = h;
    this.scale = scale;
    this.dimx = (w/scale) + 1;
    this.dimy = (h/scale) + 1;
    this.matrix = new int[dimx][dimy];
    this.z = 0;
  }
  
  void generate_vector(){
    generated = true;
    for(float x=0; x<this.w+1; x+=this.scale){
      for(float y=0; y<this.h+1; y+=this.scale){
          matrix[int(x/this.scale)][int(y/this.scale)] = round(noise(x/200, y/200));
      }
    } 
  }
  
  void display(){
    if(!generated) {
      println("Warning!: Matrix not generated");
      return;
    }
  
    strokeWeight(3);
     for(int x=0; x<matrix.length; x++){
      for(int y=0; y<matrix[0].length; y++){
        //color c = int(map(matrix[x][y], 0, 1, 0, 255));
        color c = matrix[x][y];
        stroke(c*255);
        point(x*this.scale, y*this.scale);    
      }
    }
  }
  
  void update(float offset){
    this.z += offset;
    for(float x=0; x<this.w+1; x+=this.scale){
      for(float y=0; y<this.h+1; y+=this.scale){
          matrix[int(x/this.scale)][int(y/this.scale)] = round(noise((x/200), (y/200), this.z)); //<>//
      }
    }
    
  }
  
  void run(){
      generate_vector();
      display();
  }

}
