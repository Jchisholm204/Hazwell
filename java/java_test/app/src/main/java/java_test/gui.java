package java_test;
import java.awt.event.*;
import javax.swing.*;

public class gui {

    JFrame frame;
    JTextField tf;
    JButton button;
    JLabel label;

    gui(){
        frame = new JFrame("Java GUI");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        tf = new JTextField();
        tf.setBounds(50, 50, 200, 20);
        button = new JButton("Update");
        button.setBounds(100, 100, 100, 20);
        label = new JLabel();
        label.setBounds(50, 150, 200, 20);
        frame.add(tf);
        frame.add(button);
        frame.add(label);
        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                label.setText(tf.getText());
            }
        });

        frame.setSize(300, 300);
        frame.setLayout(null);
        frame.setVisible(true);
    }

    public static void main(String[] args){
        new gui();
    }
}
