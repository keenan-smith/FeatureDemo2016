using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;
using Steamworks;
using SDG.Unturned;

namespace zoomy
{
    public class M_Console : MonoBehaviour
    {
        public Rect menu = new Rect(10, 220, 450, 200);
        Vector2 Scrollposition;
        bool handleClicked = false;
        Vector3 clickedPosition = new Vector3(0, 0, 0);
        int minWindowWidth = 200;
        int maxWindowWidth = 1920;
        int minWindowHeight = 200;
        int maxWindowHeight = 1080;
        Rect originalWindow;

        void Start()
        {
            originalWindow = menu;
        }

        void OnGUI()
        {
            if (Settings.HackEnabled && Settings.Console.InConsoleMenu)
            {
                menu = GUILayout.Window(WID.ConsoleMenu, menu, DoMenu, "Console");
                var mousePos = Input.mousePosition;
                mousePos.y = Screen.height - mousePos.y;
                Rect windowHandle = new Rect(menu.x + menu.width - 10, menu.y + menu.height - 10, 10, 10);
                GUI.Box(windowHandle, "");
                if (Input.GetMouseButtonDown(0) && windowHandle.Contains(mousePos))
                {
                    handleClicked = true;
                    clickedPosition = mousePos;
                    originalWindow = menu;
                }

                if (handleClicked)
                {
                    if (Input.GetMouseButton(0))
                    {
                        menu.width = Mathf.Clamp(originalWindow.width + (mousePos.x - clickedPosition.x), minWindowWidth, maxWindowWidth);
                        menu.height = Mathf.Clamp(originalWindow.height + (mousePos.y - clickedPosition.y), minWindowHeight, maxWindowHeight);
                    }
                    if (Input.GetMouseButtonUp(0))
                    {
                        handleClicked = false;
                    }
                }
            }
            
        }

        void DoMenu(int windowID)
        {

            Scrollposition = GUILayout.BeginScrollView(Scrollposition);

            foreach (string text in Settings.Console.logtext)
            {
                GUILayout.Label(text);
            }

            GUILayout.EndScrollView();
            if (GUILayout.Button("Clear"))
            {
                Settings.Console.logtext.Clear();
            }

            if (GUILayout.Button("Close"))
            {
                Settings.Console.InConsoleMenu = false;
            }
            /*
            if (GUILayout.Button("List Player GameObjects"))
            {
                SteamPlayer[] players = Provider.clients.ToArray();
                for (int i = 0; i < players.Length; i++)
                {
                    if (players[i] != null && players[i].player != null && players[i].player.gameObject != null && players[i].player != Utils.getLocalPlayer())
                    {
                        GameObject g = players[i].player.gameObject;
                        console.log(g.name);
                    }
                }
            }*/
            if (!handleClicked)
            {
                GUI.DragWindow();
            }
        }
        void Update()
        {
            {
                while (Settings.Console.logtext.Count > 150)
                {
                    Settings.Console.logtext.RemoveAt(0);
                }
            }
        }
    }

    public static class console
    {
        public static void log(string text)
        {
            Settings.Console.logtext.Add(DateTime.Now.ToString("h:mm:ss tt") + ": " + text);
        }
    }
}
