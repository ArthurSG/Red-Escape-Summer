using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TilePool : MonoBehaviour
{
    public static TilePool instance;

    private int NOMBRE_DE_TILE_LARGE = 10;           // nombre de tiles à instancier sur une même ligne
    private int NOMBRE_DE_TILE_LONG = 5;           // nombre de tiles instenciées sur la longueur 

    public List<GameObject> defaultPrefabs;
    public List<GameObject> forestPrefabs;
    public List<GameObject> rocksPrefabs;    


    List<Tile> poolForestTile;
    List<Tile> poolRocksTile;
    List<Tile> poolDefaultTile;
    
    void Start()
    {
        CreateInstance();

        poolRocksTile = new List<Tile>();
        poolDefaultTile = new List<Tile>();
        poolForestTile = new List<Tile>();
        SpawnDefaultTiles();
        SpawnRocksTiles();
        SpawnForestTiles();
    }

    void SpawnDefaultTiles()
    {
        for (int j = 0; j < NOMBRE_DE_TILE_LONG + 5; j++)
        {
            for (int i = 0; i < NOMBRE_DE_TILE_LARGE; i++)
            {
                GameObject tile = Instantiate(defaultPrefabs[0]);
                tile.GetComponent<Tile>().tileType = "Default";

                if (j < NOMBRE_DE_TILE_LONG)
                {
                    tile.transform.position = new Vector3((- NOMBRE_DE_TILE_LARGE / 2 + i) * Tile.LARGEUR_TILE, 0, (j  + 0.6f) * Tile.LONGUEUR_TILE);
                }
                else
                {
                    RegisterTile(tile.GetComponent<Tile>());
                }
            }
        }

    }

    void SpawnRocksTiles()
    {
        int tilesToSpawn = NOMBRE_DE_TILE_LARGE * (NOMBRE_DE_TILE_LONG + 5);
        while (poolRocksTile.Count < tilesToSpawn)
        {
            for (int i = 0; i < rocksPrefabs.Count; ++i)
            {
                GameObject tile = Instantiate(rocksPrefabs[i]);
                tile.GetComponent<Tile>().tileType = "Rocks";
                RegisterTile(tile.GetComponent<Tile>());
            }
        }
    }

    void SpawnForestTiles()
    {
        int tilesToSpawn = NOMBRE_DE_TILE_LARGE * (NOMBRE_DE_TILE_LONG + 5);
        while (poolForestTile.Count < tilesToSpawn)
        {
            for (int i = 0; i < forestPrefabs.Count; ++i)
            {
                GameObject tile = Instantiate(forestPrefabs[i]);
                tile.GetComponent<Tile>().tileType = "Forest";
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
        tile.gameObject.SetActive(false);
        tile.gameObject.transform.position = Vector3.one * 1000;

        if (tile.tileType == "Rocks")
            poolRocksTile.Add(tile);
        else if (tile.tileType == "Forest")
            poolForestTile.Add(tile);
        else poolDefaultTile.Add(tile);
    }

    private GameObject GetTile(string tileType)
    {
        Tile tile = null;

       
        if (tileType == "Rocks")
        {
            int index = Random.Range(0, poolRocksTile.Count);

            tile = poolRocksTile[index];
            poolRocksTile.RemoveAt(index);
            return tile.gameObject;
        }

        if (tileType == "Forest")
        {
            int index = Random.Range(0, poolForestTile.Count);

            tile = poolForestTile[index];
            poolForestTile.RemoveAt(index);
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

