/*
GUIdi graphical user interface for Gaudi build tool
Copyright 2010 Sam Saint-Pettersen.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

For dependencies, please see LICENSE file.
*/
using gfx
using fwt

**
** Separate class just for one method, because main() has to be static for
** compatibility with JarDist
**
class Main {
	static Void main() {
		GaudiUI ui := GaudiUI()
	}
}

class GaudiUI {
	**
	** Define tool bar button icons
	**
	Image openIcon := Image(`fan://GUIdi/icons/open-file.png`)
	Image buildIcon := Image(`fan://GUIdi/icons/build.png`)
	Image prefsIcon := Image(`fan://GUIdi/icons/prefs.png`)
	Image pluginsIcon := Image(`fan://GUIdi/icons/plugins.png`)
	Image helpIcon := Image(`fan://GUIdi/icons/help.png`)
	
	**
	** Define important globals
	**
	Label workArea := Label { text = "" }
	Str filePath := ""
	Bool fileIsLoaded := false
	
	**
	** Constructor: Construct the window
	**
	new make() {
		Window {
			title = "GUIdi"
			size = Size(500, 500)
			menuBar = makeMenuBar()
			content = EdgePane
			{
				top = makeToolBar()
				center = workArea
			}
		}.open
	}
	
	**
	** Invoke Gaudi program with applicable parameters
	**
	Str invokeGaudi(Str action) {
		Buf gbuff := Buf()
		Process gaudi := Process() {
			command = ["gaudi", "-f", filePath, action]
			out = gbuff.out
		} 
		gaudi.run.join
		return gbuff.flip.readAllStr
	}
	
	**
	** Get Gaudi program version
	**
	Str getGaudiVersion() {
		Buf gbuff := Buf()
		Process gaudi := Process() {
			command = ["gaudi", "-v"]
			out = gbuff.out
		}
		gaudi.run.join
		return gbuff.flip.readAllStr
	}
	
	**
	** Load a Gaudi build file
	** i.e. Get the path to a Gaudi build file
	**
	Void loadFile(Event e) {
		File? openedFile := FileDialog {
			mode := FileDialogMode.openFile
		    filterExts = ["build.json", "*.json"]
		}.open(e.window)
		if(openedFile != null) {
			filePath = openedFile.osPath
			fileIsLoaded = true
		}
	}
	
	**
	** Build target 
	**
	Void buildTarget(Str action) {
		if(fileIsLoaded) output2WorkArea(invokeGaudi(action))
		else output2WorkArea("No build file is loaded.")
	}

	**                                                                                                                             
	** Build the menu bar
	**
	Menu makeMenuBar() {
		return Menu 
		{
			Menu { text = "File";
				MenuItem { text = "Open build file"; 
	 				onAction.add |Event e| { 
	 					loadFile(e)
					}
				},
				MenuItem { text = "Exit";
					onAction.add |->| { Env.cur.exit }
				},
			},
			Menu { text = "Build";
				MenuItem { text = "Run build action";
					onAction.add |Event e| {
						invokeGaudi("")
					}
				},
			},
			Menu { text = "Plug-ins";
				MenuItem { text = "List installed plug-ins";
					onAction.add |Event e| {
						// ...
					}
				},
			},
			Menu { text = "Help"; 
				MenuItem { text = "About GUIdi"; 
					onAction.add |Event e| {
						showAbout(e)
					}
				},
			},
		}
	}
	
	**
	** Build the tool bar
	**
	Widget makeToolBar() {
		return ToolBar {
			Button { image = openIcon; onAction.add |Event e| { loadFile(e) } },
			Button { image = buildIcon; onAction.add |Event e| { buildTarget("build") } },
			Button { image = pluginsIcon; onAction.add |Event e| { } },
			Button { image = prefsIcon; onAction.add |Event e| { } },
			Button { image = helpIcon; onAction.add |Event e| { } },
		}
	}
	
	**
	** Output to the working text area
	**
	Void output2WorkArea(Str message) {
		workArea.text = message
	}
	
	**
	** About dialog for GUIdi
	**
	 Void showAbout(Event e) {
		// Invoke Gaudi; get program information string
		Str gaudiInfo := getGaudiVersion()
		Dialog.openInfo(
		e.window, "GUIdi, a graphical user interface for the Gaudi build tool.\n" 
		+ "Copyright (c) 2010 Sam Saint-Pettersen.\n" +
		"\nThis software is licensed under the Apache License v2.0.\n\n" + gaudiInfo)
	}
}

