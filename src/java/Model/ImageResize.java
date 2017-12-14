/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.imageio.ImageIO;

/**
 *
 * @author Bhagya
 */
public class ImageResize {

    public static String resize(String inputImagePath, String outputImagePath, int scaledWidth, int scaledHeight) throws IOException {
        // reads input image
        File inputFile = new File(inputImagePath);
        BufferedImage inputImage = ImageIO.read(inputFile);
        BufferedImage outputImage = new BufferedImage(scaledWidth,
                scaledHeight, inputImage.getType());
        Graphics2D g2d = outputImage.createGraphics();
        g2d.drawImage(inputImage, 0, 0, scaledWidth, scaledHeight, null);
        g2d.dispose();
        String formatName = outputImagePath.substring(outputImagePath
                .lastIndexOf(".") + 1);
        ImageIO.write(outputImage, formatName, new File(outputImagePath));

        FileInputStream imageInFile = new FileInputStream(new File(outputImagePath));
        byte imageData[] = new byte[(int) new File(outputImagePath).length()];
        imageInFile.read(imageData);
        String s = imageData.toString();
        return s;
    }
    
    public static String resize(String inputImagePath) throws IOException {
        File inputFile = new File(inputImagePath);
        BufferedImage inputImage = ImageIO.read(inputFile);
        int scaledWidth = (int) (inputImage.getWidth() * 0.5);
        int scaledHeight = (int) (inputImage.getHeight() * 0.5);
        String a = resize(inputImagePath, "C://Users//Bhagya//Desktop//Mobile Viva//Projectssale.com//src//java//imgresize//abc.jpg", scaledWidth, scaledHeight);
        return a;
    }
}
