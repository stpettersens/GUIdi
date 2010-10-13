/*
	Fantom build file to create the GUIdi pod
*/
using build

class Build : build::BuildPod {
	new make() {
		podName = "GUIdi"
		summary = "Graphical user interface for Gaudi"
		depends = ["sys 1.0+", "fwt 1.0+"]
		srcDirs = [`fan/`]
		resDirs = [`res/`]
	}
	@Target { help = "Compile GUIdi from source" }
	Void compile() { log.info("Compiling GUIdi...") }
	@Target { help = "Clean up files generated during build" }
	Void clean() { log.info("Cleaning generated files...") }
}

