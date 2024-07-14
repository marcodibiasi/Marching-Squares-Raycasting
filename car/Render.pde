class Render{
  float[] distances;
  int scale, block_w, start_s;
  Render(int scale, int scene_w, int start_s){
    this.scale = scale;
    this.block_w = scene_w/scale;
    this.start_s = start_s;
    this.distances = new float[scale];
  }
  
  void display(float[] distances){
    this.distances = distances;
    
    rectMode(CENTER);
    pushMatrix();
    noStroke();
    for(int i=0; i<this.scale; i++){
      float c = map(distances[i], 0, width/4, 210, 0);
      fill(c);
      float h = map(distances[i], 0, width/4, height, 0);
      rect(this.start_s+(i*this.block_w+this.block_w/2), height/2, this.block_w, h);
    }
    popMatrix();
  }
}
