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
#from plyer import gps
from kivy.app import runTouchApp
from math import cos, asin, sqrt, pi


class Manager(MDScreenManager):
    manager = ObjectProperty(None)

class LoginScreen(MDScreen):
    snackbar = None

    def login(self, username, password):
        self.show_snackbar()
        #Manager.current_screen = "MapScreen"
        FarmerApp().change_to_mapscreen()


    def clear(self):
        self.ids.login_username.text = ""
        self.ids.login_password.text = ""

    def show_snackbar(self):
        if not self.snackbar:
            self.snackbar = Snackbar(text="Welcome "+str(self.ids.login_username.text))
            self.snackbar.open()
            anim = Animation(y=dp(72), d=.2)
            #anim.bind(on_complete=lambda *args: Clock.schedule_interval(
                #self.wait_interval, 0))
            #anim.start(self.screen.ids.button)

class RegisterScreen(MDScreen):
    pass

class MapScreen(MDScreen):
    pass
    # def start(self, minTime, minDistance):
    #     gps.start(minTime, minDistance)

    # def stop(self):
    #     gps.stop()

    # @mainthread
    # def on_location(self, **kwargs):
    #     self.gps_location = '\n'.join([
    #         '{}={}'.format(k, v) for k, v in kwargs.items()])
    #     print(self.gps_location)

    # @mainthread
    # def on_status(self, stype, status):
    #     self.gps_status = 'type={}\n{}'.format(stype, status)

    # def on_pause(self):
    #     gps.stop()
    #     return True

    # def on_resume(self):
    #     gps.start(1000, 0)
    #     pass

Builder.load_file("main.kv")

class FarmerApp(MDApp):

    def create_login_table(self):
        return 0
    
    def change_to_mapscreen(self):
        Manager().current = "mapscreen"

    #def  
    def build(self):
        #self.theme_cls.theme_style = "Dark"
        self.theme_cls.primary_palette = "BlueGray"
        # try:
        #     gps.configure(on_location=MapScreen().on_location,
        #                   on_status=MapScreen().on_status)
        # except NotImplementedError:
        #     MapScreen().gps_status = "GPS not supported on Device"
        return MapScreen()
    
    #def logger(self):
    #    self.root.ids.welcome_label.text = f'Sup {self.root.ids.user.text}!'

    # def clear(self):
    #     self.root.ids.welcome_label.text = "WELCOME"		
    #     self.root.ids.user.text = ""		
    #     self.root.ids.password.text = ""	

FarmerApp().run()