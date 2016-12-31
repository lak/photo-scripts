-- I was originally hoping to be able to automatically select all albums, but that proved too
--  complicated. I gave up, and intead have an input list of albums to export. To use this
-- script, create a file, in Unix format, one album per line (with carriage returns), of the
-- albums you want to export.

use script "Photos Utilities"
use scripting additions

on makeFolder(folderPath)
	set quotedPath to quoted form of POSIX path of folderPath
	log folderPath
	do shell script "mkdir -p " & quotedPath
end makeFolder

-- Pull the album list to export from a file created separately
on getAlbumList()
	-- get the text from the file
	set theFile to choose file
	set theText to read theFile
	
	-- turn the text into a list so we can loop over it
	set albumList to paragraphs of theText
	albumList
end getAlbumList

on run
	set baseDir to "/Users/luke/Desktop/Photo Export/" as POSIX file as text -- the destination folder (use a valid path)
	
	tell application "Photos"
		set albumList to my getAlbumList()
		
		-- Make each of the top level folders
		repeat with theAlbum in albumList
			if theAlbum is not "" then
				set theFolder to (baseDir & theAlbum)
				my makeFolder(theFolder)
				log "Trying to export " & theAlbum
				export (get media items of album theAlbum) to (theFolder as alias) with using originals
			end if
		end repeat
	end tell
end run

