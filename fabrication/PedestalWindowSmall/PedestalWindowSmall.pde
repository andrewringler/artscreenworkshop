/* generates a laser cut file
 * for the large window that is cut into the pedestal
 * holding the projector
 *
 * large hole 14.75x17.5    (plus hand holds & hole for cord)
 * small hole 14.75x6.75   (plus hand holds)
 *
 */
import processing.svg.*;
import java.util.*;
import java.awt.Polygon;
import java.awt.Rectangle;
import java.awt.geom.*;

int MARGIN_TB = 100;
int MARGIN_LR = 150;
int OFFSET = 20;
float DPI = 72;
int W = int(14.75 * DPI);
int H = int(6.75 * DPI);
int NUM_TRIANGLES = 18;
float triangleSize = 200;
float minDimension = 100; 

List<Triangle> triangles = new ArrayList<Triangle>();

void settings() {
  size(W + 2*OFFSET, H + 2*OFFSET);
}  

void setup() {
  beginRecord(SVG, "export/smallwindow.svg");
  translate(OFFSET, OFFSET);

  background(255);
  strokeWeight(1);
  stroke(255, 0, 0);
  noFill();

  // draw cut outline
  rect(0, 0, W, H, 5);
  
  // draw hand holds
  rect(-5, H/2.0 - 400/2.0, 100, 400, 5); // left
  rect(W-95, H/2.0 - 400/2.0, 100, 400, 5); // right
  
  // create shapes
  while (triangles.size() < NUM_TRIANGLES) {
    // slowly decrease our triangle size to fill in spaces
    triangleSize = triangleSize > 30 ? triangleSize - 0.1 : 30;
    minDimension = minDimension > 15 ? minDimension - 0.4 : 15;

    println("trying");
    float x1 = random(MARGIN_LR, W-MARGIN_LR);
    float y1 = random(MARGIN_TB, H-MARGIN_TB);
    float x2 = constrain(x1 + random(-triangleSize, triangleSize), MARGIN_LR, W-MARGIN_LR);
    float y2 = constrain(y1 + random(-triangleSize, triangleSize), MARGIN_TB, H-MARGIN_TB);
    float x3 = constrain(x1 + random(-triangleSize, triangleSize), MARGIN_LR, W-MARGIN_LR);
    float y3 = constrain(y1 + random(-triangleSize, triangleSize), MARGIN_TB, H-MARGIN_TB);

    Triangle t = new Triangle(x1, y1, x2, y2, x3, y3);

    // ensure triangle is large enough, so we aren't laser cutting lines    
    if (t.minDimension() < minDimension) {
      continue;
    }

    // ensure no overlaps
    boolean intersects = false;
    for (Triangle other : triangles) {
      println("looking for intersection");
      if (t.intersects(other)) {
        intersects = true;
        break;
      }
    }
    if (!intersects) {
      triangles.add(t);
      println("added triangle");
    }
  }

  // draw shapes
  for (Triangle t : triangles) {
    shape(t.toPShape());
  }

  endRecord();
  exit();
}

class Triangle {
  Point2D.Float[] vertices;
  Polygon polygon;

  public Triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    vertices = new Point2D.Float[] {
      new Point2D.Float(x1, y1), 
      new Point2D.Float(x2, y2), 
      new Point2D.Float(x3, y3) 
    };

    polygon = new Polygon();
    for (int i=0; i<vertices.length; i++) {
      polygon.addPoint((int)vertices[i].x, (int)vertices[i].y);
    }
  }

  boolean intersects(Triangle other) {
    Area a1 = new Area(polygon);
    a1.intersect(new Area(other.polygon));
    return !a1.isEmpty();
  }

  PShape toPShape() {
    PShape ps = createShape();
    ps.beginShape();
    for (int i=0; i<vertices.length; i++) {
      ps.vertex(vertices[i].x, vertices[i].y);
    }
    ps.endShape(CLOSE);

    return ps;
  }

  // https://stackoverflow.com/questions/25987465/computing-area-of-a-polygon-in-java
  double area() {
    double sum = 0;
    for (int i = 0; i < vertices.length; i++)
    {
      if (i == 0)
      {
        System.out.println(vertices[i].x + "x" + (vertices[i + 1].y + "-" + vertices[vertices.length - 1].y));
        sum += vertices[i].x * (vertices[i + 1].y - vertices[vertices.length - 1].y);
      } else if (i == vertices.length - 1)
      {
        System.out.println(vertices[i].x + "x" + (vertices[0].y + "-" + vertices[i - 1].y));
        sum += vertices[i].x * (vertices[0].y - vertices[i - 1].y);
      } else
      {
        System.out.println(vertices[i].x + "x" + (vertices[i + 1].y + "-" + vertices[i - 1].y));
        sum += vertices[i].x * (vertices[i + 1].y - vertices[i - 1].y);
      }
    }

    double area = 0.5 * Math.abs(sum);
    return area;
  }

  float minDimension() {
    float minDim = Float.MAX_VALUE;
    for (int a=0; a<vertices.length; a++) {
      for (int b=0; b<vertices.length; b++) {
        if (b!=a) {
          for (int p=0; p<vertices.length; p++) {
            if (p!=b && p!=a) {
              float dist = pointToLineDistance(vertices[a], vertices[b], vertices[p]);
              if (dist < minDim) {
                minDim = dist;
              }
            }
          }
        }
      }
    }
    return minDim;
  }
}

// http://www.ahristov.com/tutorial/geometry-games/point-line-distance.html
float pointToLineDistance(Point2D.Float A, Point2D.Float B, Point2D.Float P) {
  float normalLength = sqrt((B.x-A.x)*(B.x-A.x)+(B.y-A.y)*(B.y-A.y));
  return abs((P.x-A.x)*(B.y-A.y)-(P.y-A.y)*(B.x-A.x))/normalLength;
}