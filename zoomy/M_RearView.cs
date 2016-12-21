using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

namespace zoomy
{
    public class M_RearView : MonoBehaviour
    {
        Rect menu = new Rect(0, 0, 200, 200);
        Vector2 sp;
        
        void OnGui()
        {
            if (Settings.HackEnabled && Settings.InMenu && Settings.InRearViewMenu)
            {
                menu = GUILayout.Window(WID.RearViewMenu, menu, DoMenu, "Rear Camera Settings");
            }
        }

        void DoMenu(int windowID)
        {
            sp = GUILayout.BeginScrollView(sp);
            Settings.RearViewEnabled = GUILayout.Toggle(Settings.RearViewEnabled, "Rear Camera Enabled");

            GUILayout.EndScrollView();
            if (GUILayout.Button("Close"))
            {
                Settings.InRearViewMenu = false;
            }
            GUI.DragWindow();
        }
    }
}
