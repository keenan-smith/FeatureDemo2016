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
        Rect menu = new Rect(10, 10, 200, 200);
        Vector2 sp;
        
        void OnGUI()
        {
            if (Settings.HackEnabled && Settings.InMenu && Settings.RearView.InRearViewMenu)
            {
                menu = GUILayout.Window(WID.RearViewMenu, menu, DoMenu, "Rear Camera Settings");
            }
        }

        void DoMenu(int windowID)
        {
            sp = GUILayout.BeginScrollView(sp);
            Settings.RearView.RearViewEnabled = GUILayout.Toggle(Settings.RearView.RearViewEnabled, "Rear Camera Enabled");

            GUILayout.EndScrollView();
            if (GUILayout.Button("Close"))
            {
                Settings.RearView.InRearViewMenu = false;
            }
            GUI.DragWindow();
        }
    }
}
