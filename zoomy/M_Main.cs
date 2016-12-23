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
                Settings.Radar.InRadarMenu = true;
            }
            if (GUILayout.Button("Rear Camera Menu"))
            {
                Settings.RearView.InRearViewMenu = true;
            }
            if (GUILayout.Button("Console"))
            {
                Settings.Console.InConsoleMenu = true;
            }
            if(GUILayout.Button("ESP Menu"))
            {
                Settings.ESP.InEspMenu = true;
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
        
        void Start()
        {
        loadAsset();
        }
        
        private IEnumerator loadAsset()
        {
        WWW www = new WWW("file://" + Application.dataPath + "/chams.unity3d");
        yield return www;
        
        Settings.bundle - www.assetBundle;
        }
    }
}
