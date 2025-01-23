import pyautogui
import pyperclip
import keyboard

def paste_text(text):
    pyperclip.copy(text)
    pyautogui.hotkey('ctrl', 'v')
    pyperclip.copy('')

def kb_send(key):
    keyboard.send(key)

def kb_write(text, delay=0):
    keyboard.write(text, delay=delay)
