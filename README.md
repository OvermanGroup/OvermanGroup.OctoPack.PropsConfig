# OvermanGroup.OctoPack.PropsConfig

This NuGet package adds an `OvermanGroup.OctoPack.props` file to your project so that you can easily configure MSBuild properties for OctoPack directly within your Visual Studio project.

## PURPOSE
[OctoPack][1] is a great tool to quickly create [Octopus Deploy][2] compatible NuGet packages from your projects. Unfortunately for OctoPack to create packages, it requires the `/p:RunOctoPack=true` argument to be explicitly specified with MSBuild. Normally this isn't a problem for TFS builds (or any other CI) as you can easily add the MSBuild argument, but it's inconvienent when building manually within the Visual Studio IDE.

## INSTALLATION
To install OvermanGroup.OctoPack.PropsConfig, simply run the following command in the Package Manager Console:

    PM> Install-Package OvermanGroup.OctoPack.PropsConfig

## CONFIGURATION
After installing, your Visual Studio project will have an additional `OvermanGroup.OctoPack.props` file which is used to configure MSBuild properties that specify how your Octopus NuGet package is created and published. These properties are normally specified as additional MSBuild arguments in a TFS build definition.

Below is the minimal configuration required for `OvermanGroup.OctoPack.props` to create an Octopus NuGet package:
```
<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	<PropertyGroup>
		<RunOctoPack Condition="'$(RunOctoPack)'==''">true</RunOctoPack>
	</PropertyGroup>
</Project>
```
## FEEDBACK
Please provide any feedback, comments, or issues to this GitHub project [here][3].

[1]: http://docs.octopusdeploy.com/display/OD/Using+OctoPack
[2]: http://octopusdeploy.com/
[3]: https://github.com/OvermanGroup/OvermanGroup.OctoPack.PropsConfig/issues
