using System;
using System.Threading;
using UnityEngine;
using SDG.Unturned;

namespace zoomy
{
    public class Loader : MonoBehaviour
    {
        public static Thread thr;
        public static GameObject HookObject = null;
        public static M_Main MainMenu;

        public static void StartThread()
        {
            try
            {
                thr = new Thread(new ThreadStart(Hook));
                thr.Start();
                UnityEngine.Debug.Log("Ran thread successfully");
            }
            catch (Exception x)
            {
                UnityEngine.Debug.Log("ERROR START\n" + x + "\nERROR END");
            }
        }

        private static void Hook()
        {
            try
            {
                while (true)
                {
                    Thread.Sleep(1000);
                    if (HookObject == null)
                    {
                        UnityEngine.Debug.Log("Attempting Injection...");
                        HookObject = new GameObject();
                        MainMenu = HookObject.AddComponent<M_Main>();
                        DontDestroyOnLoad(HookObject);
                        Debug.Log("Injection Successful!");
                    }
                    Thread.Sleep(5000);
                }
            }
            catch (Exception ex)
            {
                UnityEngine.Debug.Log("Injection Failed!");
                UnityEngine.Debug.LogException(ex);
            }
        }
    }
}