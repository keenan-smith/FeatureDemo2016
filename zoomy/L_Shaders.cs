using UnityEngine;
using SDG.Unturned;
using System.Collections.Generic;

namespace zoomy
{
    public static class L_Shaders
    {
        public static void ListShaders()
        {
         
            foreach(Shader shader in Settings.shaders)
            {
                console.log("Shader: " + shader.name);
            }

            foreach(Material material in Settings.materials)
            {
                console.log("Material: " + material.name);
            }
        }
    }
}