using System;
using UnityEngine;
using SDG.Unturned;

namespace zoomy
{
    public class M_Radar : MonoBehaviour
    {
        public Rect radar_menu = new Rect(10, 10, 200, 200);

        Vector2 sp;

        void OnGUI()
        {
            if (Settings.HackEnabled && Settings.InMenu && Settings.Radar.InRadarMenu)
            {
                radar_menu = GUILayout.Window(WID.RadarMenu, radar_menu, DoMenu, "Radar Settings");
            }
        }

        void DoMenu(int WindowID)
        {
            sp = GUILayout.BeginScrollView(sp);
            Settings.Radar.RadarEnabled = GUILayout.Toggle(Settings.Radar.RadarEnabled, "Radar Enabled");
            GUILayout.Label("Radar Refresh Rate: " + Settings.Radar.RadarRefreshRate);
            Settings.Radar.RadarRefreshRate = (int)GUILayout.HorizontalSlider((float)Math.Round((double)Settings.Radar.RadarRefreshRate, 0), 10f, 250f);
            GUILayout.Label("Radar Range: " + Settings.Radar.RadarRange);
            Settings.Radar.RadarRange = (int)GUILayout.HorizontalSlider((float)Math.Round((double)Settings.Radar.RadarRange, 0), 10f, 150f);
            GUILayout.EndScrollView();
            if (GUILayout.Button("Close"))
            {
                Settings.Radar.InRadarMenu = false;
            }
            GUI.DragWindow();
        }
    }
}
