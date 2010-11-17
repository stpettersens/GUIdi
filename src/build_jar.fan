/*
	Fantom build file to create the GUIdi JAR 
	for distribution
*/
using build

class Build : BuildScript {
	@Target { help = "Build GUIdi pod as a JAR" }
	Void distGUIdi() {
		dist := JarDist(this)
		dist.outFile = `./GUIdi.jar`.toFile.normalize
		dist.podNames = Str["concurrent", "gfx", "fwt", "GUIdi"]
		dist.mainMethod = "GUIdi::Main.main"
		dist.run
	}
}

