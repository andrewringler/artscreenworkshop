/*
 * Movement in a grid P_2_1_2_03, 2009
 * by Schmidt, Mainz, Bohnacker, Gross, Laub, Lazzeroni
 * Credits:
 * http://www.generative-gestaltung.de/P_2_1_2_03
 * 
 */


// P_2_1_2_03.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * changing size of circles in a rad grid depending the mouseposition
 * 	 
 * MOUSE
 * position x/y        : module size and offset z
 * 
 * KEYS
 * s                   : save png
 * p                   : save pdf
 */

import processing.opengl.*;
import processing.pdf.*;
import java.util.Calendar;
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import gab.opencv.*;

ArtScreen artScreen;

float tileCount = 20;
color moduleColor = color(0);
int moduleAlpha = 180;
int max_distance = 500; 
float xLoc, yLoc;

void setup() {
  size(1920, 1080, P3D);
  artScreen = new ArtScreen(this, "“Movement in a grid [P_2_1_2_03]” 2009", "by Schmidt, Mainz, Bohnacker, Gross, Laub, Lazzeroni", "Adapated for Art Screen by Andrew Ringler", color(0, 0, 0), color(255, 255, 255));
}

void draw() {
  translate(300, 20);

  background(255);
  noFill();

  stroke(moduleColor, moduleAlpha);
  strokeWeight(3);

  if (artScreen.movementDetected) {
    xLoc = artScreen.maxMotionLocation.x;
    yLoc = artScreen.maxMotionLocation.y;
  }

  for (int gridY=0; gridY<width; gridY+=50) {
    for (int gridX=0; gridX<height; gridX+=50) {

      float diameter = dist(xLoc, yLoc, gridX, gridY);
      diameter = diameter/max_distance * 40;
      pushMatrix();
      translate(gridX, gridY, diameter*5);
      rect(0, 0, diameter, diameter);    //// also nice: ellipse(...)
      popMatrix();
    }
  }
}