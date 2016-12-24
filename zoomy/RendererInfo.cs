using System;
using UnityEngine;
using SDG.Unturned;

namespace zoomy
{
	public class RendererInfo : MonoBehaviour
	{
        public Renderer renderer;
        public int ID;
        public Material[] materials;

        public RendererInfo(Renderer rend)
        {
            this.renderer = Renderer.Instantiate(rend);
            this.ID = rend.GetInstanceID();
            this.materials = rend.materials;
        }
	}
}
