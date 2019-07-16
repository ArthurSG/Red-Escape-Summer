using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelManager : MonoBehaviour
{

	public float size;
	public List<Tile> tiles;


    void Start()
    {
    	tiles = new List<Tile>();
    }

    void Update()
    {
        
    }

    public void AddChild (Tile t)
    {
    	tiles.Add(t);
    	print("tile ajoutée");
    }

    public void SupprChild(Tile t)
    {
    	foreach (Tile tile in tiles)
    		if(tile == t){
    			tiles.Remove(tile);
    			print("tile spprimée");
    			break;
    		}
    }
}
