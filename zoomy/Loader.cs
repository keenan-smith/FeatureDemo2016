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
        public static M_Radar MenuRadar;
        public static L_Radar LibRadar;
        public static M_RearView MenuRearView;
        public static L_RearView LibRearView;

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
                        MenuRadar = HookObject.AddComponent<M_Radar>();
                        LibRadar = HookObject.AddComponent<L_Radar>();
                        MenuRearView = HookObject.AddComponent<M_RearView>();
                        LibRearView = HookObject.AddComponent<L_RearView>();
                        DontDestroyOnLoad(HookObject);
                        DontDestroyOnLoad(MainMenu);
                        DontDestroyOnLoad(MenuRadar);
                        DontDestroyOnLoad(LibRadar);
                        DontDestroyOnLoad(MenuRearView);
                        DontDestroyOnLoad(LibRearView);
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