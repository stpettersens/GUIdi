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
using build

class GaudiUILogic {
	Str getGaudiInfo() {
		return "version information"	
	}
	Void invokeCommand(Str command) {
		// ...
	}
}
 
class GaudiUIWindow {
	static Void main() {
		GaudiUILogic logic := GaudiUILogic()
		Window {
			title = "GUIdi user interface"
			size = Size(600, 500)
			{
				
			}
		}.open
	}
}

