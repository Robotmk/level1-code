from robot.api.deco import keyword

class CustomLibrary:
    
    @keyword("Say Hello")
    def say_hello(self, name):
        """Logs a greeting message for the given name."""
        print(f"Hello, {name}!")

    @keyword("Add Numbers")
    def add_numbers(self, a, b):
        """Adds two numbers and returns the result."""
        return a + b