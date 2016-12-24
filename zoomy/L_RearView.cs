using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;
using SDG.Unturned;

namespace zoomy
{
    public class L_RearView : MonoBehaviour
    {
        Rect menu = new Rect(1075, 10, Screen.width / 4, Screen.height / 4);
        GameObject cam_obj;
        Camera subCam;
        

        void Update()
        {
            if (Settings.HackEnabled && Settings.RearView.RearViewEnabled)
            {
                subCam.enabled = true;
            }
            else
            {
                subCam.enabled = false;
            }
        }

        void OnGUI()
        {
            if (Settings.HackEnabled && Settings.RearView.RearViewEnabled)
            {
                GUI.color = new Color(1f, 1f, 1f, 0f);
                menu = GUILayout.Window(WID.RearCam, menu, DoMenu, "Rear View");
                GUI.color = Color.white;
            }
        }

        void DoMenu(int windowID)
        {
            if (cam_obj == null || subCam == null)
            {
                cam_obj = new GameObject();
                subCam = cam_obj.AddComponent<Camera>();
                cam_obj.AddComponent<GUILayer>();
                cam_obj.transform.position = MainCamera.instance.gameObject.transform.position;
                cam_obj.transform.rotation = MainCamera.instance.gameObject.transform.rotation;
                cam_obj.transform.Rotate(0, 180, 0);
                subCam.transform.SetParent(Camera.main.transform, true);
                subCam.layerCullDistances = MainCamera.instance.layerCullDistances;
                subCam.layerCullSpherical = MainCamera.instance.layerCullSpherical;
                subCam.tag = "MainCamera";
                subCam.enabled = true;
                subCam.rect = new Rect(0.6f, 0.6f, 0.4f, 0.4f);
                subCam.depth = 99;
            }
            GUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            GUILayout.Label("Rear View Camera");
            GUILayout.FlexibleSpace();
            GUILayout.EndHorizontal();

            float x, y, w, h;
            x = (menu.x + 5) / Screen.width;
            y = (menu.y + 5) / Screen.height;
            w = (menu.width - 10) / Screen.width;
            h = (menu.height - 10) / Screen.height;
            y = 1 - y;
            y -= h;
            subCam.rect = new Rect(x, y, w, h);

            EditorGUITools.DrawRect(new Rect(0, 0, menu.width, 5), Color.black);
            EditorGUITools.DrawRect(new Rect(0, 0, 5, menu.height), Color.black);
            EditorGUITools.DrawRect(new Rect(0, 0 + (menu.height - 5), menu.width, 5), Color.black);
            EditorGUITools.DrawRect(new Rect(0 + (menu.width - 5), 0, 5, menu.height), Color.black);

            GUI.DragWindow();

        }
    }
}
