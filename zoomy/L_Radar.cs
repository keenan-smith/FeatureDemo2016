using System;
using UnityEngine;
using SDG.Unturned;
using System.Collections.Generic;

namespace zoomy
{
    public class L_Radar : MonoBehaviour
    {
        Vector2 tri1 = new Vector2(150, 140);
        Vector2 tri2 = new Vector2(145, 155);
        Vector2 tri3 = new Vector2(155, 155);
        Vector2 otri1;
        Vector2 otri2;
        Vector2 otri3;
        Vector2 ntri1;
        Vector2 ntri2;
        Vector2 ntri3;
        float angley;
        DateTime lastRendTime;
        DateTime lastPRendTime;
        SteamPlayer[] players;
        List<GameObject> g_player = new List<GameObject>();
        List<int> s_x = new List<int>();
        List<int> s_z = new List<int>();
        Rect Radar = new Rect(Screen.width - 350, 10, 300, 300);
        GameObject lp = Utils.getLocalPlayer().gameObject;
        Camera cam = Camera.main;

        void OnGUI()
        {
            if (Settings.HackEnabled && Settings.RadarEnabled)
            {
                Radar = GUILayout.Window(WID.Radar, Radar, DoMenu, "Radar");
            }
        }

        void DoMenu(int WindowID)
        {
            GUILayout.Box("", GUILayout.Height(295), GUILayout.Width(300));
            EditorGUITools.DrawRect(new Rect(0, 0, 350, 350), Color.black);
            EditorGUITools.DrawRect(new Rect(5, 5, 310, 315), Color.gray);

            if ((DateTime.Now - lastRendTime).TotalMilliseconds >= Settings.RadarRefreshRate)
            {
                GetRadarPlayers();
                lastRendTime = DateTime.Now;
            }

            for (int i = 0; i < g_player.Count; i++)
            {
                EditorGUITools.DrawRect(new Rect(s_x[i], s_z[i], (300 / Settings.RadarRange), (300 / Settings.RadarRange)), Color.red);
            }

            if (Settings.RadarStatic)
            {
                if ((DateTime.Now - lastPRendTime).TotalMilliseconds >= Settings.RadarRefreshRate)
                {
                    Vector2 CenterOffset = GetOffsetFromCenter(new Vector2(150, 150));
                    otri1 = GetOffsetFromCenter(tri1);
                    otri2 = GetOffsetFromCenter(tri2);
                    otri3 = GetOffsetFromCenter(tri3);
                    double angle_y = Math.Round(cam.transform.eulerAngles.y, 2);
                    ntri1 = Utils.RotatePoint(otri1, CenterOffset, angle_y);
                    ntri2 = Utils.RotatePoint(otri2, CenterOffset, angle_y);
                    ntri3 = Utils.RotatePoint(otri3, CenterOffset, angle_y);
                    lastPRendTime = DateTime.Now;
                }
                Utils.DrawLine(ntri1, ntri2, Color.blue, 2);
                Utils.DrawLine(ntri2, ntri3, Color.blue, 2);
                Utils.DrawLine(ntri3, ntri1, Color.blue, 2);
            }
            else
            {
                Utils.DrawLine(otri1, otri2, Color.blue, 2);
                Utils.DrawLine(otri2, otri3, Color.blue, 2);
                Utils.DrawLine(otri3, otri1, Color.blue, 2);
            }
            GUI.DragWindow();
        }

        Vector2 GetOffsetFromCenter(Vector2 input)
        {
            Vector2 offset;
            offset.x = input.x + ((300 / Settings.RadarRange) / 2);
            offset.y = input.y + ((300 / Settings.RadarRange) / 2);
            return offset;
        }

        void GetRadarPlayers()
        {
            players = Provider.clients.ToArray();
            g_player.Clear();
            s_x.Clear();
            s_z.Clear();
            for (int i = 0; i < players.Length; i++)
            {
                if (players[i] != null && players[i].player != null && players[i].player.gameObject != null && players[i].player != Utils.getLocalPlayer())
                {
                    GameObject g = players[i].player.gameObject;

                    Camera cam = Camera.main;

                    float dist = (float)Math.Round(Utils.getDistance2D(g.transform.position), 0);
                    if (dist <= 150)
                    {
                        g_player.Add(g);
                    }
                }
            }
            for (int i = 0; i < g_player.Count; i++)
            {
                GameObject g = g_player[i];
                int radius = (int)Utils.getDistance2D(g.transform.position);
                angley = (float)Math.Round(cam.transform.eulerAngles.y, 2);
                float o_x = (lp.transform.position.x - g.transform.position.x) * (150 / Settings.RadarRange);
                float o_z = (lp.transform.position.z - g.transform.position.z) * (150 / Settings.RadarRange);

                Vector2 newpoints = Utils.RotatePoint(new Vector2(o_x, o_z), new Vector2(0, 0), (double)angley);

                if (Settings.RadarStatic)
                {
                    s_x.Add((int)(-1 * o_x) + 150);
                    s_z.Add((int)(o_z) + 150);
                }
                else
                {
                    s_x.Add((int)(newpoints.x) + 150);
                    s_z.Add((int)(newpoints.y) + 150);
                }

            }
        }
    }
}
