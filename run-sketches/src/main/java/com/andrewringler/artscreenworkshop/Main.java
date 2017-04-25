package com.andrewringler.artscreenworkshop;

import static com.andrewringler.artscreenworkshop.LoadingScreen.showBlankBackdrop;

import java.awt.AWTException;
import java.awt.Dimension;
import java.awt.Robot;
import java.awt.Toolkit;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.Arrays;

import javax.swing.SwingUtilities;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.ExecuteException;
import org.apache.commons.exec.ExecuteWatchdog;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
	private static final Logger LOG = LoggerFactory.getLogger(Main.class);
	private static final int SKETCH_TIMEOUT_MILLIS = 1 * 60 * 1000;
	private static final int SKETCH_WATCHDOG_KILL_MILLIS = SKETCH_TIMEOUT_MILLIS + 5000;
	private DefaultExecutor executor;
	
	public Main(File currentDirectory) {
		executor = new DefaultExecutor();
		
		// http://stackoverflow.com/questions/5125242/java-list-only-subdirectories-from-a-directory-not-files
		String[] sketches = currentDirectory.list(new FilenameFilter() {
			@Override
			public boolean accept(File current, String name) {
				return new File(current, name).isDirectory();
			}
		});
		Arrays.sort(sketches);
		for (String sketch : sketches) {
			try {
				LOG.info("running " + sketch);
				
				File sketchPath = new File(currentDirectory, sketch);
				if (sketchPath.exists()) {
					String line = "processing-java" + " --sketch=\"" + sketchPath.getPath() + "\" --present nopreview " + SKETCH_TIMEOUT_MILLIS;
					CommandLine cmdLine = CommandLine.parse(line);
					
					ExecuteWatchdog watchdog = new ExecuteWatchdog(SKETCH_WATCHDOG_KILL_MILLIS);
					executor.setWatchdog(watchdog);
					
					int exitStatus = executor.execute(cmdLine);
					if (exitStatus != 0) {
						LOG.error("error exit code of " + exitStatus + "running sketch" + sketch);
					}
				} else {
					LOG.error("ooops directory is missing " + sketchPath.getPath());
				}
			} catch (ExecuteException e) {
				LOG.error("Unable to run sketch " + sketch, e);
			} catch (IOException e) {
				LOG.error("Unable to run sketch " + sketch, e);
			}
		}
	}
	
	public static void main(String args[]) {
		try {
			System.setProperty("com.apple.macos.useScreenMenuBar", "true");
			System.setProperty("apple.laf.useScreenMenuBar", "true"); // for older versions of Java
			showBlankBackdrop();
		} catch (Exception e) {
			// ok
		}
		
		while (true) {
			try {
				// move the mouse cursor out of the way
				// for those brief moments when our splash screen is up
				try {
					SwingUtilities.invokeAndWait(new Runnable() {
						@Override
						public void run() {
							Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
							try {
								new Robot().mouseMove((int) screenSize.getWidth(), (int) screenSize.getHeight());
							} catch (AWTException e) {
								// ignore
							}
						}
					});
				} catch (Exception e) {
					// ignore
				}
				
				File currentDirectory;
				if (args.length == 1) {
					currentDirectory = new File(args[0]);
				} else {
					currentDirectory = new File(System.getProperty("user.dir"));
				}
				new Main(currentDirectory);
			} catch (Exception e) {
				LOG.error("Unknown error, lets wait and retry", e);
				try {
					Thread.sleep(5000);
				} catch (InterruptedException ie) {
				}
			}
		}
	}
}
