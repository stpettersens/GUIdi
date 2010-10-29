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

class GaudiUILogic {
	Str invokeGaudi(Str params) {
		Buf gbuff := Buf()
		Process gaudi := Process() {
			command = ["gaudi", params]
			out = gbuff.out
		}
		gaudi.run.join
		return gbuff.flip.readAllStr
	}
	Void loadFile(Event e) {
		File? openedFile := FileDialog {
			mode := FileDialogMode.openFile
		    filterExts = ["build.json", "*.json"]
		}.open(e.window)
		if(openedFile != null) {
			// TODO: Load file	
		}
	}
}

class Main {
	Image newIcon := Image(`fan://GUIdi/icons/new-file.png`)
	Image openIcon := Image(`fan://GUIdi/icons/open-file.png`)
	Image saveIcon := Image(`fan://GUIdi/icons/save-file.png`)
	Image buildIcon := Image(`fan://GUIdi/icons/build.png`)
	Image prefsIcon := Image(`fan://GUIdi/icons/prefs.png`)
	Image pluginsIcon := Image(`fan://GUIdi/icons/plugins.png`)
	Image helpIcon := Image(`fan://GUIdi/icons/help.png`)
	GaudiUILogic logic := GaudiUILogic()
	Void main() {
		Window { 
			title = "GUIdi"
			size = Size(600, 500)
			menuBar = makeMenuBar
			content = EdgePane
			{
				top = makeToolBar
				center = makeTextArea
			}
		}.open
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
						logic.loadFile(e)
					}
				},
				MenuItem { text = "Exit";
					onAction.add |->| { Env.cur.exit }
				},
			},
			Menu { text = "Build";
				MenuItem { text = "Run build action";
					onAction.add |Event e| {
						logic.invokeGaudi("build.json")
					}
				},
			},
			Menu { text = "Plugins";
				MenuItem { text = "List plug-ins";
					onAction.add |Event e| {
						logic.loadFile(e)
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
			Button { image = newIcon; onAction.add |Event e| { } },
			Button { image = openIcon; onAction.add |Event e| { logic.loadFile(e) } },
			Button { image = saveIcon; onAction.add |Event e| { } },
			Button { image = buildIcon; onAction.add |Event e| { } },
			Button { image = pluginsIcon; onAction.add |Event e| { } },
			Button { image = prefsIcon; onAction.add |Event e| { } },
			Button { image = helpIcon; onAction.add |Event e| { } },
		}
	}
	
	**
	** Build the text area
	**
	Widget makeTextArea() {
		return Text {
			text = ""
		}
	}
	
	**
	** About dialog for GUIdi
	**
	Void showAbout(Event e) {
		// Invoke Gaudi; get program information string
		Str gaudiInfo := logic.invokeGaudi("-v")
		Dialog.openInfo(
		e.window, "GUIdi, a graphical user interface for the Gaudi build tool.\n" +
		"Copyright (c) 2010 Sam Saint-Pettersen.\n\n" + gaudiInfo)
	}
}

