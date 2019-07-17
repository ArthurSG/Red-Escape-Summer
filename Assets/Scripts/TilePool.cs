using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TilePool : MonoBehaviour
{
    private int NOMBRE_DE_TILE_LARGE = 5;           // nombre de tiles à instancier sur une même ligne
    private int NOMBRE_DE_TILE_LONG = 10;           // nombre de tiles instenciées sur la longueur 

    public List<GameObject> tilePrefabs;            //Première -> tile par défaut (aucun obstacle)

    List<Tile> poolRandomTile;
    List<Tile> poolDefaultTile;

    public static TilePool instance;

    void Start()
    {
        CreateInstance();

        poolRandomTile = new List<Tile>();
        poolDefaultTile = new List<Tile>();
        SpawnDefaultTiles();
        SpawnRandomTiles();
    }

    void SpawnDefaultTiles()
    {
        for (int j = 0; j < NOMBRE_DE_TILE_LONG + 5; j++)
        {
            for (int i = 0; i < NOMBRE_DE_TILE_LARGE; i++)
            {
                GameObject tile = Instantiate(tilePrefabs[0]);
                tile.GetComponent<Tile>().tileType = "Default";

                if (j < NOMBRE_DE_TILE_LONG)
                {
                    tile.transform.position = new Vector3((- NOMBRE_DE_TILE_LARGE / 2 + i) * Tile.LARGEUR_TILE, 0, j * Tile.LONGUEUR_TILE);
                }
                else
                {
                    RegisterTile(tile.GetComponent<Tile>());
                }
            }
        }

    }

    void SpawnRandomTiles()
    {
        int tilesToSpawn = NOMBRE_DE_TILE_LARGE * (NOMBRE_DE_TILE_LONG + 5);
        while (poolRandomTile.Count < tilesToSpawn)
        {
            for (int i = 0; i < tilePrefabs.Count; ++i)
            {
                GameObject tile = Instantiate(tilePrefabs[i]);
                RegisterTile(tile.GetComponent<Tile>());
            }
        }
    }


    private void CreateInstance() {
        if (instance != null)
        {
            print("multiple instances de TilePool");
        }
        instance = this;
    }

    //Used in GenerationProcedurale.cs
    public void SpawnTileRow (string tileType, Vector3 lastTilePosition)
    {
        int buffer = (int) - Mathf.Floor(NOMBRE_DE_TILE_LARGE / 2);

        for (int i = 0; i < NOMBRE_DE_TILE_LARGE; i++)
        {
            GameObject tile = GetTile(tileType);
            EnableTile(tile.GetComponent<Tile>(), lastTilePosition, i - NOMBRE_DE_TILE_LARGE / 2);
        }
    }

    public void RegisterTile(Tile tile)
    {
        print("oui");
        tile.gameObject.SetActive(false);
        tile.gameObject.transform.position = Vector3.one * 1000;

        if (tile.tileType == "Random")
            poolRandomTile.Add(tile);
        else poolDefaultTile.Add(tile);
    }

    private GameObject GetTile(string tileType)
    {
        Tile tile = null;

       
        if (tileType == "Random")
        {
            int index = Random.Range(0, poolRandomTile.Count);

            tile = poolRandomTile[index];
            poolRandomTile.RemoveAt(index);
            return tile.gameObject;
        }

        if (tileType == "Default")
        {
            tile = poolDefaultTile[0];
            poolDefaultTile.RemoveAt(0);
        }
        return tile.gameObject;
    }

    private void EnableTile(Tile tile, Vector3 lastTilePosition, int indexInRow)
    {
        tile.gameObject.transform.position = new Vector3(GetShipCoor() + indexInRow * Tile.LARGEUR_TILE, 0, lastTilePosition.z + NOMBRE_DE_TILE_LONG * Tile.LONGUEUR_TILE);
        tile.gameObject.SetActive(true);
    }

    float GetShipCoor()
    {
        float positionAvatar = GameManager.instance.avatar.transform.position.x;

        //déterminer au dessus de quel tile il est
        float X = Mathf.Round(positionAvatar / Tile.LARGEUR_TILE);

        return X * Tile.LARGEUR_TILE;
    }
}

