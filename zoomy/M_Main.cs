using System;
using UnityEngine;
using SDG.Unturned;
using System.Collections;

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

        void OnDestroy()
        {
            Settings.bundle.Unload(true);
        }
        
        private void loadAsset()
        {
            Settings.bundle = AssetBundle.LoadFromFile(Application.dataPath + "/mat_chams.unity3d", 0U);
            Settings.shaders = Settings.bundle.LoadAllAssets<Shader>();
            Settings.materials = Settings.bundle.LoadAllAssets<Material>();
        }
    }
}
