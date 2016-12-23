using System;
using UnityEngine;
using SDG.Unturned;
using System.Collections.Generic;

namespace zoomy
{
    public class L_ESP : MonoBehaviour
    {
        SteamPlayer[] players;
        DateTime lastRendTime;
        List<Vector3[]> spines = new List<Vector3[]>();


        void Update()
        {
            if ((DateTime.Now - lastRendTime).TotalMilliseconds >= Settings.ESP.EspRefreshRate)
            {
                DoESPUpdate();
                lastRendTime = DateTime.Now;
            }
            
        }

        void DoESPUpdate()
        {
            if (Settings.HackEnabled && Settings.ESP.EspEnabled)
            {
                players = Provider.clients.ToArray();
                spines.Clear();

                for (int i = 0; i < players.Length; i++)
                {
                    if (players[i] != null && players[i].player != null && players[i].player.gameObject != null && players[i].player != Utils.getLocalPlayer())
                    {
                        GameObject g = players[i].player.gameObject;

                        Camera cam = MainCamera.instance;
                        
                        float dist = (float)Math.Round(Utils.getDistance(g.transform.position), 0);
                        if (dist <= Settings.ESP.EspRange)
                        {
                            if (Settings.ESP.Show.Names)
                            {

                            }
                            if (Settings.ESP.Show.Distance)
                            {

                            }
                            if (Settings.ESP.Show.Boxes)
                            {
                                Transform skeleton = g.GetComponent<PlayerAnimator>().thirdSkeleton;
                                Bounds b_spine = skeleton.FindChild("Spine").GetComponent<Collider>().bounds;


                                Vector3[] pts = new Vector3[8];

                                pts[0] = b_spine.min;
                                pts[1] = b_spine.max;
                                pts[2] = new Vector3(pts[0].x, pts[0].y, pts[1].z);
                                pts[3] = new Vector3(pts[0].x, pts[1].y, pts[0].z);
                                pts[4] = new Vector3(pts[1].x, pts[0].y, pts[0].z);
                                pts[5] = new Vector3(pts[0].x, pts[1].y, pts[1].z);
                                pts[6] = new Vector3(pts[1].x, pts[0].y, pts[1].z);
                                pts[7] = new Vector3(pts[1].x, pts[1].y, pts[0].z);

                                if (cam.WorldToScreenPoint(pts[0]).z > 0 && cam.WorldToScreenPoint(pts[1]).z > 0 && cam.WorldToScreenPoint(pts[2]).z > 0 && cam.WorldToScreenPoint(pts[3]).z > 0 && cam.WorldToScreenPoint(pts[4]).z > 0 && cam.WorldToScreenPoint(pts[5]).z > 0 && cam.WorldToScreenPoint(pts[6]).z > 0 && cam.WorldToScreenPoint(pts[7]).z > 0)
                                {
                                    Vector3[] pts2D = new Vector3[8];
                                    


                                    pts2D[0] = cam.WorldToScreenPoint(pts[0]);
                                    pts2D[1] = cam.WorldToScreenPoint(pts[1]);
                                    pts2D[2] = cam.WorldToScreenPoint(pts[2]);
                                    pts2D[3] = cam.WorldToScreenPoint(pts[3]);
                                    pts2D[4] = cam.WorldToScreenPoint(pts[4]);
                                    pts2D[5] = cam.WorldToScreenPoint(pts[5]);
                                    pts2D[6] = cam.WorldToScreenPoint(pts[6]);
                                    pts2D[7] = cam.WorldToScreenPoint(pts[7]);



                                    //Get them in GUI space
                                    for (int j = 0; j < pts2D.Length; j++)
                                    {
                                        pts2D[j].y = Screen.height - pts2D[j].y;
                                    }


                                    spines.Add(pts2D);
                                }
                            }
                            if (Settings.ESP.Show.Bones)
                            {

                            }
                            if (Settings.ESP.Show.Chams)
                            {

                            }
                            if (Settings.ESP.Show.Glow)
                            {

                            }
                        }
                    }
                }
            }
        }

        void OnGUI()
        {
            DoESPGUI();
        }

        void DoESPGUI()
        {
            if (Settings.HackEnabled && Settings.ESP.EspEnabled)
            {
                
                if (Settings.ESP.Show.Names)
                {

                }
                if (Settings.ESP.Show.Distance)
                {

                }
                if (Settings.ESP.Show.Boxes)
                {
                    for (int i = 0; i < spines.Count; i++)
                    {
                        Utils.DrawHBox3D(spines[i], Color.red, 1);
                    }
                }
                if (Settings.ESP.Show.Bones)
                {

                }
                if (Settings.ESP.Show.Chams)
                {

                }
                if (Settings.ESP.Show.Glow)
                {

                }
            }
        }
    }
}
