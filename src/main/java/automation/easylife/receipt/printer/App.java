package automation.easylife.receipt.printer;

import java.io.File;
import java.io.FileNotFoundException;

public class App {

	public static void main(String[] args) {
		Printer printer=new Printer("Laser");
		String path="F:\\xxx\\note.txt";
		File f=new File(path);
		try {
			printer.add(f);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		if(printer.print()){
			System.out.println("Print success.");
		}else{
			System.out.println("Print failed");
		}
	}
}
