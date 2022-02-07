project "SFML"
	kind "StaticLib"
	language "C++"
	staticruntime "on"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")
		
	files {
		"include/**.hpp",
		"src/**.hpp",
		"src/**.cpp",
	}

	filter "system:windows"
		systemversion "latest"

		removefiles { 
			"**/Android/**,
			"**/iOS/**",
			"**/Unix/**",
			"**/OSX/**",
			"src/SFML/Main/MainAndroid.cpp",
			"src/SFML/Main/MainiOS.mm",
			"src/SFML/Main/MainWin32.cpp",
		}

		defines {
			"SFML_USE_STATIC_STD_LIBS"
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
