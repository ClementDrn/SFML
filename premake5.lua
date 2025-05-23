newoption {
	trigger = "sfml-audio",
	description = "Add audio support to SFML."
}

newoption {
	trigger = "sfml-network",
	description = "Add network support to SFML."
}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"


project "SFML"
	kind "StaticLib"
	language "C++"
	cppdialect "C++20"
	staticruntime "on"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	objdir("obj/" .. outputdir .. "/%{prj.name}")
	
	includedirs {
		"extlibs/headers/",
		"extlibs/headers/glad/include",
		"extlibs/headers/vulkan/",
		"extlibs/headers/stb_image/",
		"include/",
		"src/"
	}

	files {
		"include/**.hpp",
		"src/**.hpp",
		"src/**.cpp",
		"include/**.h",
		"src/**.h",
		"src/**.c"
	}

	removefiles {
		"src/SFML/Main/**",
	}

	defines {
		"SFML_STATIC",
		"_CRT_SECURE_NO_WARNINGS"
	}

	links {
		"legacy_stdio_definitions.lib"
	}

	-- Audio
	filter "not options:sfml-audio"
		removefiles {
			"**/Audio/**",
		}

	-- Network
	filter "not options:sfml-network"
		removefiles {
			"**/Network/**"
		}

	-- Windows
	filter "system:windows"
		systemversion "latest"
		removefiles { 
			"**/Android/**",
			"**/iOS/**",
			"**/Unix/**",
			"**/macOS/**",
			"src/SFML/**/NetBSD/**",
			"src/SFML/**/FreeBSD/**",
			"src/SFML/**/OpenBSD/**"
		}

	-- Linux
	filter "system:linux"
		systemversion "latest"
		removefiles { 
			"**/Android/**",
			"**/iOS/**",
			"**/Win32/**",
			"**/macOS/**",
			"src/SFML/Window/DRM/**",
			"src/SFML/**/NetBSD/**",
			"src/SFML/**/FreeBSD/**",
			"src/SFML/**/OpenBSD/**"
		}
		includedirs {
			"/usr/include/freetype2/"
		}
		links {
			"GL",
			"freetype",
			"X11",
			"Xrandr",
			"Xi",
			"Xcursor",
			"udev"
		}

	-- Linux GMake
	filter {"system:linux", "action:gmake2"}
		buildoptions {
			"-Wall"
		}

	-- Debug
	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	-- Release
	filter "configurations:Release"
		runtime "Release"
		optimize "on"
