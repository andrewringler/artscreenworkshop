void setup() {
  size(100, 500);
}

void draw() {
  // "for" loop
  // https://processing.org/reference/for.html
  for (int i=0; i<4; i++) { 
    ellipse(20, 20+(i*19), 15, 15);
    println(i); // means print line
  }

  // Processing is sort of generating this code
  // for us:
  //ellipse(20, 20+(0*19), 15, 15);
  //ellipse(20, 20+(1*19), 15, 15);
  //ellipse(20, 20+(2*19), 15, 15);
  //ellipse(20, 20+(3*19), 15, 15);


  // note:
  // i++ means i=i+1, programers call that "syntactic sugar"
  // https://processing.org/reference/increment.html
}