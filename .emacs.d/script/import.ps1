Param ($FileName)

Add-Type -AssemblyName System.Windows.Forms

If ([Windows.Forms.Clipboard]::ContainsImage() -eq $True) {
  $Image = [Windows.Forms.Clipboard]::GetImage()
  $FilePath = "."
  $ImagePath = Join-Path $FilePath $FileName
  $Image.Save($ImagePath, [System.Drawing.Imaging.ImageFormat]::Png)
}