use script "Photos Utilities"
use scripting additions

on makeFolder(base, tPath)
	set folderPath to quoted form of POSIX path of base & "Testing"
	log folderPath
	do shell script "mkdir -p " & folderPath
end makeFolder

on run
	set baseDir to "/Users/luke/Desktop/Photo Export/" as POSIX file as text -- the destination folder (use a valid path)
	
	tell application "Photos"
		set topFolders to top level folders
		log topFolders
		repeat with theFolder in topFolders
			set folderName to the name of theFolder
			my makeFolder(baseDir, "Testing")
		end repeat
	end tell
end run

