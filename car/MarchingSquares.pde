class MarchingSquares{
  int[][] matrix;
  int scale;
  PVector north;
  PVector east;
  PVector south;
  PVector west;
  ArrayList<PVector> points; 
  
  MarchingSquares(int[][] matrix, int scale){
    this.matrix = matrix;
    this.scale = scale;
    points = new ArrayList<PVector>();
  }
  
  void calculate_boundaries(){
    for(int x=0; x<this.matrix.length-1; x++){
      for(int y=0; y<this.matrix[0].length-1; y++){
         int a = matrix[x][y];
         int b = matrix[x][y+1];
         int c = matrix[x+1][y+1];
         int d = matrix[x+1][y];
         int resolved_case = resolve_case(a, b, c, d);
         
         this.west = new PVector((x*this.scale)+this.scale/2, y*this.scale);
         this.south = new PVector((x*this.scale)+this.scale, (y*this.scale)+this.scale/2);
         this.east = new PVector((x*this.scale)+this.scale/2, (y*this.scale)+this.scale);
         this.north = new PVector(x*this.scale, (y*this.scale)+this.scale/2);
         this.populate(north, east, south, west, resolved_case);
      }
    }
  }
  
  void populate(PVector north, PVector east, PVector south, PVector west, int case_num){
    switch(case_num){
      case 0: 
      case 15:
        break;
      case 1:
        this.points.add(west);
        this.points.add(south);
        break;
      case 2:
        this.points.add(south);
        this.points.add(east);
        break;
      case 3:
      case 12:
        this.points.add(east);
        this.points.add(west);
        break;
      case 4:
      case 11:
        this.points.add(north);
        this.points.add(east);
        break;
      case 5:
        this.points.add(north);
        this.points.add(west);
        this.points.add(south);
        this.points.add(east);
        break;
      case 6:
      case 9:
        this.points.add(north);
        this.points.add(south);
        break;
      case 7:
      case 8:
        this.points.add(north);
        this.points.add(west);
        break;
      case 10:
        this.points.add(north);
        this.points.add(east);
        this.points.add(south);
        this.points.add(west);
        break;
      case 13:
        this.points.add(east);
        this.points.add(south);
        break;
      case 14:
        this.points.add(west);
        this.points.add(south);
        break;
    }
  }
  
  void display(){
    stroke(255);
    strokeWeight(1);
    for(int i=0; i<this.points.size()-1;i+=2){
      float x1 = this.points.get(i).x;
      float y1 = this.points.get(i).y;
      float x2 = this.points.get(i+1).x;
      float y2 = this.points.get(i+1).y;
      line(x1, y1, x2, y2);
    }
  }
  
  private int resolve_case(int a, int b, int c, int d){
    return (a*8) + (b*4) + (c*2) + (d*1);
  }
}
