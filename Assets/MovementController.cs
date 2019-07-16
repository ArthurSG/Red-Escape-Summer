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
        if (tiles[0] != null)
    	   tiles[0].transform.position = new Vector3 (tiles[0].transform.position.x + movementValue,0,0);
    }
}
