using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelManager : MonoBehaviour
{
    void Start()
    {

    }

    public void TileArrived(GameObject tileArrived)
    {
        string tileType = GetTileToSpawn();
        TilePool.instance.SpawnTileRow(tileType, tileArrived.transform.parent.position);
    }

    string GetTileToSpawn()
    {
        return "Random";
        if (GameManager.instance.IsGameRunning())
            return "Random";
        else return "Default";
    }
}
