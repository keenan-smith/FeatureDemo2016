using System;
using UnityEngine;
using SDG.Unturned;

namespace zoomy
{
    public class M_Main : MonoBehaviour
    {
        Vector2 sp;
        Rect menu = new Rect(10, 10, 200, 200);
        void OnGUI()
        {
            if (Settings.HackEnabled && Settings.InMenu)
            {
                menu = GUILayout.Window(WID.MainMenu, menu, DoMenu, "Hack by IC3 + Zoomy");
            }
        }
        void DoMenu(int windowID)
        {
            sp = GUILayout.BeginScrollView(sp);
            if (GUILayout.Button("Radar Menu"))
            {
                Settings.InRadarMenu = true;
            }
            if (GUILayout.Button("Rear Camera Menu"))
            {
                Settings.InRearViewMenu = true;
            }

            GUILayout.EndScrollView();
            GUI.DragWindow();
        }

        void Update()
        {
            if (Input.GetKeyDown(KeyCode.F1))
            {
                Settings.InMenu = !Settings.InMenu;
            }
        }
    }
}
