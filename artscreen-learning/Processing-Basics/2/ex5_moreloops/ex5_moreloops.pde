/* makes a grid of circles
 * using nested for loops
 */
size(1000, 1000);

// nested loops
// https://processing.org/reference/for.html
for (int x=0; x<=40; x++) { 
  // making columns
  for (int y=0; y<=40; y++) { 
    ellipse(10+x*20, 10+y*20, 20, 20);
  }
}  