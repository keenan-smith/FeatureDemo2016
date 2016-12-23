using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;
using SDG.Unturned;
using Steamworks;

namespace zoomy
{
    public static class EditorGUITools
    {

        private static readonly Texture2D backgroundTexture = Texture2D.whiteTexture;
        private static readonly GUIStyle textureStyle = new GUIStyle { normal = new GUIStyleState { background = backgroundTexture } };

        public static void DrawRect(Rect position, Color color, GUIContent content = null)
        {
            var backgroundColor = GUI.backgroundColor;
            GUI.backgroundColor = color;
            GUI.Box(position, content ?? GUIContent.none, textureStyle);
            GUI.backgroundColor = backgroundColor;
        }

        public static void LayoutBox(Color color, GUIContent content = null)
        {
            var backgroundColor = GUI.backgroundColor;
            GUI.backgroundColor = color;
            GUILayout.Box(content ?? GUIContent.none, textureStyle);
            GUI.backgroundColor = backgroundColor;
        }
    }

    public static class Utils
    {
        static Texture2D lineTex;
        public static void DrawLine(Vector2 pointA, Vector2 pointB, Color color, float width)
        {
            var matrix = GUI.matrix;
            if (!lineTex)
            {
                lineTex = new Texture2D(1, 1);
                lineTex.SetPixel(0, 0, Color.white);
                lineTex.Apply();
            }
            var savedColor = GUI.color;
            GUI.color = color;
            var angle = Vector2.Angle(pointB - pointA, Vector2.right);
            if (pointA.y > pointB.y) { angle = -angle; }
            GUIUtility.RotateAroundPivot(angle, pointA);
            GUI.DrawTexture(new Rect(pointA.x, pointA.y, (pointB - pointA).magnitude, width), lineTex);
            GUI.matrix = matrix;
            GUI.color = savedColor;
        }

        public static void DrawHBox(Vector2 min, Vector2 max, Color color, float width)
        {
            Vector2 p1 = new Vector2(min.x, min.y);
            Vector2 p2 = new Vector2(min.x, max.y);
            Vector2 p3 = new Vector2(max.x, min.y);
            Vector2 p4 = new Vector2(max.x, max.y);
            DrawLine(p1, p2, color, width);
            DrawLine(p2, p3, color, width);
            DrawLine(p3, p4, color, width);
            DrawLine(p4, p1, color, width);
        }

        public static void DrawHBox3D(Vector3[] pts, Color color, float width)
        {
            DrawLine(pts[0], pts[2], color, width);
            DrawLine(pts[2], pts[6], color, width);
            DrawLine(pts[6], pts[4], color, width);
            DrawLine(pts[4], pts[0], color, width);

            DrawLine(pts[1], pts[5], color, width);
            DrawLine(pts[5], pts[3], color, width);
            DrawLine(pts[3], pts[7], color, width);
            DrawLine(pts[7], pts[1], color, width);

            DrawLine(pts[0], pts[3], color, width);
            DrawLine(pts[1], pts[6], color, width);
            DrawLine(pts[2], pts[5], color, width);
            DrawLine(pts[4], pts[7], color, width);
        }

        public static bool noWall(Transform ver, float distance = Mathf.Infinity)
        {
            return !Physics.Linecast(Camera.main.transform.position, ver.transform.position, RayMasks.DAMAGE_CLIENT);
        }

        public static Player getLocalPlayer()
        {
            return Player.player;
        }

        public static float getDistance(Vector3 point)
        {
            return Vector3.Distance(Camera.main.transform.position, point);
        }

        public static float getDistance2D(Vector3 point)
        {
            return Vector2.Distance(Camera.main.transform.position, point);
        }

        public static bool getLookingAt(out RaycastHit result, float distance = Mathf.Infinity)
        {
            return Physics.Raycast(getLocalPlayer().look.aim.position, getLocalPlayer().look.aim.forward, out result, distance);
        }

        public static bool aContains(Array a, object b)
        {
            return Array.IndexOf(a, b) > -1;
        }

        public static ulong getPlayerID(Player p)
        {
            return Array.Find(Provider.clients.ToArray(), a => a.player == p).playerID.steamID.m_SteamID;
        }

        public static SteamPlayer getSteamPlayer(ulong id)
        {
            return Array.Find(Provider.clients.ToArray(), a => a.playerID.steamID.m_SteamID == id);
        }

        public static SteamPlayer getSteamPlayer(string name)
        {
            return Array.Find(Provider.clients.ToArray(), a => a.playerID.playerName == name || a.playerID.nickName == name || a.player.transform.name == name);
        }

        public static SteamPlayer getSteamPlayer(Player p)
        {
            return Array.Find(Provider.clients.ToArray(), a => a.player == p);
        }

        public static SteamPlayer getSteamSemi(string name)
        {
            return Array.Find(Provider.clients.ToArray(), a => a.player.transform.name.Contains(name));
        }

        public static SteamPlayer getSteamPlayer(CSteamID id)
        {
            return Array.Find(Provider.clients.ToArray(), a => a.playerID.steamID == id);
        }

        public static Player getPlayer(string name)
        {
            return Array.Find(Provider.clients.ToArray(), a => a.playerID.playerName == name || a.playerID.nickName == name || a.player.transform.name == name).player;
        }
        public static Vector2 RotatePoint(Vector2 pointToRotate, Vector2 centerPoint, double angleInDegrees)
        {
            double angleInRadians = angleInDegrees * (Math.PI / 180);
            double cosTheta = Math.Cos(angleInRadians);
            double sinTheta = Math.Sin(angleInRadians);
            return new Vector2((int)(cosTheta * (pointToRotate.x - centerPoint.x) - sinTheta * (pointToRotate.y - centerPoint.y) + centerPoint.x), (int)(sinTheta * (pointToRotate.x - centerPoint.x) + cosTheta * (pointToRotate.y - centerPoint.y) + centerPoint.y));
        }
        public static string Vector3ToString(Vector3 vec)
        {
            string strin = "X: " + vec.x + ", Y: " + vec.y + ", Z: " + vec.z;
            return strin;
        }
    }
}
