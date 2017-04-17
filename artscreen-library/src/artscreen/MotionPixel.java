package artscreen;

import processing.core.PVector;

public class MotionPixel implements Comparable<MotionPixel> {
	public final PVector location;
	public final byte changeAmount;
	
	public MotionPixel(PVector location, byte changeAmount) {
		this.location = location;
		this.changeAmount = changeAmount;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + changeAmount;
		result = prime * result + ((location == null) ? 0 : location.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MotionPixel other = (MotionPixel) obj;
		if (changeAmount != other.changeAmount)
			return false;
		if (location == null) {
			if (other.location != null)
				return false;
		} else if (!location.equals(other.location))
			return false;
		return true;
	}
	
	@Override
	public int compareTo(MotionPixel o) {
		return Byte.valueOf(o.changeAmount).compareTo(changeAmount);
	}
}
