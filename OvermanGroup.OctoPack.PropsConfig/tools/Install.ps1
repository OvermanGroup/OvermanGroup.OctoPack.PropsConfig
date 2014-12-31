param($installPath, $toolsPath, $package, $project)

$octoName = 'OctoPack.targets'
$propsName = 'OvermanGroup.OctoPack.props'

# load the MSBuild assembly
Add-Type -AssemblyName 'Microsoft.Build, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'

# load the current MSBuild project
$msbuild = [Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection.GetLoadedProjects($project.FullName) | Select-Object -First 1

# get the import for OctoPack
$octoImport = $msbuild.Xml.Imports | Where-Object { $_.Project.EndsWith($octoName) } | Select-Object -First 1
if (!$octoImport) {
	throw "ERROR: Cannot find $octoName. Please verify that OctoPack was installed."
}

# check if an import for the props already exists
$propsImport = $msbuild.Xml.Imports | Where-Object { $_.Project.EndsWith($propsName) } | Select-Object -First 1

# if not, create a new import for the props
if (!$propsImport) {
	Write-Host "Adding $propsName import"
	$propsImport = $msbuild.Xml.AddImport($propsName)
	$propsImport.Condition = "Exists('$propsName')"
}

# make sure the props are immediately above the OctoPack import
Write-Host "Moving $propsName import above $octoName"
$propsImport.Parent.RemoveChild($propsImport)
$msbuild.Xml.InsertBeforeChild($propsImport, $octoImport);

Write-Host "Saving project"
$project.Save()
