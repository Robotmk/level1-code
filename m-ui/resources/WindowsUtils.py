from robot.api import Failure
from time import time, sleep
import pyautogui as pa
import re

class NotFoundError(Failure):
    pass

class WindowsUtils:
    ROBOT_LIBRARY_SCOPE = 'TEST CASE'

    @staticmethod
    def wait_for_window_debug(pattern):
        all_windows = pa.getAllWindows()
        for window in all_windows: 
            print(window.title)
        for window in all_windows: 
            if re.match(pattern, window.title):
                print("Window found!")

    @staticmethod
    def wait_for_window(pattern, timeout=10):
        stop_time = time() + int(timeout)
        while time() < stop_time:
            all_windows = pa.getAllWindows()
            for window in all_windows: 
                if re.match(pattern, window.title):
                    return
        raise NotFoundError(f"Unable to find window with pattern \"{pattern}\" ")

    @staticmethod
    def wait_for_window_and_activate(pattern, timeout=10, wait=0, maximize=False):
        if wait: 
            sleep(wait)
        stop_time = time() + int(timeout)
        while time() < stop_time:
            all_windows = pa.getAllWindows()
            for window in all_windows: 
                # Set a breakpoint here  ⚠️ 
                if re.match(pattern, window.title):
                    window.activate()
                    if maximize:
                        window.maximize()
                    return
        raise NotFoundError(f"Unable to find window with pattern \"{pattern}\" ")       


if __name__ == "__main__":
    pattern = ""        # Enter the search pattern here
    WindowUtils.wait_for_window_debug(pattern)