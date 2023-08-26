package java_test;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;

public class gui {
    public static void main(String[] args){
        JFrame frame = new JFrame("First GUI");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JButton button1 = new JButton("Button1");
        button1.setBounds(50, 100, 95, 30);
        frame.add(button1);
        button1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                button1.setBackground(Color.blue);    
            }
        });
        frame.setSize(300, 300);
        frame.setLayout(null);
        frame.setVisible(true);
    }
}
