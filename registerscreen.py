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
from kivy.app import runTouchApp
from math import cos, asin, sqrt, pi
from kivymd_extensions.akivymd.uix.dialogs import AKAlertDialog
from kivy.factory import Factory

kv = """
MDCard:
    size_hint: None, None
    size: 300, 560
    pos_hint: {"center_x": 0.5, "center_y": 0.5}
    elevation: 5
    padding: 25
    spacing: 25
    orientation: 'vertical'
    
    MDBoxLayout:
        orientation: "vertical"
        halign: "center"
        Image:
            halign: "center"
            size: 10, 10
            source: "logo.jpeg"
        MDLabel:    
            text: "Register"
            size: 20, 20
            halign: "center"
        MDGridLayout:
            cols: 2
            MDIcon:
                icon: "format-letter-case"
                pos_hint: self.pos_hint
            MDTextField:
                #mode: "rectangle"
                id: name
                hint_text: "Name"
                helper_text: "Invalid Name"
                helper_text_mode: "on_error"
                on_text_validate: phone.focus = True
                #pos_hint: {"center_y": .5}      
            MDIcon:
                icon: "phone"
                pos_hint: self.pos_hint
            MDTextField:
                #mode: "rectangle"
                id: phone
                hint_text: "Phone"
                helper_text: "Invalid"
                helper_text_mode: "on_error"
                on_text_validate: login_username.focus = True
                #pos_hint: {"center_y": .5}   
            MDIcon:
                icon: "account"
                pos_hint: self.pos_hint
            MDTextField:
                #mode: "rectangle"
                id: login_username
                hint_text: "Username"
                helper_text: "Invalid Username"
                helper_text_mode: "on_error"
                on_text_validate: login_password.focus = True
                #pos_hint: {"center_y": .5}
            MDIcon:
                icon: "key-variant"
            MDTextField:
                id: login_password
                hint_text: "Password"
                helper_text: "Invalid Password"
                helper_text_mode: "on_error"
                password: True
                on_text_validate: app.login(login_username.text, login_password.text)        
        MDLabel:
        MDGridLayout:
            #orientation: "horizontal"
            cols: 3
            MDRaisedButton:
                text: "Clear"
                md_bg_color: "green"
                on_press: root.clear()
            MDLabel:
            MDRaisedButton:
                text: "Login"
                md_bg_color: "green"
                on_press: app.login(login_username.text, login_password.text)
                #on_release: app.

<SuccessDialog@BoxLayout>:
    orientation: "vertical"
    padding: dp(40)

    MDLabel:
        text: "Successful!"
        size_hint_y: None
        height: self.texture_size[1]
        halign: "center"
        valign: "center"
        bold: True
        theme_text_color: "Custom"
        text_color: 0, .7, 0, 1

    MDLabel:
        text: "Welcome!!"
        halign: "center"
        valign: "top"
        theme_text_color: "Custom"
        text_color: 0, .7, 0, 1
        font_style: "Caption"

    MDFillRoundFlatButton:
        id: button
        text: "Confirm"
        md_bg_color: 0, .7, 0, 1
        pos_hint: {"center_x": .5}
"""

class RegisterApp(MDApp):

    def login(self, username, password):
        self.show_snackbar()

    def success(self):
        dialog = AKAlertDialog(
            header_icon="check-circle-outline", header_bg=[0, 0.7, 0, 1]
        )
        content = Factory.SuccessDialog()
        content.ids.button.bind(on_release=dialog.dismiss)
        dialog.content_cls = content
        dialog.open()

    def show_snackbar(self):
        # if not self.snackbar:
        #     self.snackbar = Snackbar(text="Welcome "+str(self.ids.login_username.text))
        #     self.snackbar.open()
        #     anim = Animation(y=dp(72), d=.2)
        self.success()

    def build(self):
        return Builder.load_string(kv)
    
RegisterApp().run()