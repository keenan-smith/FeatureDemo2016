using System;
using UnityEngine;
using SDG.Unturned;

namespace zoomy
{
    public class M_ESP : MonoBehaviour
    {
        Rect menu = new Rect(10, 10, 200, 200);
        Rect showmenu = new Rect(10, 10, 200, 200);
        Rect glowmenu = new Rect(10, 10, 200, 200);
        Vector2 sp;
        Vector2 spshow;
        Vector2 spglow;
        L_ESP esp = new L_ESP();
        string text;

        void OnGUI()
        {
            if (Settings.HackEnabled && Settings.InMenu && Settings.ESP.InEspMenu)
            {
                menu = GUILayout.Window(WID.EspMenu, menu, DoMenu, "ESP Settings");
            }
            if (Settings.HackEnabled && Settings.InMenu && Settings.ESP.InEspMenu && Settings.ESP.Show.InMenu)
            {
                showmenu = GUILayout.Window(WID.EspShowMenu, showmenu, DoShowMenu, "Show Settings");
            }
            if (Settings.HackEnabled && Settings.InMenu && Settings.ESP.InEspMenu && Settings.ESP.Glow.InMenu)
            {
                glowmenu = GUILayout.Window(WID.EspGlowMenu, glowmenu, DoGlowMenu, "Glow Settings");
            }
        }

        void DoMenu(int WindowID)
        {
            sp = GUILayout.BeginScrollView(sp);
            Settings.ESP.EspEnabled = GUILayout.Toggle(Settings.ESP.EspEnabled, "ESP Enabled");

            GUILayout.Label("Refresh Rate: " + Settings.ESP.EspRefreshRate.ToString());
            Settings.ESP.EspRefreshRate = (int)GUILayout.HorizontalSlider((float)Math.Round((double)Settings.ESP.EspRefreshRate, 0), 0f, 500f);

            GUILayout.Label("Range: " + Settings.ESP.EspRange.ToString());
            Settings.ESP.EspRange = (int)GUILayout.HorizontalSlider((float)Math.Round((double)Settings.ESP.EspRange, 0), 0f, 4000f);

            if (GUILayout.Button("Open Show Options"))
            {
                Settings.ESP.Show.InMenu = true;
            }
            if (GUILayout.Button("Open Glow Options"))
            {
                Settings.ESP.Glow.InMenu = true;
            }

            GUILayout.EndScrollView();
            if (GUILayout.Button("Close"))
            {
                Settings.ESP.InEspMenu = false;
            }
            GUI.DragWindow();
        }

        void DoShowMenu(int WindowID)
        {
            spshow = GUILayout.BeginScrollView(spshow);

            Settings.ESP.Show.Names = GUILayout.Toggle(Settings.ESP.Show.Names, "Names");
            Settings.ESP.Show.Distance = GUILayout.Toggle(Settings.ESP.Show.Distance, "Distance");
            Settings.ESP.Show.Boxes = GUILayout.Toggle(Settings.ESP.Show.Boxes, "Boxes");
            Settings.ESP.Show.Glow = GUILayout.Toggle(Settings.ESP.Show.Glow, "Glow");
            if (Settings.ESP.Show.Chams)
            {
                text = "On";
            }
            else
            {
                text = "Off";
            }
            if (GUILayout.Button("Chams: " + text))
            {
                esp.DoChams();
            }

            GUILayout.EndScrollView();
            if (GUILayout.Button("Close"))
            {
                Settings.ESP.Show.InMenu = false;
            }
            GUI.DragWindow();
        }
        void DoGlowMenu(int WindowID)
        {
            spglow = GUILayout.BeginScrollView(spglow);

            Settings.ESP.Glow.Player = GUILayout.Toggle(Settings.ESP.Glow.Player, "Players");
            Settings.ESP.Glow.Zombie = GUILayout.Toggle(Settings.ESP.Glow.Zombie, "Zombies");
            Settings.ESP.Glow.Vehicle = GUILayout.Toggle(Settings.ESP.Glow.Vehicle, "Vehicles");
            Settings.ESP.Glow.Storage = GUILayout.Toggle(Settings.ESP.Glow.Storage, "Storages");
            Settings.ESP.Glow.Bed = GUILayout.Toggle(Settings.ESP.Glow.Bed, "Beds");
            Settings.ESP.Glow.Turret = GUILayout.Toggle(Settings.ESP.Glow.Turret, "Sentries");
            Settings.ESP.Glow.Generator = GUILayout.Toggle(Settings.ESP.Glow.Generator, "Generators");

            GUILayout.EndScrollView();
            if (GUILayout.Button("Close"))
            {
                Settings.ESP.Glow.InMenu = false;
            }
            GUI.DragWindow();
        }
    }
}
