using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tile : MonoBehaviour
{
    public static int LONGUEUR_TILE = 100;
    public static int LARGEUR_TILE = 100;

    public string tileType = "Random";

    void FixedUpdate()
    {
        //Move backwards
        this.transform.position = new Vector3(transform.position.x, transform.position.y, transform.position.z - GameManager.instance.GetSpeed());

        //If i'm too far behind, destroy
        if (transform.position.z <= -LONGUEUR_TILE)
            TilePool.instance.RegisterTile(this);
    }
}
