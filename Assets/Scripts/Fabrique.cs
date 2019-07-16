using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Fabrique : MonoBehaviour
{
    private int NOMBRE_DE_TILE_LARGE = 5;           // nombre de tiles à instancier sur une même ligne
    private int NOMBRE_DE_TILE_LONG = 10;            // nombre de tiles instenciées sur la longueur 

    public GameObject modeleParDefaut;

    void Start()
    {
        int buffer = (int)-Mathf.Floor(NOMBRE_DE_TILE_LARGE / 2);

        for (int j = 0; j <= NOMBRE_DE_TILE_LONG; j++)
        {
            for (int i = 0; i < NOMBRE_DE_TILE_LARGE; i++)
            {
                GameObject tile = Instantiate(modeleParDefaut);
                tile.transform.position = new Vector3((buffer + i) * Tile.LARGEUR_TILE, 0, j * Tile.LONGUEUR_TILE);
                if (i == 0)
                    tile.gameObject.AddComponent<RespawnTile>();
            }
        }
    }


    public void TileInstantiate (GameObject t)
    {
        int buffer = (int) - Mathf.Floor(NOMBRE_DE_TILE_LARGE / 2);

        for (int i = 0; i < NOMBRE_DE_TILE_LARGE; i++)
        {
            GameObject tile = Instantiate(t);
            tile.transform.position = new Vector3((buffer + i) * Tile.LARGEUR_TILE, 0, NOMBRE_DE_TILE_LONG * Tile.LONGUEUR_TILE);
            if (i == 0)
                tile.gameObject.AddComponent<RespawnTile>();
        }
    }
}

