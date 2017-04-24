/** 


* waving lines 
Waves

 
by
Falko
Sternberg
code from

@author aa_debdeb 
@date 2016/03/27
March 30th, 2016   Creative Commons Attribution ShareAlike


* 

* @author aa_debdeb 

* @date 2016/03/27 

*/ 



//void mousePressed(){ 

//  saveFrame("images/image.jpg"); 

//} 


float noiseW, noiseH, noiseT; 


void setup(){ 


  size(800, 400);   

  stroke(0, 166, 180, 100); 

  strokeWeight(190); 


 // fill(0,100, 120, 100); 
noFill();

    


  noiseW = random(100); 


  noiseH = random(100); 


  noiseT = random(100); 


} 


  


void draw(){ 


  background(0); 


  float t = frameCount * 0.0005; 


  for(float h = -1000; h < height + 1000; h += 72){ 


    beginShape(); 


    curveVertex(0, h + getNoise(0, h, t)); 


    for(float w = 0; w <= width; w += 10){ 


      curveVertex(w, h + getNoise(w, h, t)); 


    } 


    curveVertex(width, h + getNoise(width, h, t)); 


    endShape(); 


  }  


} 


  


float getNoise(float w, float h, float t){ 


  return map(noise(noiseW + w * 0.001, noiseH + h * 0.001, noiseT + t), 0, 1, -100, 1000); 


} 