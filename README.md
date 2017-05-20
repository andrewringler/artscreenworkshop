# artscreenworkshop
Sketchs and scripts for the Art Screen Workshop. See <https://artscreenworkshop.org/>

## Contents
### artscreen-learning-v___
Lots of Processing and Art Screen examples. For use during the workshops or by experienced Processing programmmers. Users can download the latest stable version zipped from <https://artscreenworkshop.org/>.

### artscreen-library
A Processing library written for the art screen. Handles setting up the webcam, mirroring sketches for rear-projection, saving frames for documentation, quitting sketches automatically after 60-seconds.

### inprogress-sketches
Staging area for experiments and sketches not read to go live yet.

### live-sketches
Repository of all the Processing sketches I have uploaded to the Art Screen that are stable and live.

### run-sketches
A Java script that handles reading a directory containing Processing sketches and running them in turn. Loops forever.




## Art Screen Computer Setup

## Video Export
Video export relies on the Video Export library for Processing. <https://github.com/hamoid/video_export_processing>

To export video you need to:
   * Install the Video Export library in Processing
	 * Install ffmpeg
	 
Once you have done the above, run one of their examples. This will generate a default settings.json file, placed in the Video Export folder in your Processing libraries folder.

Update it to the following:

	{
	"encode_video": "[ffmpeg] -vsync 0 -use_wallclock_as_timestamps 1 -y -f rawvideo -vcodec rawvideo -s [width]x[height] -pix_fmt rgb24 -re -i - -an -vcodec h264 -pix_fmt yuv420p -crf [crf] -metadata comment=[comment] [output]",
	"encode_audio": "[ffmpeg] -y -i [inputvideo] -i [inputaudio] -filter_complex [1:0]apad -shortest -vcodec copy -acodec aac -b:a [bitrate]k -metadata comment=[comment] -strict -2 [output]",
	"ffmpeg_path": "/usr/local/bin/ffmpeg"
	}
	
The main setting we are changing is insuring that timing of the output video matches a wall-clock. IE, no matter how fast or slow the sketch runs the final video will be 1 minute long.

The make a Sketch record video, place a artscreen-settings.txt file in the data directory of your sketch with the word savevideo on a single line.
