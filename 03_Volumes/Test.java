// alias docker-here='docker run --rm -ti -v ${PWD}:${PWD} -w ${PWD} '
// docker-here openjdk:11 javac Test.java
// docker-here openjdk:11 java -cp . Test
// docker-here openjdk:12 java -cp . Test

import java.io.IOException;

public class Test {
	
	public static void main(String[] args) {
		try {
			System.getProperties().store(System.out, "System properties");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
