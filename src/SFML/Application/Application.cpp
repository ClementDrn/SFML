#include <SFML/Application/Application.hpp>


namespace sf {

    const Application::Properties Application::Properties::DEFAULT;

    Application::Application(const std::string& title, const Properties& props)
        : m_clearColor(props.clearColor)
    {
        m_window = new RenderWindow(VideoMode({ props.winWidth, props.winHeight }), title, props.style);
    }

    Application::~Application()
    {
        delete m_window;
    }

    void Application::run()
    {
        // Variables
        Time lastFrameTime;
        Time now;

        // Main Loop
        while (m_window->isOpen())
        {
            // Events
            while (const std::optional event = m_window->pollEvent())
                onEvent(event);

            // Update
            now = microseconds(std::chrono::duration_cast<std::chrono::microseconds>(
                std::chrono::system_clock::now().time_since_epoch()).count());
            onUpdate(now - lastFrameTime);
            lastFrameTime = now;

            // Clear
            m_window->clear(m_clearColor);

            // Render
            onRender();

            // Display
            m_window->display();
        }
    }

}
