
package downadow.xmtwolime_builder.main;

import java.util.Scanner;
import java.io.File;

public class Builder {
	public static void main(String[] args) {
		if(args.length == 0 || args[0].equals("--help")) {
			/* напечатать help-сообщение и завершиться */
			System.out.println("Использование: java downadow.xmtwolime_builder.main.Builder [--help]\n"
				+ "                    ПУТЬ_К_БИОСУ ПУТЬ_К_ЯДРУ ПРИЛОЖЕНИЕ…\n");
			System.exit(1);
		}
		
		String apps_str = "";
		try {
			
			/* сначала выводим текст БИОСа и ядра */
			Scanner sc = new Scanner(new File(args[0]));
			while(sc.hasNextLine()) System.out.println(sc.nextLine());
			sc.close();
			System.out.println("\n.orig 4096");
			sc = new Scanner(new File(args[1]));
			while(sc.hasNextLine()) System.out.println(sc.nextLine());
			sc.close();
			
			System.out.println("system_start:");
			/* выводим код сброса нажатой клавиши и стирания '█' */
			System.out.println("\t\t\t\tmov %R_KEY%, 0");
			
			System.out.println("\t\t\t\tvsv %R_ZERO%, UR15");
			System.out.println("\t\t\t\tupdd");
			/* а после уже текст проверки "что за программа, которую хотел
			   запустить пользователь?"                                    */
			int ii = 0;
			for(int i = 2; i < args.length; i++) {
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
				
				apps_str += "" + filename[0] + filename[1] + filename[2] + ":<" + filename[0] + filename[1] + filename[2] + ">;";
				
				ii++;
			}
			/* напечатать код, который будет исполняться, если команда не найдена */
			System.out.println("\t\t\t\t_appChecking" + ii + ":");
			System.out.println("\t\t\t\t\tvstr %OUT_ST%, \"command not found\"");
			System.out.println("\t\t\t\t\tmov2 UR17, <_term_input>");
			System.out.println("\t\t\t\t\tjmp UR17");
			
			System.out.println();
			
			/* печатать исходные коды приложений */
			for(int i = 2; i < args.length; i++) {
				sc = new Scanner(new File(args[i]));
				while(sc.hasNextLine()) System.out.println(sc.nextLine());
				sc.close();
			}
			
			System.out.println("system_apps:");
			System.out.println(".goto +" + (apps_str.replace("<", "000").length() + 1));
			System.out.println(".ascii <system_apps> \"" + apps_str.replace('"', '_') + "\"");
			
			System.out.println("system_appsEnd:");
			System.out.println("nop");
		} catch(Exception e) {
			e.printStackTrace();
			System.exit(2);
		}
	}
}
