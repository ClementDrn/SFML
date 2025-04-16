#pragma once

#include <SFML/Graphics.hpp>

#include <string>
#include <optional>


namespace sf {

	class Application
	{
	public:

		struct Properties
		{
			uint32_t winWidth	= 960;
			uint32_t winHeight	= 540;
			int style			= Style::Close;		// sf::Style
			Color clearColor	= Color::Black;

			static const Properties DEFAULT;
		};

		virtual ~Application();

		void run();

	protected:

		Application(const std::string& title, const Properties& props = Properties::DEFAULT);

		virtual void onEvent(const std::optional<sf::Event>& e) = 0;
		virtual void onUpdate(const Time& ts) = 0;
		virtual void onRender() = 0;


		RenderWindow* m_window;
		Color m_clearColor;
	};

}
