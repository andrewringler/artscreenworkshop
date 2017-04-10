package com.andrewringler.artscreenworkshop;

import static com.andrewringler.artscreenworkshop.LoadingScreen.showBlankBackdrop;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.Arrays;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.ExecuteException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
	private static final Logger LOG = LoggerFactory.getLogger(Main.class);
	private DefaultExecutor executor;
	
	public Main(File currentDirectory) {
		executor = new DefaultExecutor();
		
		//		Runtime.getRuntime().addShutdownHook(new Thread() {
		//			public void run() {
		//				CommandLine cmdLine = CommandLine.parse("");
		//				try {
		//					executor.execute(cmdLine);
		//				} catch (ExecuteException e) {
		//					LOG.error("Unable to run kill sketches", e);
		//				} catch (IOException e) {
		//					LOG.error("Unable to run kill sketches", e);
		//				}
		//			}
		//		});
		
		showBlankBackdrop();
		
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
				String line = "processing-java" + " --sketch=\"" + sketchPath.getPath() + "\" --present live 60000";
				CommandLine cmdLine = CommandLine.parse(line);
				int exitStatus = executor.execute(cmdLine);
				if (exitStatus != 0) {
					LOG.error("error exit code of " + exitStatus + "running sketch" + sketch);
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
		} catch (Exception e) {
			// ok
		}
		
		while (true) {
			try {
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
