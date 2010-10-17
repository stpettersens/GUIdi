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
		gaudi.out = null
		gaudi.run()
	}
	Void loadBuildFile(Event e) {
		FileDialog {
			// TODO: Dialog settings
		}.open(e.window)
	}
}

class Main {
	GaudiUILogic logic := GaudiUILogic()
	Void main() {
		// Invoke Gaudi on run; get version information
		logic.invokeGaudi("-v") 
		Window { title = "GUIdi user interface"
			size = Size(600, 500) // via gfx::
			menuBar = makeMenuBar {
			}
		}.open
	}
	Menu makeMenuBar() {
		return Menu 
		{
			Menu { text = "File";
				MenuItem { text = "Load build file"; 
					onAction.add |Event e| { 
						logic.loadBuildFile(e)
					}
				},
				MenuItem { text = "Exit";
					onAction.add |->| { Env.cur.exit }
				},
			},
			Menu { text = "Help"; 
				MenuItem { text = "About GUIdi"; 
					onAction.add |Event e| {
						Dialog.openInfo(e.window,
						"GUIdi user interface for Gaudi.\n\n" 
						)
					}
				},
			},
		}
	}
}

