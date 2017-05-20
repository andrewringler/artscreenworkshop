/*
 * Delaunay Filter, 2013
 * by Andrew Ringler
 * Credits: Ale González, 
 * 
 * Description:
 *
 Creative Commons Attribution ShareAlike *
 * credits:
 * Ale González
 */

/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/117808*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
//Delaunay filter
//A classic one in my own implementation.
//Ale González, 2013

import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import com.hamoid.*;
import boofcv.processing.*;
import boofcv.struct.image.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.List;
import java.util.LinkedList;

ArtScreen artScreen;
int processedFrameNumber = -1;
final AtomicBoolean isProcessing = new AtomicBoolean(false);

int W, H;
int[] colors;
List<Triangle> triangles;
PImage smallMotionImage;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "“Delaunay Filter” 2013", "by Ale González", "Adapted for Art Screen by Andrew Ringler", color(255), color(0, 1));
}

void draw() {
  performMotionDetection();

  if (artScreen.captureFrameNumber < 5) {
    return; // wait until motion images have stabilized
  }
  if (smallMotionImage == null) {
    smallMotionImage = createImage(int(motionImage.width / 3f), int(motionImage.height / 3f), RGB);
    W = smallMotionImage.width;
    H = smallMotionImage.height;
  }

  // run processing in a separate thread, it can be slow
  if (processedFrameNumber != artScreen.captureFrameNumber && isProcessing.compareAndSet(false, true)) {
    processedFrameNumber = artScreen.captureFrameNumber;
    smallMotionImage.copy(motionImage, 0, 0, motionImage.width, motionImage.height, 0, 0, smallMotionImage.width, smallMotionImage.height); 

    thread("processDelaunay");
  }

  // Scale and display the result
  if (triangles != null) {
    background(0);
    scale((float)width / smallMotionImage.width, (float)height / smallMotionImage.height);
    displayMesh();
  }
}

//Util function to prune triangles with vertices out of bounds  
boolean vertexOutside(PVector v) { 
  return v.x < 0 || v.x > width || v.y < 0 || v.y > height;
}  

//Display the mesh of triangles  
void displayMesh() {
  Triangle t = new Triangle();
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++)
  {
    t = triangles.get(i); 
    fill(colors[i]);
    stroke(colors[i]);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
}  

void processDelaunay() {
  //Extract significant points of the picture
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  EdgeDetector.extractPoints(vertices, smallMotionImage, EdgeDetector.SOBEL, 300, 4);

  //Add some points in the border of the canvas to complete all space
  for (float i = 0, h = 0, v = 0; i<=1; i+=.05, h = W*i, v = H*i) {
    vertices.add(new PVector(h, 0));
    vertices.add(new PVector(h, H));
    vertices.add(new PVector(0, v));
    vertices.add(new PVector(W, v));
  }

  //Get the triangles using qhull algorithm. 
  //The algorithm is a custom refactoring of Triangulate library by Florian Jennet (a port of Paul Bourke... not surprisingly... :D) 
  List<Triangle> newTriangles = new ArrayList<Triangle>();
  new Triangulator().triangulate(vertices, newTriangles);

  //Prune triangles with vertices outside of the canvas.
  Triangle t = new Triangle();
  for (int i=0; i < newTriangles.size(); i++) {
    t = newTriangles.get(i); 
    if (vertexOutside(t.p1) || vertexOutside(t.p2) || vertexOutside(t.p3)) newTriangles.remove(i);
  }

  //Get colors from the triangle centers
  int tSize = newTriangles.size();
  int[] newColors = new int[tSize*3];
  PVector c = new PVector();
  for (int i = 0; i < tSize; i++) {
    c = newTriangles.get(i).center();
    newColors[i] = smallMotionImage.get(int(c.x), int(c.y));
  }

  triangles = newTriangles;
  colors = newColors;

  isProcessing.set(false);
}