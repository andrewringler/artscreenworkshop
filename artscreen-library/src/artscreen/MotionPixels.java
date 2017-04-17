package artscreen;

import java.util.PriorityQueue;

public class MotionPixels {
	private final PriorityQueue<MotionPixel> queue = new PriorityQueue<>();
	
	public void add(MotionPixel motionPixel) {
		queue.add(motionPixel);
		if (queue.size() > 100) {
			queue.remove();
		}
	}
	
	public MotionPixel[] toArray() {
		return queue.toArray(new MotionPixel[queue.size()]);
	}
}
