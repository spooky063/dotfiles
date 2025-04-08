#!/usr/bin/env python3
import os
import signal
import gi
gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk, AppIndicator3

APPINDICATOR_ID = 'light-dark-switcher'

def run_script(_):
    os.system("sh /usr/local/bin/light-dark-launcher.sh")

def quit_app(_):
    Gtk.main_quit()

indicator = AppIndicator3.Indicator.new(
    APPINDICATOR_ID,
    "gnome-do-symbolic",
    AppIndicator3.IndicatorCategory.APPLICATION_STATUS
)
indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)

menu = Gtk.Menu()

item_run = Gtk.MenuItem(label="Toggle appareance theme")
item_run.connect("activate", run_script)
menu.append(item_run)

# item_quit = Gtk.MenuItem(label="Quitter")
# item_quit.connect("activate", quit_app)
# menu.append(item_quit)

menu.show_all()
indicator.set_menu(menu)

signal.signal(signal.SIGINT, signal.SIG_DFL)
Gtk.main()
