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
        DateTime lastCRendTime;
        List<Vector3[]> spines = new List<Vector3[]>();
        bool ChamsEnabled = true;


        void Update()
        {
            if ((DateTime.Now - lastRendTime).TotalMilliseconds >= Settings.ESP.EspRefreshRate)
            {
                DoESPUpdate();
                lastRendTime = DateTime.Now;
            }
            if ((DateTime.Now - lastCRendTime).TotalMilliseconds >= Settings.ESP.ChamRefreshRate)
            {
                DoChamUpdate();
                lastCRendTime = DateTime.Now;
            }

        }
        bool IsBackupAsset(Shader shader)
        {
            return Array.Exists(Settings.ESP.backups_Asset.ToArray(), a => a == shader);
        }

        Shader GetBackupAsset(Shader shader)
        {
            Shader ret_shader = Array.Find(Settings.ESP.backups_Asset.ToArray(), a => a == shader);
            return ret_shader;
        }

        void DoChamUpdate()
        {
            if (Settings.HackEnabled && Settings.ESP.EspEnabled)
            {
                if (Settings.ESP.Show.Chams)
                {
                    EnableChams();
                    if (!ChamsEnabled)
                    {
                        ChamsEnabled = true;
                    }
                }
            }
        }
        void EnableChams()
        {
            for (int i = 0; i < players.Length; i++)
            {
                if (players[i] != null && players[i].player != null && players[i].player.gameObject != null && players[i].player != Utils.getLocalPlayer())
                {
                    GameObject g = players[i].player.gameObject;


                    Renderer[] renderers = g.GetComponentsInChildren<Renderer>();
                    
                    foreach (Material material in renderers[0].materials)
                    {
                        if (!IsBackupAsset(material.shader))
                        {
                            Settings.ESP.backups_Asset.Add(material.shader);
                        }
                        material.shader = Settings.shaders[0];
                        console.log(g.name + " | " + 0 + " | " + material.name);
                    }
                }
            }
        }

        void DisableChams()
        {
            for (int i = 0; i < players.Length; i++)
            {
                if (players[i] != null && players[i].player != null && players[i].player.gameObject != null && players[i].player != Utils.getLocalPlayer())
                {
                    GameObject g = players[i].player.gameObject;

                    Renderer[] renderers = g.GetComponentsInChildren<Renderer>();
                    for (int j = 0; j < renderers.Length; j++)
                    {
                        foreach (Material material in renderers[j].materials)
                        {
                            if (IsBackupAsset(material.shader))
                            {
                                material.shader = Settings.ESP.backups_Asset[0];
                            }
                        }
                    }
                }
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
                            }
                            if (Settings.ESP.Show.Bones)
                            {

                            }
                            if (Settings.ESP.Show.Glow)
                            {

                            }
                        }
                    }
                }
            }
            else
            {
                if(ChamsEnabled)
                { 
                DisableChams();
                ChamsEnabled = false;
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
                }
                if (Settings.ESP.Show.Bones)
                {

                }
                if (Settings.ESP.Show.Glow)
                {

                }
            }
        }
        public void DoChams()
        {
            Settings.ESP.Show.Chams = !Settings.ESP.Show.Chams;
            players = Provider.clients.ToArray();
            if (Settings.ESP.Show.Chams)
            {
                EnableChams();
            }
            else
            {
                DisableChams();
            }
        }
    }
}
