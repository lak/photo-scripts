-- I was originally hoping to be able to automatically select all albums, but that proved too
--  complicated. I gave up, and intead have an input list of albums to export. To use this
-- script, create a file, in Unix format, one album per line (with carriage returns), of the
-- albums you want to export.

use script "Photos Utilities"
use scripting additions

on trim_line(this_text, trim_chars, trim_indicator)
	-- 0 = beginning, 1 = end, 2 = both
	set x to the length of the trim_chars
	-- TRIM BEGINNING
	if the trim_indicator is in {0, 2} then
		repeat while this_text begins with the trim_chars
			try
				set this_text to characters (x + 1) thru -1 of this_text as string
			on error
				-- the text contains nothing but the trim characters
				return ""
			end try
		end repeat
	end if
	-- TRIM ENDING
	if the trim_indicator is in {1, 2} then
		repeat while this_text ends with the trim_chars
			try
				set this_text to characters 1 thru -(x + 1) of this_text as string
			on error
				-- the text contains nothing but the trim characters
				return ""
			end try
		end repeat
	end if
	return this_text
end trim_line

on makeFolder(base, tPath)
	set folderPath to quoted form of POSIX path of (base & tPath)
	log folderPath
	do shell script "mkdir -p " & folderPath
end makeFolder

on exportAlbum(theAlbum, folderName)
	my makeFolder(folderName) -- create a folder named (the name of this album) in dest
	export (get media items of album theAlbum) to (folderName as alias)
end exportAlbum

on run
	set baseDir to "/Users/luke/Desktop/Photo Export/" as POSIX file as text -- the destination folder (use a valid path)
	
	tell application "Photos"
		set topFolders to top level folders
		
		-- Make each of the top level folders
		repeat with theFolder in topFolders
			set folderName to the name of theFolder as POSIX file as text
			set folderName to my trim_line(folderName, ":", 0)
			my makeFolder(baseDir, folderName)
		end repeat
	end tell
end run

