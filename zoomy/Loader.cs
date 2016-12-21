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
            //Loom.Initialize();
            thr = new Thread(new ThreadStart(Hook));
            thr.Start();
        }

        private static void Hook()
        {
            while (true)
            {
                Thread.Sleep(1000);
                if (HookObject == null || MainMenu == null)
                {
                    HookObject = new GameObject();
                    MainMenu = HookObject.AddComponent<M_Main>();
                    DontDestroyOnLoad(MainMenu);

                    MenuRadar = HookObject.AddComponent<M_Radar>();
                    LibRadar = HookObject.AddComponent<L_Radar>();
                    MenuRearView = HookObject.AddComponent<M_RearView>();
                    LibRearView = HookObject.AddComponent<L_RearView>();

                    DontDestroyOnLoad(MenuRadar);
                    DontDestroyOnLoad(LibRadar);
                    DontDestroyOnLoad(MenuRearView);
                    DontDestroyOnLoad(LibRearView);
                }
                Thread.Sleep(5000);
            }
        }
    }
}
