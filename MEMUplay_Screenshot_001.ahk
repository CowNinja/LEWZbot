

; ********************************
; MEMUplay directories
; ********************************
; Music: C:\Users\CowNi\Music\MEmu Music
; Video: C:\Users\CowNi\Videos\MEmu Video
; Pictures: C:\Users\CowNi\Pictures\MEmu Photo
; Downloads: C:\Users\CowNi\Downloads\MEmu Download
; Screenshots: c:\Users\CowNi\Pictures\MEmu Photo\Screenshots
; 

; ********************************
; System environemental variables
; ********************************
; ALLUSERSPROFILE=C:\ProgramData
; APPDATA=C:\Users\CowNi\AppData\Roaming
; HOMEPATH=\Users\CowNi
; LOCALAPPDATA=C:\Users\CowNi\AppData\Local
; TEMP=C:\Users\CowNi\AppData\Local\Temp
; TMP=C:\Users\CowNi\AppData\Local\Temp
; USERNAME=CowNi
; USERPROFILE=C:\Users\CowNi

; capture variable using:
; EnvGet, USER_PROFILE, USERPROFILE
;
; ********************************
; Combined: System environemental variables
; and MEMUplay directories
; ********************************
; Music: "%USERPROFILE%\Music\MEmu Music"
; Video: "%USERPROFILE%\Videos\MEmu Video"
; Pictures: "%USERPROFILE%\Pictures\MEmu Photo"
; Downloads: "%USERPROFILE%\Downloads\MEmu Download"
; Screenshots: "%USERPROFILE%\Pictures\MEmu Photo\Screenshots"
#include <Vis2>
#include lib\CowNinja_Functions.ahk
#include <Gdip_All>
#include lib\Image_Processing_Library.ahk

; #	Win (Windows logo key)
; !	Alt
; ^	Control
; +	Shift

; Take screenshot in MEMUplay (Alt + F3)
Text_To_Screen("{!F3}")

; Crop Screenshot
Path = %USERPROFILE%\Pictures\MEmu Photo\Screenshots ; change this to the actual folder

Newest_ScreenCap := DIR_Newest_File(Path)

pCroppedBitmap := Gdip_CropBitmap(Newest_ScreenCap, 0, 0, 77, 77, 0) ; crops 77 pixels from upper and lower side of bitmap rectangle. Does not dispose of pBitmap.

MsgBox, 1. Lastest file in %Path% is `n`n%Newest_ScreenCap%`n`nCropped Picture is: %pCroppedBitmap%

Crop_X := 100
Crop_Y := 25
Crop_H := 50
Crop_W := 75
/*
Input_Image := % """" Newest_ScreenCap """"
Dest_Crop := % """" Crop_X " " Crop_Y " " Crop_H " " Crop_W """"
Dest_Scale := ""
Dest_filename := % """" Path "\Crop_Test.png"""
Dest_compression := """png"""
*/

Crop_W := 75
Input_Image := Newest_ScreenCap
Dest_Crop := Crop_X . " " . Crop_Y . " " . Crop_H . " " . Crop_W
Dest_Scale := ""
Dest_filename := Path . "\Crop_Test.png"
Dest_compression := "png"

MsgBox, ImageToFile(Input_Image, Dest_Crop, Dest_Scale, Dest_filename, Dest_compression)`nImageToFile(%Input_Image%, %Dest_Crop%, %Dest_Scale%, %Dest_filename%, %Dest_compression%)

results := ImageToFile(Input_Image, Dest_Crop, Dest_Scale, Dest_filename, Dest_compression)

MsgBox, %results%

return

DIR_Newest_File(Folder_Path)
{
	Loop %Folder_Path%\*.*               ; www.autohotkey.com/forum/viewtopic.php?p=342784#342784
	 If ( A_LoopFileTimeModified >= Time )
		Time := A_LoopFileTimeModified, File := A_LoopFileLongPath
	MsgBox, 1. Lastest file in %Folder_Path% is `n`n%File%

	return File
}

ImageToFile(image, crop := "", scale := "", filename := "", compression := "") {
   return Graphics.Picture.Preprocess("file", image, crop, scale, filename, compression)
}

ImageToBase64(image, crop := "", scale := "", extension := "", compression := "") {
   return Graphics.Picture.Preprocess("base64", image, crop, scale, extension, compression)
}


;-- returns cropped bitmap. Specify how many pixels you want to crop (omit) from each side of bitmap rectangle
Gdip_CropBitmap(pBitmap, left, right, up, down, Dispose=1) {                          	
	/*    	DESCRIPTION of function Gdip_CropBitmap()
        	-------------------------------------------------------------------------------------------------------------------
			Description  	:	returns cropped bitmap. Specify how many pixels you want to crop (omit) from each side of bitmap rectangle
			Link              	:	http://www.autohotkey.com/community/viewtopic.php?p=477333#p477333
			Author         	:	Learning one
			Date	            	:	Nov 14 2012
			AHK-Version	:	AHK_L
			License        	:	unknown
			Parameter(s)	:	see examples
			Remark(s)    	:	none
			Dependencies	:	GDIP.ahk
        	-------------------------------------------------------------------------------------------------------------------
	*/

	/*    	EXAMPLE(s)

			pCroppedBitmap := Gdip_CropBitmap(pBitmap, 10, 10, 10, 10) ; crops 10 pixels from each side of bitmap rectangle. Disposes of pBitmap.
			pCroppedBitmap := Gdip_CropBitmap(pBitmap, 50, 50, 0, 0) ; crops 50 pixels from left and right side of bitmap rectangle. Disposes of pBitmap.
			pCroppedBitmap := Gdip_CropBitmap(pBitmap, 0, 0, 77, 77, 0) ; crops 77 pixels from upper and lower side of bitmap rectangle. Does not dispose of pBitmap.

	*/


		Gdip_GetImageDimensions(pBitmap, origW, origH)
		NewWidth := origW-left-right, NewHeight := origH-up-down
		pBitmap2 := Gdip_CreateBitmap(NewWidth, NewHeight)
		G2 := Gdip_GraphicsFromImage(pBitmap2), Gdip_SetSmoothingMode(G2, 4), Gdip_SetInterpolationMode(G2, 7)
		Gdip_DrawImage(G2, pBitmap, 0, 0, NewWidth, NewHeight, left, up, NewWidth, NewHeight)
		Gdip_DeleteGraphics(G2)
		if Dispose
				Gdip_DisposeImage(pBitmap)

return pBitmap2
} ;</05.01.000052>