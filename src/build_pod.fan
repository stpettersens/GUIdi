/*
	Fantom build file to create the GUIdi pod
*/
using build

class Build : BuildPod {
	new make() {
		podName = "GUIdi"
		summary = "Graphical user interface for Gaudi"
		depends = ["sys 1.0+", "concurrent 1.0+", "gfx 1.0+", "fwt 1.0+"]
		srcDirs = [`fan/`]
		resDirs = [`icons/`]
	}
}

