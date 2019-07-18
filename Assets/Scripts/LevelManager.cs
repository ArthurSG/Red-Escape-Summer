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
        if (GameManager.instance.IsGameRunning())
        {
            if (GameManager.instance.GetScore() % 60 <= 30)
                return "Forest";
            else return "Rocks";
        }
        else return "Default";
    }
}
