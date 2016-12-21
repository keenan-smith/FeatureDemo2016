﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zoomy
{
    public static class Settings
    {
        public static bool HackEnabled { get; set; } = false;
        public static bool InMenu { get; set; } = false;

        // Radar Settings
        public static bool InRadarMenu { get; set; } = false;
        public static bool RadarEnabled { get; set; } = false;
        public static int RadarRefreshRate { get; set; } = 10;
        public static int RadarRange { get; set; } = 60;

        // Rear View Settings
    }
    public static class WID
    {
        public static int MainMenu = 0;
        public static int RadarMenu = 1;
    }
}
