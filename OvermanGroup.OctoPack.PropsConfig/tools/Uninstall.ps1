param($installPath, $toolsPath, $package, $project)

$octoName = 'OctoPack.targets'
$propsName = 'OvermanGroup.OctoPack.props'

# load the MSBuild assembly
Add-Type -AssemblyName 'Microsoft.Build, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'

# load the current MSBuild project
$msbuild = [Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection.GetLoadedProjects($project.FullName) | Select-Object -First 1

# remove the props import
$propsImport = $msbuild.Xml.Imports | Where-Object { $_.Project.EndsWith($propsName) } | Select-Object -First 1
if ($propsImport) {
	Write-Host "Removing $propsName import"
	$msbuild.Xml.RemoveChild($propsImport) | Out-Null
}

Write-Host "Saving project"
$project.Save()
