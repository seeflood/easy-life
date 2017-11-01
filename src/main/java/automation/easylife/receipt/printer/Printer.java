package automation.easylife.receipt.printer;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.DocAttributeSet;
import javax.print.attribute.HashAttributeSet;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Copies;
import javax.print.attribute.standard.JobName;
import javax.print.attribute.standard.MediaSizeName;
import javax.print.attribute.standard.Sides;

public class Printer {
	// 打印文件的格式
	private DocFlavor fileFormat = DocFlavor.INPUT_STREAM.AUTOSENSE;
	private DocFlavor txtFormat = DocFlavor.INPUT_STREAM.TEXT_PLAIN_UTF_8;

	// The printer
	private PrintService service = null;

	// Actual print attributes
	private PrintRequestAttributeSet attributes;

	// The tasks list
	List<File> list = new ArrayList<>();

	DocAttributeSet docAttributes=new HashDocAttributeSet();
	
	// Default print attributes
	private static PrintRequestAttributeSet defaultAttributes;

	static {
		defaultAttributes = new HashPrintRequestAttributeSet();
		defaultAttributes.add(new Copies(1));
		defaultAttributes.add(MediaSizeName.ISO_A4);
		defaultAttributes.add(Sides.ONE_SIDED);
	}

	/**
	 * Use default printer and default print attributes which means A4 size,one
	 * copy per file and one-side print.
	 */
	public Printer() {
		this.service = PrintServiceLookup.lookupDefaultPrintService();
		if (this.service == null) {
			throw new RuntimeException("Can't find the default printer!");
		}
		this.attributes = defaultAttributes;
	}

	/**
	 * Use the specific printer.
	 * @param printerName
	 */
	public Printer(String printerName) {
		this(printerName, defaultAttributes);
	}

	/**
	 * Use the specific printer and print-attributes.
	 * @param printerName
	 * @param attributes
	 */
	public Printer(String printerName, PrintRequestAttributeSet attributes) {
		HashAttributeSet has = new HashAttributeSet();
		PrintService[] services = PrintServiceLookup.lookupPrintServices(
				fileFormat, has);
		for (int i = 0; i < services.length; i++) {
			String name = services[i].getName();
			if (name != null && name.contains(printerName)) {
				// Get the printer you need!
				this.service = services[i];
				this.attributes = attributes;
				return;
			}
		}
		throw new RuntimeException("Can't find the printer!");
	}

	/**
	 * Add task.
	 * @param f
	 * @return
	 * @throws FileNotFoundException
	 */
	public boolean add(File f) throws FileNotFoundException {
		if(!f.exists()){
			return false;
		}
		list.add(f);
		return true;
	}

	/**
	 * Do printing.
	 * @return
	 */
	public boolean print() {
		if (list == null || list.size() == 0) {
			return false;
		}
		// create a print job
		DocPrintJob job = service.createPrintJob();
		Iterator<File> it = list.iterator();
		while (it.hasNext()) {
			File f=it.next();
			PrintRequestAttributeSet pras = new HashPrintRequestAttributeSet();
            pras.add(new JobName(f.getName(), null));
			try (FileInputStream in= new FileInputStream(f)){
				Doc mydoc = new SimpleDoc(in, txtFormat, null);
				job.print(mydoc, defaultAttributes);
			} catch (PrintException e) {
				e.printStackTrace();
				return false;
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		return true;
	}
	
	/**
	 * Clear the tasks list.
	 */
	public void clear(){
		list.clear();
	}

}
