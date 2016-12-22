using System;
using System.Threading;
using UnityEngine;
using SDG.Unturned;

namespace zoomy
{
    public class Loader : MonoBehaviour
    {
        public static Thread thr = null;
        public static GameObject HookObject = null;
        public static M_Main MainMenu = null;
        public static M_Radar MenuRadar = null;
        public static L_Radar LibRadar = null;
        public static M_RearView MenuRearView = null;
        public static L_RearView LibRearView = null;
        public static M_Console Console = null;

        public static void StartThread()
        {
            thr = new Thread(new ThreadStart(Hook));
            thr.Start();
        }

        private static void Hook()
        {
            while (true)
            {
                Thread.Sleep(1000);
                if (HookObject == null)
                {
                    HookObject = new GameObject();
                    MainMenu = HookObject.AddComponent<M_Main>();
                    DontDestroyOnLoad(MainMenu);

                    MenuRadar = HookObject.AddComponent<M_Radar>();
                    LibRadar = HookObject.AddComponent<L_Radar>();
                    MenuRearView = HookObject.AddComponent<M_RearView>();
                    LibRearView = HookObject.AddComponent<L_RearView>();
                    Console = HookObject.AddComponent<M_Console>();

                    DontDestroyOnLoad(MenuRadar);
                    DontDestroyOnLoad(LibRadar);
                    DontDestroyOnLoad(MenuRearView);
                    DontDestroyOnLoad(LibRearView);
                    DontDestroyOnLoad(Console);
                }
                Thread.Sleep(5000);
            }
        }
    }
}
