/*
 *   Автор:                  Downadow (Sviatoslav)
 *   Год создания:           2023.
 *   Год последней записи:   2024.
 * 
 * Данный файл предоставляется вам по лицензии Downadow License 7
 * как "Программное обеспечение".
 * 
 * Эта программа НЕ переводит Makexm2c-код в xm2-код!
 */

package downadow.xmtwolime_builder.main;

import java.util.Scanner;
import java.io.File;

public class Builder {
	public static void main(String[] args) {
		if(args.length == 0 || args[0].equals("--help")) {
			/* напечатать help-сообщение и завершиться */
			System.out.println("Использование: java downadow.xmtwolime_builder.main.Builder [--help]\n"
				+ "                    [-p|--bootrom-etc ПУТЬ_К_КАТАЛОГУ ПУТЬ_К_ИСХОДНИКУ_ЯДРА [-s]]\n"
				+ "                    ПРИЛОЖЕНИЕ…\n"
				+ "\n"
				+ "ПРИЛОЖЕНИЕ должно быть путём к файлу, который содержит исходный код.\n"
				+ "Первые три символа ПРИЛОЖЕНИя после последнего '/' будут командой его вызова.\n"
				+ "\n"
				+ "ПУТЬ_К_КАТАЛОГУ должен быть путём к каталогу, который\n"
				+ "содержит `bootrom.S', `xloader.S', `fastboot.S',\n"
				+ "'recovery.S' и 'system/bootanim.S'\n"
				+ "\n"
				+ "Если задан '-s', то 'ПРИЛОЖЕНИЕ…' не требуется,\n"
				+ "но нужен 'ПУТЬ_К_КАТАЛОГУ/system.S'");
			System.exit(1);
		}
		
		try {
			String pathToBootromEtc = "../etc/xtld110", pathToKernel = "../kernel.S";
			
			// переменные для for
			int i = 0, ii = 0;
			
			/* случайности нет */
			String pkey = "" + new java.util.Random().nextInt(9);
			for(int iii = 0; iii < 11; iii++)
				pkey += new java.util.Random().nextInt(8);
			
			boolean s = false;
			
			if(args[0].equals("-p") || args[0].equals("--bootrom-etc")) {
				pathToBootromEtc = args[1];
				pathToKernel = args[2];
				// получается, что в args[0], args[1] и args[2] у нас не ПРИЛОЖЕНИя!
				i = 3;
				
				if(args[3].equals("-s")) {
					s = true;
					i = 4;
				}
			}
			
			/* сначала выводим текст разделов, ядра... */
			Scanner sc = new Scanner(new File(pathToBootromEtc + "/bootrom.S"));
			while(sc.hasNextLine()) System.out.println(sc.nextLine());
			sc.close();
			sc = new Scanner(new File(pathToBootromEtc + "/xloader.S"));
			while(sc.hasNextLine()) System.out.println(sc.nextLine());
			sc.close();
			sc = new Scanner(new File(pathToBootromEtc + "/fastboot.S"));
			while(sc.hasNextLine()) System.out.println(sc.nextLine());
			sc.close();
			sc = new Scanner(new File(pathToBootromEtc + "/recovery.S"));
			while(sc.hasNextLine()) System.out.println(sc.nextLine());
			sc.close();
			
			System.out.println("info_start:");
			for(int iii = 0; iii < 12; iii++) {
				System.out.println("\tinfo_PKEYCHAR" + iii + "_address:");
				System.out.println("\t\tmov UR0, " + pkey.toCharArray()[iii]);
			}
			
			System.out.println("\tinfo_KEYCHAR0_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[10] + 1 - 48));
			
			System.out.println("\tinfo_KEYCHAR1_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[0] - 48));
			
			System.out.println("\tinfo_KEYCHAR2_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[2] - 48));
			
			System.out.println("\tinfo_KEYCHAR3_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[1] - 48));
			
			System.out.println("\tinfo_KEYCHAR4_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[8] + 1 - 48));
			
			System.out.println("\tinfo_KEYCHAR5_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[8] - 48));
			
			System.out.println("\tinfo_KEYCHAR6_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[7] - 48));
			
			System.out.println("\tinfo_KEYCHAR7_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[6] - 48));
			
			System.out.println("\tinfo_KEYCHAR8_address:");
			if((int)pkey.toCharArray()[0] - 48 < 6)
				System.out.println("\t\tmov UR0, 0");
			else
				System.out.println("\t\tmov UR0, 1");
			
			System.out.println("\tinfo_KEYCHAR9_address:");
			System.out.println("\t\tmov UR0, " + ((int)pkey.toCharArray()[3] + 1 - 48));
			
			System.out.println("\tinfo_BSTATE:");
			System.out.println("\t\tmov UR0, 1");
			
			System.out.println("info_end:");
			System.out.println("\tnop");
			
			sc = new Scanner(new File(pathToKernel));
			while(sc.hasNextLine()) System.out.println(sc.nextLine());
			sc.close();
			if(!s) {
				System.out.println("system_start:");
				sc = new Scanner(new File(pathToBootromEtc + "/system/bootanim.S"));
				while(sc.hasNextLine()) System.out.println(sc.nextLine());
				sc.close();
				/* выводим код сброса нажатой клавиши и стирания '█' */
				System.out.println("\t\t\t\tmov %R_KEY%, 0");
				
				System.out.println("\t\t\t\tvsv %R_ZERO%, UR15");
				System.out.println("\t\t\t\tupdd");
				/* а после уже текст проверки "что за программа, которую хотел
				   запустить пользователь?"                                    */
				for(; i < args.length; i++) {
					char[] filename = args[i].split("/")[args[i].split("/").length - 1].toCharArray();
					
					System.out.println("\t\t\t\t_appChecking" + ii + ":");
					System.out.println("\t\t\t\t\tvld 0002, UR26");
					System.out.println("\t\t\t\t\tvld 0003, UR27");
					System.out.println("\t\t\t\t\tvld 0004, UR28");
					
					System.out.println("\t\t\t\t\tmov2 UR17, <_appChecking" + (ii + 1) + ">");
					
					/* печатать код проверки */
					System.out.println("\t\t\t\t\tmov UR25, " + (int)filename[0]);
					System.out.println("\t\t\t\t\tif UR26 != UR25, UR17");
					
					System.out.println("\t\t\t\t\tmov UR26, " + (int)filename[1]);
					System.out.println("\t\t\t\t\tif UR27 != UR26, UR17");
					
					System.out.println("\t\t\t\t\tmov UR26, " + (int)filename[2]);
					System.out.println("\t\t\t\t\tif UR28 != UR26, UR17");
					
					System.out.println("\t\t\t\t\tmov2 UR17, <_term_applicationCompleted>");
					System.out.println("\t\t\t\t\tmov2 UR25, <" + filename[0] + filename[1] + filename[2] + ">");
					System.out.println("\t\t\t\t\tjmp UR25");
					
					ii++;
				}
				/* напечатать код, который будет исполняться, если команда не найдена */
				System.out.println("\t\t\t\t_appChecking" + ii + ":");
				System.out.println("\t\t\t\t\tvstr %OUT_ST%, \"command not found\"");
				System.out.println("\t\t\t\t\tmov2 UR17, <_term_input>");
				System.out.println("\t\t\t\t\tjmp UR17");
				
				System.out.println();
				
				if(args[0].equals("-p") && !args[3].equals("-s") ||
				   args[0].equals("--bootrom-etc") && !args[3].equals("-s")) i = 3;
				else if(args[0].equals("-p") && args[3].equals("-s") ||
				   args[0].equals("--bootrom-etc") && args[3].equals("-s")) i = 4;
				else i = 0;
				
				/* печатать исходные коды приложений */
				for(; i < args.length; i++) {
					sc = new Scanner(new File(args[i]));
					while(sc.hasNextLine()) System.out.println(sc.nextLine());
					sc.close();
				}
			} else {
				sc = new Scanner(new File(pathToBootromEtc + "/system.S"));
				while(sc.hasNextLine()) System.out.println(sc.nextLine());
				sc.close();
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.exit(2);
		}
	}
}
