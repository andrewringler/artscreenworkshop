package com.andrewringler.artscreenworkshop;

import java.awt.Color;
import java.awt.FlowLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;

public class LoadingScreen {
	public static void showBlankBackdrop() {
		JFrame frame = new JFrame();
		frame.setAlwaysOnTop(false);
		frame.setResizable(false);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setExtendedState(JFrame.MAXIMIZED_BOTH);
		frame.setUndecorated(true);
		
		JPanel newContentPane = new JPanel(new FlowLayout());
		newContentPane.setBackground(Color.black);
		newContentPane.setOpaque(true);
		frame.setContentPane(newContentPane);
		frame.pack();
		
		frame.setVisible(true);
	}
}
