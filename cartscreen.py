import kivy
from kivymd.app import MDApp
from kivymd.uix.button import MDFillRoundFlatButton, MDFlatButton
from kivymd.uix.screenmanager import MDScreenManager
from kivymd.uix.screen import MDScreen
from kivymd.uix.textfield import MDTextField
from kivy.lang import Builder
from kivymd.uix.snackbar import Snackbar
from kivy.animation import Animation
from kivy.clock import Clock
from kivy.metrics import dp
import kivymd_extensions.akivymd
from kivy.properties import StringProperty, ObjectProperty
from kivy.clock import Clock, mainthread
from plyer import gps
from kivymd.uix.boxlayout import MDBoxLayout
from kivy.app import runTouchApp
from math import cos, asin, sqrt, pi


strkv="""
CartLayout:
    orientation: 'vertical'
    spacing: dp(10)
    padding: dp(20)

    MDBoxLayout:
        adaptive_height: True

        MDIconButton:
            icon: 'magnify'

        MDTextField:
            id: search_field
            hint_text: 'Search vegetables/fruits/grains'
            #on_text: root.set_list_md_icons(self.text, True)
    MDBoxLayout:
        padding: dp(10)
        default_size: None, dp(48)
        default_size_hint: 1, None
        size_hint_y: None
        height: self.minimum_height
        orientation: 'vertical'
        #orientation: "vertical"
        OneLineAvatarListItem:
            text: "Tomato"
            ImageLeftWidget:
                source: "tomato.jpg"
        OneLineAvatarListItem:
            text: "Potato"
            ImageLeftWidget:
                source: "potato.jpeg"
        OneLineAvatarListItem:
            text: "Onion"
            ImageLeftWidget:
                source: "onion.jpeg"
        OneLineAvatarListItem:
            text: "Cabbage"
            ImageLeftWidget:
                source: "cabbage.png"
        OneLineAvatarListItem:
            text: "Lady Finger"
            ImageLeftWidget:
                source: "lady-finger.jpeg"
        OneLineAvatarListItem:
            text: "Brinjal"
            ImageLeftWidget:
                source: "brinjal.jpeg"
        # OneLineAvatarListItem:
        #     text: "Olives"
        #     ImageLeftWidget:
        #         source: "olive.png"
        OneLineAvatarListItem:
            text: "Chilli"
            ImageLeftWidget:
                source: "chilli.png"
        OneLineAvatarListItem:
            text: "Cauliflower"
            ImageLeftWidget:
                source: "cauli.png"        
    # RecycleView:
    #     id: rv
    #     key_viewclass: 'viewclass'
    #     key_size: 'height'

    #     RecycleBoxLayout:
    #         padding: dp(10)
    #         default_size: None, dp(48)
    #         default_size_hint: 1, None
    #         size_hint_y: None
    #         height: self.minimum_height
    #         orientation: 'vertical'
"""

class CartLayout(MDBoxLayout):
    pass

class CartApp(MDApp):
    def build(self):
        return Builder.load_string(strkv)
    
CartApp().run()