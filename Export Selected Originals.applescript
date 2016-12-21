use script "Photos Utilities"

tell application "Photos"
	set thesePhotos to get the selection
	if thesePhotos is {} then error number -128
	set exportedFiles to Â
		export originals of thesePhotos with resulting file references and Finder reveal
end tell