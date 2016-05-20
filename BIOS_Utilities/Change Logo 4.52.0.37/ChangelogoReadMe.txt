ChangeLogo


1 Features:
 This list of features is supported. 
 
a) Extract a Splash Logo
b) Replace a Splash Logo
c) Extract a Small Logo
d) Replace a Small Logo
e) Delete one or both logos (command line only)
f) Extract and replace logos stored in hole (fixed address) files.
g) Add a logo where one is absent or previously deleted (command line only)
h) Modifies the F/w Image without requiring rebuild. 
i) User Friendly Graphical Interface
j) Support Capsule files
k) Added LZMA support
l) Single executable
m) Optional command line operation


2 Supported Operating Systems:

The Change Logo is supported by the following operating systems:

a) Microsoft® Windows® 95
b) Microsoft® Windows® 98
c) Microsoft® Windows® ME
d) Microsoft® Windows® NT4.0
e) Microsoft® Windows® 2000
f) Microsoft® Windows® XP
g) Microsoft® Windows® 2003
h) Microsoft® Windows® Vista


3 Deliverables

a) AMI_ChangeLogo_Guide_NDA.doc
b) ChangeLogo.exe
c) ChangelogoReadMe.txt


4 Component Versions
 Below is a list of the version numbers of the components that make up this release.
 
a) ChangeLogo 		Version 4.40.0025
b) FWLib		version 1.03.0026


5 Compatibility
 Compatible with the FFS Spec (refer to documents FFS_0-9.pdf, FV_0-9.pdf and FvBlock_0-9.pdf)

Compatible with images built with FWBuild 1.16.16 and later that were created using the top-down allocation or ignore compression features.

Compatible with Aptio 3, 4, and 4.5 and later.

Compatible with the Capsule Spec (Capsule_0-9.pdf) with the following limitations:
a) The contents of Capsule Volume and the Firmware Volume File may not be compressed.  The individual firmware volumes contained within the various files within the Firmware Volume File may contain compressed data.
b) The signing section is not modified.

6 Command Line operation

 ChangeLogo begins operation as a console application. When it detects the absence of command line parameters, it relaunches as a windows GUI application.

Command Syntax

a) Logo Extraction

 The extraction operation has the following syntax:

	ChangeLogo /i <firmware file> /e [<logo file>] [/s] [/f]

 Where /s indicates the "small" logo. If /s is not given, then the splash logo is extracted. The program will generate a file extension appropriate for the logo graphic image type (bmp, gif, jpg, or pcx). If no logo file name is given then the program uses base names "smlogo" or "splash". Without the "/f" option the program will refuse to write over an existing file.


b) Logo Replacement

 The replacement operation has the following syntax:

	ChangeLogo /i <input firmware file> /o <output firmware file> /r <logo file> [/s] [/f]


 If the current and replacement files have different graphic image types then the program will issue an error message and terminate. This restriction may be over-ridden by using the "/f" (force) option. If the firmware volume does not have room for the replacement logo, ChangeLogo will issue an error message. Without the "/f" option the program will refuse to write over an existing file. Replace logo will preserve the compression method of the replaced logo.

c) Logo Deletion

Logos may be deleted from an image using the "/d" option:
 
	ChangeLogo /i <input firmware file> /o <output firmware file> /d [/s] [/f]

Note: the GUI version does not have this capability.

d) Logo Addition

	ChangeLogo /i <input firmware file> /o <input firmware file> /a <logo file> [/s] [/f]

 If the logo is already present it is considered an error and you must use the replace operation instead. Firmware volumes are tested until a volume with sufficient room is found. If a volume already contains a logo of a different kind (splash or small), then that volume is tried first. The boot block is not considered for logo insertion. Logos will always be compressed and the program will use the Tiano compression method.

Note: the GUI version does not have this capability.

e) Test for Fit

 A replacement logo file may be tested against an image to see if it will fit:

	ChangeLogo /i <firmware file> /t <logo file>

 If the image will not fit the program will issue an error message. 

f) Report Logo Image Types

	ChangeLogo /i <firmware file> /l


g) Help
	Invalid parameters or  '/?' will issue a usage message.

7. Logos in ROM hole files.

	Hole files have fixed locations and lengths within the ROM image. They are preceded by a protective Firmware File System header which must be of the RAW type. Sixteen firmware file GUID names are reserved for this purpose. ChangeLogo can replace or extract the data from these files. The program will inspect the raw data and attempt to identify the logo type. 

