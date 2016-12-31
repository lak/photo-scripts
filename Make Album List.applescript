-- Gotten from http://www.macosxautomation.com/applescript/sbrt/sbrt-09.html
-- modified to use temp files
on write_to_file(filePath, allAlbums)
	-- set targetFile to (path to "temp" from user domain as text) & (make new name) 
	try
		-- set targetFile to (path to temporary items) & (make new name) 
		-- set targetFile to (path to "temp" from user domain as text) & (make new name) 
		set targetFile to filePath
		
		set the targetFile to the targetFile as string
		set the open_target_file to open for access file targetFile with write permission
		set eof of the open_target_file to 0 -- always rewrite, if that comes up
		repeat with albumName in allAlbums
			write albumName & "\n" to the open_target_file
			log albumName
		end repeat
		close access the open_target_file
		return targetFile
	on error errmsg
		my log_err("Could not write file: " & errmsg)
		
		try
			close access file target_file
		end try
		return false
	end try
end write_to_file

tell application "Photos"
	set filePath to "/Users/luke/Desktop/Album_list.txt/" as POSIX file as text -- the destination folder (use a valid path)
	set albumNames to name of albums
	my write_to_file(filePath, albumNames)
end tell