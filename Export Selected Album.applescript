set dest to "/Users/luke/Desktop/PHOTOS-Albums/" as POSIX file as text -- the destination folder (use a valid path)
tell application "Photos"
	activate
	set l to name of albums
	set albNames to choose from list l with prompt "Select some albums" with multiple selections allowed
	
	if albNames is not false then -- not cancelled 
		repeat with tName in albNames
			set tFolder to dest & tName
			my makeFolder(tFolder) -- create a folder named (the name of this album) in dest  
			export (get media items of album tName) to (tFolder as alias)
		end repeat
	end if
end tell

on makeFolder(tPath)
	do shell script "mkdir -p " & quoted form of POSIX path of tPath
end makeFolder