Sixteen GUIDs are defined for ROM hole logos:
	hole0   05ca01fc-0fc1-11dc-9011-00173153eba8	
	Hole1   05ca01fd-0fc1-11dc-9011-00173153eba8
	hole2   05ca01fe-0fc1-11dc-9011-00173153eba8
	hole3   05ca01ff-0fc1-11dc-9011-00173153eba8
	hole4   05ca0200-0fc1-11dc-9011-00173153eba8
	hole5   05ca0201-0fc1-11dc-9011-00173153eba8
	hole6   05ca0202-0fc1-11dc-9011-00173153eba8
	hole7   05ca0203-0fc1-11dc-9011-00173153eba8
	hole8   05ca0204-0fc1-11dc-9011-00173153eba8
	hole9   05ca0205-0fc1-11dc-9011-00173153eba8
	hole10  05ca0206-0fc1-11dc-9011-00173153eba8
	hole11  05ca0207-0fc1-11dc-9011-00173153eba8
	hole12  05ca0208-0fc1-11dc-9011-00173153eba8
	hole13  05ca0209-0fc1-11dc-9011-00173153eba8
	hole14  05ca020a-0fc1-11dc-9011-00173153eba8
	hole15  05ca020b-0fc1-11dc-9011-00173153eba8

Command Syntax

a) Enter GUI mode for holes
	ChangeLogo /h<number>

 The presence of a single parameter "/h0" through "/h15" will cause the program to enter GUI mode. The parameter "/h0" causes the GUI to operate on hole0 as defined above. 

b) Extract ROM hole logo

	ChangeLogo /i <firmware file> /e [<logo file>] /h<number> [/f]

 The program will generate a file extension appropriate for the logo graphic image type (bmp, gif, jpg, or pcx). If no logo file name is given then the program uses base name "splash". Without the "/f" option the program will refuse to write over an existing file. Since ROM hole data is unstructured, the tool always extracts data as-is with no attempt at decompression. 
	

c) Replace ROM hole logo

	ChangeLogo /i <input firmware file> /o <output firmware file> /r <logo file> /h<number> [/f]

If the current and replacement files have different graphic image types then the program will issue an error message and terminate. This restriction may be over-ridden by using the "/f" (force) option. If the firmware volume does not have room for the replacement logo, ChangeLogo will issue an error message. Without the "/f" option the program will refuse to write over an existing file. Since the ROM hole data is unstructured this operation will perform no compression.

d) Report ROM hole logo type

	ChangeLogo /i <input firmware file> /l /h<number>
  
  This command reports the logo type for the selected ROM hole.


8. Command line exit codes
  In command line mode the program returns error exit codes:

EXIT_SYNTAX             1    command line syntax error
EXIT_IMAGE_SAVE_ERROR   2    image save error
EXIT_LOGO_DELETE_ERROR  3    logo delete operation failed
EXIT_LOGO_NOT_FOUND     4    logo(s) not found in image
EXIT_IMAGE_LOAD         5    failed to load image
EXIT_IMAGE_TYPES        6    replacement image type different
EXIT_REPLACE_ERROR      7    replacement operation failed
EXIT_NO_LOGO_FILE       8    logo file does not exist
EXIT_WRITE_PROTECT      9    logo file or image is write protected
EXIT_FILE_EXISTS        10   file would be over written
EXIT_LOGO_TOO_BIG       11   logo does not fit in image
EXIT_NO_FILE            12   file does not exist
EXIT_LOGO_EXISTS        13   insertion would replace existing logo
EXIT_ADD_ERROR          14   add logo failed
EXIT_OTHER              15   unclassified error


9 Known Issues:


a) The user may insert any logo image as desired; however, the logo image must be compatible with the capabilities of the firmware itself.  Check the release notes for the firmware to determine whether a logo image is compatible.

b) This utility support for Capsule files but it is not fully tested, since Aptio does not support capsule files yet. 

c) A command line window will appear briefly when ChangeLogo is invoked from the icon.

d) "REPLACE_ERROR" or "ADD_ERROR" exit codes are returned in cases where the more specific "LOGO_TOO_BIG" should be returned.



10 Changes in this release:

a) Added command line mode.

b) Added logos in hole files.

c) When a logo will not fit into the image, this condition is now detected when the file is inserted. The user is advised and the original image is reloaded.

d) Compatible with volumes allocated from the top down.

e) Compatible with volumes containing more than 256 files.

