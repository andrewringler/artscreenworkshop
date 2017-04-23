import org.opencv.core.Size;
import org.opencv.core.MatOfRect;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.core.Mat;

/**
 * Detect objects using the cascade classifier. loadCascade() must already
 * have been called to setup the classifier. See the OpenCV documentation
 * for details on the arguments: http://docs.opencv.org/java/org/opencv/objdetect/CascadeClassifier.html#detectMultiScale(org.opencv.core.Mat, org.opencv.core.MatOfRect, double, int, int, org.opencv.core.Size, org.opencv.core.Size)
 * 
 * A simpler version of detect() that doesn't need these arguments is also available.
 * 
 * @param scaleFactor
 * @param minNeighbors
 * @param flags
 * @param minSize
 * @param maxSize
 * @return
 *     An array of java.awt.Rectangle objects with the location, width, and height of each detected object.
 */
public Rectangle[] detect(OpenCV opencv, double scaleFactor, int minNeighbors, int flags, Size minSize, Size maxSize) {
  MatOfRect detections = new MatOfRect();
  opencv.classifier.detectMultiScale(getCurrentMat(opencv), detections, scaleFactor, minNeighbors, flags, minSize, maxSize);

  return OpenCV.toProcessing(detections.toArray());
}

private Mat getCurrentMat(OpenCV opencv) {
  //  return opencv.matROI;
  // return opencv.matBGRA;
  return opencv.matGray;
}