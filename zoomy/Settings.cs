using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zoomy
{
    public static class Settings
    {
        public static bool HackEnabled { get; set; } = true;
        public static bool InMenu { get; set; } = false;
        public static AssetBundle bundle { get; set; } = null;
        public static Shader[] shaders { get; set; }

        // Radar Settings
        public static class Radar
        {
            public static bool InRadarMenu { get; set; } = false;
            public static bool RadarEnabled { get; set; } = false;
            public static bool RadarStatic { get; set; } = true;
            public static int RadarRefreshRate { get; set; } = 10;
            public static int RadarRange { get; set; } = 60;
        }

        // Rear View Settings
        public static class RearView
        {
            public static bool InRearViewMenu { get; set; } = false;
            public static bool RearViewEnabled { get; set; } = false;
        }

        // Console Settings
        public static class Console
        {
            public static bool InConsoleMenu { get; set; } = false;
            public static List<string> logtext = new List<string>();
        }

        // ESP Settings
        public static class ESP
        {
            public static bool InEspMenu { get; set; } = false;
            public static bool EspEnabled { get; set; } = false;
            public static int EspRefreshRate { get; set; } = 50;
            public static int EspRange { get; set; } = 1000;
            public static class Show
            {
                public static bool InMenu { get; set; } = false;
                public static bool Boxes { get; set; } = false;
                public static bool Names { get; set; } = false;
                public static bool Bones { get; set; } = false;
                public static bool Chams { get; set; } = false;
                public static bool Distance { get; set; } = false;
                public static bool Glow { get; set; } = false;
            }
            public static class Glow
            {
                public static bool InMenu { get; set; } = false;
                public static bool Player { get; set; } = false;
                public static bool Zombie { get; set; } = false;
                public static bool Vehicle { get; set; } = false;
                public static bool Storage { get; set; } = false;
                public static bool Turret { get; set; } = false;
                public static bool Bed { get; set; } = false;
                public static bool Generator { get; set; } = false;
            }

        }
    }
    public static class WID
    {
        public static int MainMenu = 0;
        public static int RadarMenu = 1;
        public static int Radar = 2;
        public static int RearViewMenu = 3;
        public static int RearCam = 4;
        public static int ConsoleMenu = 5;
        public static int EspMenu = 6;
        public static int EspShowMenu = 7;
        public static int EspGlowMenu = 8;
    }
}
