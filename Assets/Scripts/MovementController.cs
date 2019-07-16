using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovementController : MonoBehaviour
{
	List<Tile> tiles;
	LevelManager levelManager;

    void Start()
    {
    	levelManager = GetComponent<LevelManager>();
        tiles = levelManager.tiles;
        print (tiles);
    }
    void FixedUpdate ()
    {
        tiles = levelManager.tiles;
    }


    void Update()
    {

    }

    public void Movement (float movementValue)
    {
        foreach (Tile t in tiles)
            t.MouvementLateral(movementValue);
    }
}
