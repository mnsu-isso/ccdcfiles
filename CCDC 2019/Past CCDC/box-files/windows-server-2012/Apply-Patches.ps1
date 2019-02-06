Function Apply-Patches-CCDC {
	$patches = get-childitem windows8-rt-kb*.msu
	$errors = 0
	foreach ($file in $patches)
	{
		wusa.exe $file /quiet /norestart | write-output # piping output forces script to wait for execution
		if ($lastexitcode -ne 0) {
			write-output "$file failed with exit code $lastexitcode"
			$errors = $errors + 1
		}
		else {
			write-output "$file applied successfully"
		}
	}
	write-output "Patching has completed. $errors total errors. Don't forget to restart!"
}
Apply-Patches-CCDC
