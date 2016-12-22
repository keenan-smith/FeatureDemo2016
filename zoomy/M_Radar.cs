using System;
using UnityEngine;
using SDG.Unturned;

namespace zoomy
{
    public class M_Radar : MonoBehaviour
    {
        public Rect radar_menu = new Rect(0, 0, 200, 200);

        Vector2 sp;

        void OnGUI()
        {
            if (Settings.HackEnabled && Settings.InMenu && Settings.InRadarMenu)
            {
                radar_menu = GUILayout.Window(WID.RadarMenu, radar_menu, DoMenu, "Radar Settings");
            }
        }

        void DoMenu(int WindowID)
        {
            sp = GUILayout.BeginScrollView(sp);
            Settings.RadarEnabled = GUILayout.Toggle(Settings.RadarEnabled, "Radar Enabled");
            GUILayout.Label("Radar Refresh Rate: " + Settings.RadarRefreshRate);
            Settings.RadarRefreshRate = (int)GUILayout.HorizontalSlider((float)Math.Round((double)Settings.RadarRefreshRate, 0), 10f, 250f);
            GUILayout.Label("Radar Range: " + Settings.RadarRange);
            Settings.RadarRange = (int)GUILayout.HorizontalSlider((float)Math.Round((double)Settings.RadarRange, 0), 10f, 150f);
            GUILayout.EndScrollView();
            if (GUILayout.Button("Close"))
            {
                Settings.InRadarMenu = false;
            }
            GUI.DragWindow();
        }
    }
}
