using UnityEngine;
using SDG.Unturned;
using System.Collections.Generic;

namespace zoomy
{
    public class L_Shaders
    {
        void Start()
        {
            Settings.shaders = Settings.bundle.LoadAllAssets<Shader>();
         
            foreach(Shader shader in Settings.shaders)
            {
                console.log("Shader: " + shader.name);
            }
        }
    }
}