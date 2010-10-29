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
	Void invokeGaudi(Str params) {
		Process gaudi := Process() // via sys::
		gaudi.command = ["gaudi", params]
		//gaudi.out = null
		gaudi.run()
	}
	Void loadFile(Event e, Bool isPlugin) {
		File? openedFile := FileDialog {
			mode := FileDialogMode.openFile
			if(!isPlugin) filterExts = ["build.json", "*.json"]
			else filterExts = ["*.gpod"]
		}.open(e.window)
		// ...
	}
}

class Main {

	Image newIcon := Image(`fan://icons/x32/file.png`)
	Image openIcon := Image(`fan://icons/x32/user.png`)
	
	GaudiUILogic logic := GaudiUILogic()
	Void main() {
		// Invoke Gaudi on run; get version information
		logic.invokeGaudi("-v") 
		Window { 
			title = "GUIdi"
			size = Size(600, 500)
			resizable := false
			menuBar = makeMenuBar
			content = EdgePane
			{
				top = makeToolBar
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
				MenuItem { text = "Load build file"; 
	 				onAction.add |Event e| { 
						logic.loadFile(e, false)
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
				MenuItem { text = "Load plug-in code";
					onAction.add |Event e| {
						logic.loadFile(e, true)
					}
				},
			},
			Menu { text = "Help"; 
				MenuItem { text = "About GUIdi"; 
					onAction.add |Event e| {
						echo("TODO")
					}
				},
			},
		}
	}
	
	**
	** Build the toolbar
	**
	Widget makeToolBar() {
		return ToolBar
		{
			Button { image = newIcon; onAction.add { echo("TODO!") } },
			Button { image = openIcon; onAction.add { echo("TODO!") } },
		}
	}
}

